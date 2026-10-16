type 'a regexp = 
  Vide 
  | Epsilon
  | L of 'a
  | Union of 'a regexp * 'a regexp
  | Concat of 'a regexp * 'a regexp
  | Etoile of 'a regexp

let rec miroir = function
  Vide -> Vide
  | Epsilon -> Epsilon
  | L a -> L a 
  | Union(e1, e2) -> Union(miroir e1, miroir e2) 
  | Concat(e1, e2) -> Concat(miroir e2, miroir e1)
  | Etoile e -> Etoile (miroir e)
