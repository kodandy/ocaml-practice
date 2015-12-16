(* 駅名データ *)
type ekimei_t = {
    kanji   : string; (*漢字名*)
    kana    : string; (*かな名*)
    romaji  : string; (*ローマ字名*)
    shozoku : string; (*所属路線名*)
}

(* 駅と駅の接続情報 *)
type ekikan_t = {
    kiten  : string; (*起点の駅名*)
    shuten : string; (*終点の駅名*)
    keiyu  : string; (*経由する路線名*)
    kyori  : float;  (*距離　km*)
    jikan  : int;    (*時間　分*)
}

#use "metro/station_list.ml"

(* ------------------- *)


(* 駅名の表示 *)
(* ekimei_t -> string *)
let hyouji ekimei =
    match ekimei with
    {kanji = kanji ; kana = kana ; romaji = r ; shozoku = shozoku} ->
        shozoku ^ ", " ^ kanji ^ "(" ^ kana  ^ ")";;

hyouji {
    kanji = "茗荷谷";
    kana = "みょうがだに";
    romaji = "myougadani";
    shozoku = "丸ノ内線"
};;

let hyoujiTest =
    hyouji {
        kanji = "茗荷谷";
        kana = "みょうがだに";
        romaji = "myougadani";
        shozoku = "丸ノ内線"
    } = "丸ノ内線, 茗荷谷(みょうがだに)";;


(* ------------------- *)
(* 問題10.10 *)
(* 目的：駅名（文字列）と駅名リスト（ekimei_t list型）を受け取り、駅名を漢字表記で返す *)
(* romaji_to_kanji : string -> ekimei_t list -> string *)
let rec romaji_to_kanji station_name global_ekimei_list = match global_ekimei_list with
    [] -> ""
  | {kanji = kanji; kana = kana; romaji = romaji; shozoku = shozoku;} :: rest ->
      if station_name = romaji
      then kanji
      else romaji_to_kanji station_name rest

(* テスト *)
let test1 = romaji_to_kanji "akasaka" global_ekimei_list = "赤坂"
let test2 = romaji_to_kanji "ginza" global_ekimei_list = "銀座"
let test3 = romaji_to_kanji "ueno" global_ekimei_list = "上野"

(* ------------------- *)
(* 問題10.11 *)
(* 目的：漢字の駅名ふたつ（文字列）と駅間リスト（ekikan_t list型）を受け取ったら駅間リストの中から2駅間の距離を返す *)
(* romaji_to_kanji : string -> string -> ekikan_t list -> string *)

let rec get_ekikan_kyori station_now station_next global_ekikan_list = match global_ekikan_list with
    [] -> infinity
  | {kiten = kiten; shuten = shuten; keiyu = keiyu; kyori = kyori; jikan = jikan} :: rest ->
        if kiten = station_now && shuten = station_next
        then kyori
        else if kiten = station_next && shuten = station_now
        then kyori
        else get_ekikan_kyori station_now station_next rest

(* テスト *)
let test1 = get_ekikan_kyori "乃木坂" "赤坂" global_ekikan_list = 1.1
let test2 = get_ekikan_kyori "霞ヶ関" "日比谷" global_ekikan_list = 1.2
let test3 = get_ekikan_kyori "乃木坂" "表参道" global_ekikan_list = 1.4
let test4 = get_ekikan_kyori "湯島" "神田" global_ekikan_list = infinity

(* ------------------- *)
(* 問題10.12 *)
(* ローマ字の駅名２つ受け取り、つながっている場合距離を表示、繋がっていない場合その旨を表示、駅名が存在しない場合その旨を表示。 *)
let rec kyori_wo_hyoji station_now station_next global_ekikan_list =
  let now_kanji = romaji_to_kanji station_now global_ekimei_list in
  let next_kanji = romaji_to_kanji station_next global_ekimei_list in
    match global_ekikan_list with
      [] -> station_now ^" " ^ station_next ^ "という駅は存在しません。"
    | {kiten = kiten; shuten = shuten; keiyu = keiyu; kyori = kyori; jikan = jikan} :: rest ->
          if kiten = now_kanji  then
          if shuten = next_kanji then
          now_kanji ^ "駅と" ^ next_kanji  ^"駅の距離は" ^ string_of_float  kyori ^ "kmです。"
          else
          now_kanji ^ "駅と" ^ next_kanji ^ "駅はつながっていません"
          else if kiten = next_kanji then
          if shuten = now_kanji then
          next_kanji ^ "と" ^ now_kanji ^ "の距離は" ^ string_of_float  kyori ^ "kmです。"
          else
          now_kanji ^ "駅と" ^ next_kanji ^ "駅はつながっていません"
          else
          kyori_wo_hyoji station_now station_next rest


let kyori_wo_hyojiTest1 = kyori_wo_hyoji "kasumigaseki" "hibiya" global_ekikan_list
let kyori_wo_hyojiTest2 = kyori_wo_hyoji "kasumigaseki" "test" global_ekikan_list
let kyori_wo_hyojiTest3 = kyori_wo_hyoji "test" "hibiya" global_ekikan_list
let kyori_wo_hyojiTest4 = kyori_wo_hyoji "test" "test" global_ekikan_list

(* 問題 12.1 *)

type eki_t = {
  namae : string ; (*駅名　漢字*)
  saitan_kyori : float ; (*最短距離　実数*)
  temae_list : string list ; (*駅名　漢字*)
}

(* 問題　12.2 *)
(* ekimei_t  list -> eki_t list*)
let rec make_eki_list global_ekimei_list =
        match global_ekimei_list with
                [] -> []
                | {kanji = kanji} :: rest ->
                    {namae= kanji; saitan_kyori = infinity ; temae_list = []}  ::  make_eki_list rest

let make_eki_listTest1 = make_eki_list global_ekimei_list

(* 問題　12.3 *)
(* 起点になる駅の名前を受け取り、eki_t_listを初期化する *)
let rec shokika kiten eki_t_list =
      match eki_t_list with
              [] -> []
              | ({namae = namae } as first) :: rest ->
                  let target =
                           if  namae = kiten then
                                    {namae = namae ; saitan_kyori = 0. ; temae_list = [kiten]}
                            else
                                    first
                  in target :: shokika kiten rest

let shokikaTest = shokika "池袋"  (make_eki_list global_ekimei_list)


(* let insert list =
          match list with
                  [] ->  *)
(* 問題12.4   *)
(* global_ekimei_listを受け取りひらがなの順に整列し、駅名の重複を取り除く *)
let seiretsu global_ekimei_list =
        let f {kana = kana1} {kana = kana2} = compare kana1 kana2 in
        List.sort f global_ekimei_list

(* 問題13.6 *)
(* 駅の例 *) 
let eki1 = {namae="池袋"; saitan_kyori = infinity; temae_list = []} 
let eki2 = {namae="新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]} 
let eki3 = {namae="茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]} 
let eki4 = {namae="後楽園"; saitan_kyori = infinity; temae_list = []} 
 
(* 目的：未確定の駅 q を必要に応じて更新した駅を返す *) 
(* koushin1 : eki_t -> eki_t -> eki_t *) 
let koushin1 p q = match (p, q) with 
  ({namae = pn; saitan_kyori = ps; temae_list = pt}, 
   {namae = qn; saitan_kyori = qs; temae_list = qt}) -> 
    let kyori = get_ekikan_kyori pn qn global_ekikan_list in 
    if kyori = infinity 
    then q 
    else if ps +. kyori < qs 
    then {namae = qn; saitan_kyori = ps +. kyori; temae_list = qn :: pt} 
    else q 
 
(* テスト *) 
let test1 = koushin1 eki3 eki1 = eki1 
let test2 = koushin1 eki3 eki2 = eki2 
let test3 = koushin1 eki3 eki3 = eki3 
let test4 = koushin1 eki3 eki4 = 
  {namae="後楽園"; saitan_kyori = 1.8; temae_list = ["後楽園"; "茗荷谷"]} 
let test5 = koushin1 eki2 eki1 = 
  {namae="池袋"; saitan_kyori = 3.0; temae_list = ["池袋"; "新大塚"; "茗荷谷"]} 
let test6 = koushin1 eki2 eki2 = eki2 
let test7 = koushin1 eki2 eki3 = eki3 
let test8 = koushin1 eki2 eki4 = eki4 

(* 問題13.7 *)
(* 目的：未確定の駅のリスト v を必要に応じて更新したリストを返す *) 
(* koushin : eki_t -> eki_t list -> eki_t list *) 
let koushin p v = 
  let f q = koushin1 p q in 
  List.map f v 
 
(* 駅の例 *) 
let eki1 = {namae="池袋"; saitan_kyori = infinity; temae_list = []} 
let eki2 = {namae="新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]} 
let eki3 = {namae="茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]} 
let eki4 = {namae="後楽園"; saitan_kyori = infinity; temae_list = []} 
 
(* 駅リストの例 *) 
let lst = [eki1; eki2; eki3; eki4] 
 
(* テスト *) 
let test1 = koushin eki2 [] = [] 
let test2 = koushin eki2 lst = 
 [{namae="池袋"; saitan_kyori = 3.0; temae_list = ["池袋"; "新大塚"; "茗荷谷"]}; 
  eki2; eki3; eki4] 