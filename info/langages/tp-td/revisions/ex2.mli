type 'a arb = V | N of 'a * 'a arb * 'a arb
val infixe : 'a arb -> 'a list
