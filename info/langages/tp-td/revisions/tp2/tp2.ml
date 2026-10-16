type afdc = {
    initial : int;
    finaux : int list;
    delta : int array array
}

let a1 = {
  initial = 0;
  finaux = [1];
  delta = [|[|1;0|];[|0;1|]|]
}

let a2 = {
  initial = 0;
  finaux = [2];
  delta = [|[|0;1|];[|1;2|];[|2;0|]|]
}

let a3 = {
  initial = 0;
  finaux = [1];
  delta = [|[|0;0|];[|1;1|]|]
}

let rec delta_etoile a q u = match u with 
| [] -> q
| p::r -> delta_etoile a (a.delta.(q).(p)) r 

let accepte a u = 
  List.exists (fun x -> x = delta_etoile a a.initial u) a.finaux

let complementaire a = 
  let ns = Array.length a.delta in 
  let nfinaux = ref [a.initial] in 
  for i = 0 to ns-1 do 
    if not(List.exists (fun x -> x = i) a.finaux) && (i <> a.initial)
      then nfinaux := i::(!nfinaux)
  done;
  let na = {
    initial = List.hd a.finaux;
    finaux = !nfinaux;
    delta = a.delta
  } in na



let accessible a = 
  let visites = Array.make (Array.length a.delta) false in 
  let accessibles = ref [a.initial] in 
  visites.(a.initial) <- true;
  let rec explore a s = 
    let n = Array.length (a.delta.(s)) in
    visites.(s) <- true;
    accessibles := s::(!accessibles);
    for j = 0 to n-1 do 
      let i = a.delta.(s).(j) in
      if not visites.(i) 
      then explore a i
    done
  in 
  explore a (a.initial); !accessibles

let vide a = 
  let access = accessible a in 
  let rec aux access fin = match access with 
  | [] -> true
  | p::q -> if (List.exists (fun x -> x = p) fin)
            then false
            else 
              aux q fin 
  in 
  aux access a.finaux

let produit e f= 
  let p = List.length f in
  let rec iter1 i f acc = match f with 
  | [] -> acc
  | j::q -> iter1 i q ((i*p+j)::acc)
  in 
  let rec iter2 e1 e2 acc = match e1 with 
  | [] -> acc
  | i::q -> iter2 q e2 (iter1 i e2 acc)
  in 
  iter2 e f []

