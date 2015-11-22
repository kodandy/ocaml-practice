(* 駅間の情報を格納するレコード型 *) 
type ekikan_t = { 
  kiten  : string; (* 起点 *) 
  shuten : string; (* 終点 *) 
  keiyu  : string; (* 経由路線名 *) 
  kyori  : float;  (* 距離 *) 
  jikan  : int;    (* 所要時間 *) 
} 
