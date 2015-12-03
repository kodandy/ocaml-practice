let a = 3.0 ** 2.0

(*問題 11.1 ｎまでの二乗の和 *)
(* int ->int *)
let rec sum_of_square n =
              if n = 0 then
                  0
              else
                  n * n + sum_of_square ( n - 1 )


let sosTest1 =sum_of_square 4 = 30

(*問題 11.2 *)
let rec a n =
          if n = 0 then
                  3
          else
                2 *  a (n-1) -1

let aTest1 = a 0 = 3
let aTest1 = a 1 = 5
let aTest1 = a 2 = 9
let aTest1 = a 3 = 17
