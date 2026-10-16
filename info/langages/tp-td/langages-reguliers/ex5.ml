type 'a regexp = 
| Vide | Epsilon | L of 'a 
| Union of 'a regexp * 'a regexp
| Concat of 'a regexp * 'a regexp
| Etoile of 'a regexp

let rec f = function 
| Vide -> Vide
| Epsilon -> Epsilon
| L a -> Union(L 0, L 1)
| Union(a,b) -> Union(f a, f b)
| Concat(a,b) -> Union(Concat(a, f b), Concat(f a, b))
| Etoile a -> Union(Concat(Etoile a, Concat(f a, Etoile a)), Epsilon)


