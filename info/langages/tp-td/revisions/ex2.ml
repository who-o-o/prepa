type 'a arb = V | N of 'a * 'a arb * 'a arb

let infixe arbre = 
  let rec parcours a acc = match a with
  | V -> acc
  | N(r, fg, fd) -> parcours fg (r :: parcours fd acc)
  in 
  parcours arbre []

(*ABR : arbre où pour tout noeud interne, il est plus grand que ts les noeuds de son sous arbre gauche (+petit, sous arbre droit)*)

let tas_of_abr a = 
  Array.of_list (infixe a)
let a = N(7, N(3, N(1, V, V), N(4, V, V)), N(10, N(9, V,V), N(11, V,V)))

let exchange t i j = 
  let temp = t.(i) in 
  t.(i) <- t.(j);
  t.(j) <- temp

let add t e = 
  let n = Array.length t in 
  let tab = Array.init (n+1) (fun x -> t.(x)) in 
  begin
    tab.(n) <- e;
    let i = ref n in 
    while (!i != 0 || tab.(!i) <= tab.((!i-1)/2)) do 
      exchange tab (!i) ((!i-1)/2)
    done
  end;
  tab
let take t =
  let n = Array.length t in
  let min = t.(0) in
  let tab = Array.init (n-1) (fun x -> t.(x+1)) in 
  exchange t (n-2) 0;
  let i = ref 0 in 
  while (!i != n-2 || tab.(!i) >= tab.(2*(!i)+1) || tab.(!i) >= tab.(2*(!i)+2)) do 
    if (t.(!i) >= tab.(2*(!i)+1))
    then exchange tab (!i) (2*(!i)+1)
    else exchange t (!i) (2*(!i)+2)
  done;  min, tab





























(*On remplace la racine par le dernier élément du tableau e. Soit i l'indice de la racine*)
(*tant que i != n, si e>2i+1 alors on les échanges, jusqu'à ce que i = n ou e < 2i+1 -> O(logn)*)
(*On append e en fin de liste à l'indice i, si e < floor(i-1/2) alors on échange les 2 jusqu'à ce que *)
(*e > floor(i-1/2) ou que e soit la racine, en O(logn)*)






