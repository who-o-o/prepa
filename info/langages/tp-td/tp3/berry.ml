type 'a regexp =
    | Vide | Epsilon | L of 'a
    | Union of 'a regexp * 'a regexp
    | Concat of 'a regexp * 'a regexp
    | Etoile of 'a regexp

let fusion u v = 
  let rec aux u v acc = match u, v with 
  | [], v -> v @ acc
  | u, [] -> u @ acc
  | p1::q1, p2::q2 when p1 = p2 -> aux q1 q2 (p1::acc)
  | p1::q1, p2::q2 -> if p1 < p2 then aux q1 v (p1::acc) else aux q2 u (p2::acc)
in List.rev (aux u v [])

let rec est_vide exp = match exp with 
| Vide -> true
| L a -> false
| Epsilon -> false
| Union(e1, e2) -> (est_vide e1) && (est_vide e2)
| Concat(e1, e2) -> (est_vide e1) || (est_vide e2)
| Etoile e -> false

let rec a_epsilon exp = match exp with
| Vide -> false
| Epsilon -> true
| L a -> false
| Union(e1, e2) -> (a_epsilon e1) || (a_epsilon e2)
| Concat(e1, e2) -> (a_epsilon e1) && (a_epsilon e2)
| Etoile e -> true

(*Pour les 2 fonctions : 
C(n) = 2C(n-1)
<=> C(n) = 2^nC(0)
<=> La complexité est en O(2^n)*)

let rec p exp = 
  if est_vide exp 
  then []
  else 
    match exp with 
    | L a -> [a]
    | Union(e1, e2) -> fusion (p e1) (p e2)
    | Concat(e1, e2) -> if not (a_epsilon e1) then p e1 else fusion (p e1) (p e2) 
    | Etoile e -> p e
    | _ -> []

let rec s exp = 
  if est_vide exp 
  then []
  else 
    match exp with 
    | L a -> [a]
    | Union(e1, e2) -> fusion (s e1) (s e2)
    | Concat(e1, e2) -> if not (a_epsilon e2) then s e2 else fusion (s e2) (s e1) 
    | Etoile e -> s e
    | _ -> []

let produit l1 l2 = 
  let rec aux elmt list acc = match list with 
  | [] -> acc 
  | p::q -> aux elmt q ((elmt, p)::acc)
  in let rec aux2 l1 l2 acc = match l1 with 
  | [] -> acc 
  | p::q -> aux2 q l2 ((aux p l2 [])@acc)
  in List.rev (aux2 l1 l2 [] )

let rec f exp = match exp with 
| Vide -> []
| Epsilon -> []
| L a -> []
| Concat(e1,e2) -> (f e1) @ (f e2) @ (produit (s e1) (p e2))
| Union(e1, e2) -> (f e1) @ (f e2)
| Etoile e -> (f e) @ (produit (s e) (p e))

let rec n_lettres exp = match exp with 
| Vide -> 0
| Epsilon -> 0 
| L a -> 1 
| Union(e1, e2) -> (n_lettres e1) + (n_lettres e2)
| Concat(e1, e2) -> (n_lettres e1) + (n_lettres e2)
| Etoile e -> n_lettres e




let lineariser1 exp = 
    let n = n_lettres exp in 
    let hash = Hashtbl.create n in  
    let rec aux exp = match exp with
    | Vide -> Vide 
    | Epsilon -> Epsilon
    | L a -> if Hashtbl.mem hash a
             then 
              begin
                let i = Hashtbl.find hash a in 
                Hashtbl.replace hash a (i+1);
                L(a, i)
              end
            else
              begin
                Hashtbl.add hash a 2; 
                L (a, 1)
              end
    | Union(e1, e2) -> Union(aux e1, aux e2)
    | Concat(e1, e2) -> Concat(aux e1, aux e2)
    | Etoile e -> Etoile (aux e)
    in aux exp 

let lineariser exp =  
    let rec aux exp i= match exp with
    | Vide -> Vide 
    | Epsilon -> Epsilon
    | L a -> L(a, i)
    | Union(e1, e2) -> Union(aux e1 i, aux e2 (i+(n_lettres e1)))
    | Concat(e1, e2) -> Concat(aux e1 i, aux e2 (i+(n_lettres e1)))
    | Etoile e -> Etoile (aux e i)
    in aux exp 1

(*let rec remplir_hash exp = match exp with 
    | Vide -> ()
    | Epsilon -> ()
    | L a -> if Hashtbl.mem hash a
             then 
                let i = Hashtbl.find hash a in 
                Hashtbl.replace hash a (i+1);
             else
                Hashtbl.add hash a 1
    | Union(e1, e2) -> remplir_hash e1; remplir_hash e2 
    | Concat(e1, e2) -> remplir_hash e1; remplir_hash e2
    | Etoile e -> remplir_hash e
    in remplir_hash exp;*)

type 'a automate = {
    delta : 'a list array array;
    finaux : bool array;
}

let glushkov exp = 
  let e = lineariser exp in 
  let pe = p e in 
  let se = s e in 
  let fe = f e in 
  let n = n_lettres e in 
  let finaux = Array.make (n+1) false in 
  let rec aux_finaux l = match l with
  | [] -> ()
  | p::q -> finaux.(snd p) <- true; aux_finaux q 
  in aux_finaux se;
  let delta = Array.make_matrix (n+1) (n+1) [] in 
  let rec aux_delta l = match l with
  | [] -> ()
  | ((a,b), (m,j))::q-> delta.(b).(j) <- m::(delta.(b).(j)); aux_delta q
  in aux_delta fe;
  let rec aux_pref pe = match pe with 
  | [] -> ()
  | (a,b)::q -> delta.(0).(b) <- [a]; aux_pref q
  in aux_pref pe;
  {delta=delta; finaux=finaux}

let e1 = Etoile(
  Concat(
    Etoile(L('b')), 
    Concat(
      L('a'),
      Concat(
        Etoile(L('b')),
        Concat(
          L('a'),
          Etoile(L('b'))
        )
      )
    )
  )
)