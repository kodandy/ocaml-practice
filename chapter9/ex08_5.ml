(* 駅名の情報を格納するレコード型 *) 
type ekimei_t = { 
  kanji   : string; (* 漢字の駅名 *) 
  kana    : string; (* 読み *) 
  romaji  : string; (* ローマ字 *) 
  shozoku : string; (* 所属路線名 *) 
} 
