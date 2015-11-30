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
let rec kyori_wo_hyoji station_now station_next global_ekikan_list =
  let now_kanji = romaji_to_kanji station_now global_ekimei_list in
  let next_kanji = romaji_to_kanji station_next global_ekimei_list in
    match global_ekikan_list with
      [] -> station_now ^" " ^ station_next ^ "という駅は存在しません。"
    | {kiten = kiten; shuten = shuten; keiyu = keiyu; kyori = kyori; jikan = jikan} :: rest ->
          if kiten = now_kanji  then
                  if shuten = next_kanji then
                      now_kanji ^ "駅と"
                      ^next_kanji  ^"駅の距離は" ^ string_of_float  kyori ^ "kmです。"
                    else "A駅とB駅はつながっていません"
          else
          if kiten = now_kanji then
                  if shuten = next_kanji then
                     next_kanji ^ "と"
                     ^ now_kanji ^ "の距離は" ^ string_of_float  kyori ^ "kmです。"
                     else "A駅とB駅はつながっていません"
          else kyori_wo_hyoji station_now station_next rest

let kyori_wo_hyojiTest1 = kyori_wo_hyoji "kasumigaseki" "hibiya" global_ekikan_list 
(* let kyori_wo_hyojiTest2 =
let kyori_wo_hyojiTest3 =        *)
