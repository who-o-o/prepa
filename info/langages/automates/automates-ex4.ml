type automate = {
initiaux : int list;
finaux: int list;
delta: (int*char, int list) Hashtbl.t
}


let rec etape a etats lettre = match etats with 
| []->[]
| e::q -> let t = (e,lettre) in 
  if Hashtbl.mem a.delta t 
    then (Hashtbl.find a.delta t) @ (etape a q lettre) 
else etape a q lettre

let accepte a mot = 
  let etats = ref a.initiaux in 
  for i = 0 to String.length mot -1 do 
    etats := etape a (!etats) mot.[i]
  done;
  List.exists (fun e -> List.mem e a.finaux) !etats