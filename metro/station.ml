(* 駅名データ *)
type ekimei_t = {
    kanji   : string; (*漢字名*)
    kanai   : string; (*かな名*)
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
let rec romaji_to_kanji station_name ekimei_t = match station_name with
    "" -> ""
  | {kanji = kanji; kana = kana; romaji = romaji; shozoku = shozoku;} as first :: rest ->
      if station_name = romaji
      then kanji
      else romaji_to_kanji station_name rest

(* テスト *)
let test1 romaji_to_kanji "akasaka" global_ekimei_list = "赤坂"
let test2 romaji_to_kanji "ginza" global_ekimei_list = "銀座"
let test3 romaji_to_kanji "ueno" global_ekimei_list = "上野"

(* ------------------- *)
(* 問題10.11 *)
(* 目的：漢字の駅名ふたつ（文字列）と駅間リスト（ekikan_t list型）を受け取ったら駅間リストの中から2駅間の距離を返す *)
(* romaji_to_kanji : string -> string -> ekikan_t list -> string *)
let rec get_ekikan_kyori station_now station_next global_ekikan_list = match 


(* ------------------- *)
(* 問題10.12 *)
