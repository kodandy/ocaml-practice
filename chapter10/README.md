chapter10 再帰関数を使ったプログラミング
==================================

再帰関数を使ったプログラミングの紹介

## 10.1 関数のネスト
接頭語を返す関数`prefix`を補助関数`add_to_each`を使って作る。  
接頭語とは、先頭から任意の長さのところで切ったリストのこと。  
[1; 2; 3;]というリストの場合は、[1]と[1; 2;]と[1; 2; 3;]になる。  
`add_to_each`は接頭語のリストを受け取ったら、各接頭語の先頭にもう一つ要素を付け加える補助関数。

```ml
(* テスト *)
let test1 = add_to_each 1 []
                          = []
let test2 = add_to_each 1 [[2]] 
                          = [[1; 2]]
let test3 = add_to_each 1 [[2]; [2; 3]] 
                          = [[1; 2]; [1; 2; 3;]]
let test4 = add_to_each 1 [[2]; [2; 3]; [2; 3; 4]] 
                          = [[1; 2]; [1; 2; 3;]; [1; 2; 3; 4;]]
```

`prefix`は、リストを受け取りその接頭語のリストを返す。

```ml
(* テスト *)
let test5 = prefix [] = []
let test6 = prefix [1] = [[1]]
let test7 = prefix [1; 2]
                   = [[1]; [1; 2]]
let test8 = prefix [1; 2; 3; 4] 
                   = [[1]; [1; 2]; [1; 2; 3]; [1; 2; 3; 4]]
```

次に`add_to_each`のデザインレシピを作る。

```ml
(* 目的: 受け取ったlstの要素それぞれ先頭にnをくっつける *)
(* add_to_each : int -> int list list -> int list list *)
let  rec add_to_each n lst = match lst with
     [] -> []
  | first :: rest -> [] (* add_to_each n rest *)
```

つぎは本体を作る。  
空リストの場合は空リストを返せばよい。

```ml
(* 目的: 受け取ったlstの要素それぞれ先頭にnをくっつける *)
(* add_to_each : int -> int list list -> int list list *)
let  rec add_to_each n lst = match lst with
     [] -> []
  | first :: rest -> (n :: first) :: add_to_each n rest
```

`prefix`のデザインレシピをつくる。

```ml
(* 目的: 受け取ったlstの接頭語のリストを求める *)
(* prefix : int list -> int list list *)
let rec prefix lst = match lst with
    [] -> []
  | first :: rest -> [] (* prefix rest *)
```

本体の作成。

```ml
(* 目的: 受け取ったlstの接頭語のリストを求める *)
(* prefix : int list -> int list list *)
let rec prefix lst = match lst with
    [] -> []
  | first :: rest -> [first] :: add_to_each first prefix rest
```

Ocamlでは自分で定義した関数もOcamlにあらかじめ定義されている関数も使える。  
自分で定義した関数を使うときは、その関数がすでに定義されていることが必要。

---

### 問題 10.1
あらかじめ昇順に並んでいる整数のリストlstと整数nを受け取ったら、lstを前から順に見ていき、  
昇順となる位置にnを挿入したリストを返す関数`insert`っをデザインレシピにしたがって作れ。  
例えば、`insert [1; 3; 4; 7; 8] 5`は`[1; 3; 4; 5; 7; 8]`を返す。

### 問題 10.2
整数のリストを受け取ったら、それを昇順に整列したリストを返す関数`ins_sort`をデザインレシピにしたがって作れ。  
例えば、`ins_sort [5; 3; 8; 1; 7; 4]`は`[1; 3; 4; 5; 7; 8]`を返す。


ここで作成した関数は*挿入法*と呼ばれる整列アルゴリズムのひとつ。  
おおむね順番に並んでいるリストを整列するときには高速。

### 問題 10.3
`student_t`型のリストを受け取ったら、  
それを`score`フィールドの順に整列したリストを返す関数`sutudent_ sort`をデザインレシピにしたがってつくれ。

### 問題 10.4
問題8.3で定義した`persson_t`型のリストを受け取ったら、  
それを名前の順に整列したリストを返す関数`person_sort`をデザインレシピにしたがって作れ。



## 10.2 リストの中の最小値を求める関数

与えられた整数のリスト中から最小値を取り出す関数`minimum`  
空リストが与えられた場合は、エラーにするか`max_int`を返す場合の2通りが考えられる。  
どちらの方法が適切かは、状況によって変わる。

`max_int`はOcamlのint型で表せる最大の整数のこと。
逆に`min_int`は最小の整数を表す。
32ビットのコンピュータの場合は1,073,741,823と-1,073,741,823になる。

```ml
(* 目的：受け取ったlstの中の最小値を返す *)
(* minimum : int list -> int *)
let rec minimum lst = match lst with
    [] -> max_int
  | first :: rest ->
     if first <= minimum rest
     then first
     else minimum rest
```

空リストの場合に`max_int`を返すと常に`max_int`が`first`より大きい（または等しい）ため都合がいい。
しかし欠点は入力リストの要素がすべて`max_int`だった場合と入力が空リストだった場合を区別できない点。

---

### 問題 10.5
`student_t`型のリストを受け取ったら、  
その中から最高得点をとった人のレコードを返す関数`sutdent_max`をデザインレシピにしたがって作れ。




## 10.3 局所変数定義

一度計算した値を保存し、再利用するには*局所変数*を使う。

```ml
let 変数名 = 式1 in 式2
```

局所定義された変数の有効範囲のことを*スコープ*とよぶ。
複数の変数を定義したい場合は`let`を入れ子にする。

```ml
let x = 3 in let y = 4 in x + y ;;
- : int = 7
```

`minimum`関数では2度`minimum rest`が呼ばれているので、  
局所定義変数をつかって`minimum`関数を書き直す。

```ml
(* 目的：受け取ったlstの中の最小値を返す *)
(* minimum : int list -> int *)
let rec minimum lst = match lst with
    [] -> max_int
  | first :: rest ->
     let min_rest = minimum rest in
     if first <= minimum rest
     then first
     else minimum rest
```

---

### 問題 10.6
問題 10.5でつくった関数を書きなおして同じ計算を2度することが無いようにせよ。


## 10.4 パターンマッチつき局所変数定義

局所変数定義とパターンマッチを同時に行うには、`let`の後にパターンを記載する。

```ml
let パターンマッチ = 式1 in 式2
```

---

### 問題10.7 
問題8.3で定義した関数のリストを受け取ったら、  
各血液型の人が何人いるかを組にして返す関数をデザインレシピにしたがって作れ。

### 問題10.8
`person_t`型のデータリストを受け取ったら、  
4つの血液型のうち最も人数の多かった血液型を返す関数をデザインレシピにしたがって作れ。




## 10.5 ふたつのリストを結合する関数

```ml
(* 目的：lst1とlst2を受け取り、それらを結合したリストを返す *)
(* append : 'a list -> 'a list -> 'a list *)
let rec append lst1 lst2 = match lst1 with
    [] -> lst2
  | first :: rest -> first :: append rest lst2
```

関数`append`はあらかじめ`List.append`という名前でOcamlに定義されている。  
略記法は、`@`。`lst1 @ lst2`とかくと`lst1`と`lst2`を結合したリストを表す。  
`::`とは違い、`@`の左右は対称。どちらにもリストがくる。



## 10.6 ふたつの昇順に並んだリストをマージする関数

```ml
(* 目的：昇順に並んでいるリストlst1とlst2をマージする *)
(* merge : int list -> int list -> int list *)
let rec merge lst1 lst2 = match (lst1, lst2) with
    ([], []) -> []
  | ([], first2 :: rest2) -> lst2
  | (first1 :: rest1, []) -> lst1
  | (first1 :: rest1, first2 :: rest2) ->
      if first1< first2
      then first1 :: merge rest1 lst2
      else first2 :: merge lst1 rest2
```

---

### 問題10.9
ふたつのリストを受け取ってきたら、それらの長さを同じかどうか判定する関数をデザインレシピにしたがって作れ。  
（関数lengthは使わずに作成せよ。)

## 10.7 駅名・駅間のリストからの情報の取得

/metro/station.ml 参照

---

### 問題10.10
ローマ字の駅名と駅名リストを受け取ったら、園駅の漢字表記を文字列で返す関数をデザインレシピにしたがって作れ。

### 問題10.11
漢字の駅名ふたつと駅間リストを受け取ったら、  
駅間リストの中からその2駅間の距離を返す関数をデザインレシピにしたがって作れ。

### 問題10.12
ローマ字の駅名ふたつを受け取ってきたら、その間の距離を調べ、直接つながっている場合は、  
「A駅からB駅までは◯kmです。」という文字列、  
つながっていなければ「A駅とB駅はつながっていません」という文字列を返す関数をデザインレシピにしたがって作れ。
