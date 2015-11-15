type gakusei_t = {
      name : string ;
      tensuu : int ;
      seiseki : string ;
} ;;

(*名前と点数と成績をレコードで表現すると...*)
{ name = "asai" ; tensuu = 70 ;  seiseki = "B"} ;;

(*例*)
{name = "asai" ; tensuu = 70 ;  seiseki = "B"} ;;

{seiseki = "B" ; name = "asai" ; tensuu = 70 ;  } ;;

(* { name = "asai"  } ;; *)
(*
{name = "asai" ; tensuu = 70 ;  seiseki = "B" , sinntyou = 165} ;; *)

let tuuchi gakusei =
              match gakusei with
                    {name = n ; tensuu = t ; seiseki = s} ->
                                      n ^ " さん \n "
                                      ^ "点 : " ^ string_of_int t ^ " \n "
                                      ^ "成績 : " ^ s ^ " \n" ;;

tuuchi {seiseki = "B" ; name = "asai" ; tensuu = 70 ;  } ;;

(*レコードを返す例*)
(*gakusei_t -> gakusei_t*)
let addHyouka gakusei =
              match gakusei with
                  {name = n ; tensuu = t ; seiseki = s}  ->
                         { name = n ;
                           tensuu = t ;
                           seiseki = if t >= 80 then "A"
                                              else if t >= 70 then "B"
                                              else if t >= 60 then "C" else "D"} ;;

addHyouka {name = "asai" ; tensuu = 70 ;  seiseki = ""} ;;


tuuchi (addHyouka {name = "asai" ; tensuu = 70 ;  seiseki = ""} )


(*レコードを返す例2*)
(*gakusei_t -> gakusei_t*)
let addHyouka2 gakusei =
              match gakusei with
                  {name = n ; tensuu = t ; seiseki = s}  ->
                         { name = n ;
                           tensuu = t ;
                           seiseki = if t >= 80 then "A"
                                              else if t >= 70 then "B"
                                              else if t >= 60 then "C" else "D"} ;;

let asai = {name = "asai" ; tensuu = 70 ;  seiseki = "B"};;

asai.name ;;

asai.tensuu ;;

{name = "asai" ; tensuu = 70 ;  seiseki = "B"}.name;;


type book_t = {
  title : string ;
  tyosya : string ;
  syuppansya : string ;
  nedann : int ;
  isbn : string ;
}

type day_t = {day :int ; year : int ; month : int}

type okozukai_t = {
  name : string ;
  basyo : string ;
  day : day_t
}

type tanzyoubi_t = {month:int;day:int}

type person_t = {
  sintyou : float ;
  taizyuu : float ;
  tanzyoubi : tanzyoubi_t

}
