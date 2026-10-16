type automate = {
  nb : int;
  init : int list;
  final : int list;
  trans : (int * char * int) list
}

let transpose a = 
  let rec aux t acc = match t with 
  | [] -> acc 
  | (q, a, qp)::m -> aux m ((qp, a, q)::acc)
  in  {nb = a.nb; init = a.final; final = a.init; trans = (aux a.trans [])}

let a1 = {
  nb = 3; init = [0]; final = [2];
  trans = [(0, 'a', 0); (0, 'a', 1); (0, 'b', 0);
  (1, 'b', 2); (2, 'a', 2)]
}

let palindrome s = 
  try 
    let n = String.length s in 
    for i = 0 to n/2 do 
      if s.[i] <> s.[n-1-i] 
        then raise Exit
    done; true
  with 
  | Exit -> false

    
let supprimer l = 
  let rec aux l deja_vu acc = match l with 
  | [] -> acc 
  | p::q -> if List.exists (fun x -> x = p) deja_vu 
            then aux q deja_vu acc 
            else 
              aux q (p::deja_vu) (p::acc)
  in List.rev (aux l [] [])

let pow = Array.make 21 1
let () =
  for i = 1 to 20 do
    pow.(i) <- pow.(i - 1) * 2
  done

let est_dans q k = 
  if k/pow.(q) = 1
  then true 
  else false 


