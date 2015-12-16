chapter13 一般化と公開関数
==================================

## 13.1 データの一般化

繰り返す操作を考えていく

```ml
(* 目的:学生リスト lst のうち成績が A の人の数を返す*)
(* count_A : gakusei_t list -> int *)
let rec count_A lst = match lst with
    [] -> 0
  | {namae = n; tensuu = t; seiseki = s} :: rest
    -> if s = "A" then 1 + count_A rest
                  else count_A rest
```

を一般化

```ml
(* 目的:学生リスト lst のうち成績が seiseki0 の人の数を返す*)
(* count_A : gakusei_t list -> string -> int *)
let rec count_A lst = match lst with
    [] -> 0
  | {namae = n; tensuu = t; seiseki = s} :: rest
    -> if s = seiseki0 then 1 + count rest seiseki0
                  else count rest seiseki0
```

入力データ

```ml
let lst4 = [{nemae = "yoshida"; tensuu = 80; seiseki = "A"}; {nemae = "asai"; tensuu = 70; seiseki = "B"}; {nemae = "kaneko"; tensuu = 85; seiseki = "A"}]
```

## 13.2 関数の一般化とmap

<dl>
<dt>高階関数</dt>
<dd>関数を引数として受け取る関数</dd>
<dd>関数を引数として受け取ること,関数を結果として返すことを　関数が <strong>　first-class の値である　</strong> という</dd>
</dl>

```ml
(* 目的:実数のリストlstを受け取り各要素の平方根のリストを返す *)
(* map_sqrt : float list -> float list *)
let rec map_sqrt lst = match lst with
    [] -> []
  | first :: rest -> sqrt first :: map_sqrt rest
```

```ml
(* 目的:実数のリストlstを受け取り成績を入れたリストを返す *)
(* map_hyouka : gakusei_t list -> gakusei_t list *)
let rec map_hyouka lst = match lst with
    [] -> []
  | first :: rest -> hyouka first :: map_hyouka rest
```

以下の高階関数を定義する

```ml
(* 目的:関数 f とリスト lst を受け取り f を施したリストを返す *)
(* map : ('a -> b') -> 'a list -> b list' *)
let rec map f lst = match lst with
    [] -> []
  | first :: rest -> f first :: map f rest
```

`map`は, 「リストのすべての要素に対して同じ処理をする関数」

ちなみに`OCaml`にはList.mapという関数が定義されている。

## 13.3 多相型と多相関数

<dl>
<dt> 多相性 </dt>
<dd> どのような型でもよい性質 </dd>
<dt> 多相型 </dt>
<dd> どのような型でも代入できる </dd>
<dt> 多相関数 </dt>
<dd> 多相型を含む関数 </dd>
</dl>

## 13.4 値としての関数
関数型言語においては,関数も数字と同じ値

数字の型

```ml
# 3 ;;
- : int = 3
#
```

関数の型

```ml
# sqrt ;;
- : float -> float = <fun>
#
```

合成関数の作成

```ml
# let twice7 f = f (f 7) ;;
val twice7 : (int -> int) -> int = <fun>
#
```

3を加える関数の作成

```ml
# let add3 x = x + 3 ;;
val add3 : int -> int = <fun>
#
```

twiice7 と add3の合成

```ml
# twice7 add3 ;;
- : int = 13
#
```

ちなみに逆は?

```ml
# add3 twice7 ;;
Characters 5-11:
  add3 twice7 ;;
       ^^^^^^
Error: This expression has type (int -> int) -> int
       but an expression was expected of type int
#
```

しっかりエラーとなる

## 13.5 関数を返す関数

<b>高階関数の返り値は関数を返せばいい</b>

twiceを高階関数化

```ml
# let twice f =
    let g x = f (f x)
    in g;;
val twice : ('a -> 'a) -> 'a -> 'a = <fun>
#
```

## 13.6 確定点に隣接する点の最短距離の更新

