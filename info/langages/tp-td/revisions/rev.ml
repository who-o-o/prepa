type ('k, 'v) hashtbl = {
  buckets: ('k * 'v) list array;
  size: int;
}

(* Create a hash table with n buckets *)
let create n =
  failwith "TODO"

(* Simple hash function for integers *)
let hash tbl key =
  failwith "TODO"

(* Add a key-value pair *)
let add tbl key value =
  failwith "TODO"