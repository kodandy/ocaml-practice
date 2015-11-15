# レコード

# 復習

組
タプル

# レコードの必要性

引数に代入するときも、作る時も、組（タプル）だと順番を覚えておかなければならない。

```
(*名前と点数をタプルで表現すると... *)
("asai", 70) ;;

```

データによっては、順番が必要ではなく、名前と点数であることを表現する必要がある。

# レコード

レコードは名前の付いたデータの集まり。

```
(*名前と点数と成績をレコードで表現すると...*)
{name = "asai" ; tensuu = 70 ;  seiseki = "B"} ;;
```

# レコードの構文

```
{名前１ = 値１ ; 名前２ = 値２ ; ...}
```

```
(*例*)
{name = "asai" ; tensuu = 70 ;  seiseki = "B"} ;;

```
名前のことをフィールドという。

フィールドの順番は関係ない。

```
{seiseki = "B" ; name = "asai" ; tensuu = 70 ;  } ;;
```

フィールドが無い（または新しいフィールだがある）と別のデータ型になり、エラーになる。

```
{ name = "asai"  } ;;

{name = "asai" ; tensuu = 70 ;  seiseki = "B" , sinntyou = 165} ;;

```

エラーの内容 : 「レコードのフィールドで指定されていないものがある」等


# レコードとパターンマッチ

レコードでも組と同様にパターンマッチが使える。

```
{ フィールド1 : パターン変数1 ;
  フィールド2 : パターン変数2 ...}
```

```
let tuuchi gakusei =
              match gakusei with
                    {name = n ; tensuu = t ; seiseki = s} ->
                                      n ^ " さん \n "
                                      ^ "点 : " ^ string_of_int t ^ " \n "
                                      ^ "成績 : " ^ s ^ " \n" ;;

tuuchi {seiseki = "B" ; name = "asai" ; tensuu = 70 ;  } ;;

```

```
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

```

# その他の記法、この本の方針

##パターンに使う変数名は、フィールド名と同じでも構わない。
パターンの変数の名前を考えるのが面倒で、かつ混同しないのであらば便利な方法。

```
{name = name ; tensuu = tensuu ; seiseki = seiseki}
```

##パターンの場合、不要なフィールドを省略することが出来る

```
{name = n ; tensuu = t}
```

```
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
```

##「レコード.フィールド」でレコードから値を取り出せる。

```
let asai = {name = "asai" ; tensuu = 70 ;  seiseki = "B"};;

asai.name ;;

asai.tensuu ;;

{name = "asai" ; tensuu = 70 ;  seiseki = "B"}.name;;
```

-----

本書ではこれらの記法は使わない。
フィールド名とパターン変数を同じにする方法を使わないのは、混同の恐れから。  
読みやすさが損なわれるなら、別の名前をつかう。
フィールドの省略。  
本体を作ってみないと、省略出来るかできるかわからない。デザインレシピとの齟齬。
列挙しておくことの利点をとる。  
ドットを使ったフィールドアクセス。  
デザインレシピの優先から

#ユーザによる型定義

レコードを使うときには、必ず自分で新しい型をつくり、ocamlにフィールド名を教える必要がある。

型の定義方法は
```
type 新しく定義する型の名前 = その型の定義
```

```
type gakusei_t {
      name : string ;
      tensuu : int ;
      seiseki : string ;
}

```

レコードの型は

```
{ フィールド1 : 型1 ; フィールド２ : 型2 ; ...}
```
フィールド名は小文字で始める
フィールド名は重なってはいけない

本書はtのプリフィクスはわかりやすさのためつけている

##問題8.1

本に関する情報を格納するレコード型book_tを定義せよ。
book_tには
タイトル
著者名
出版社
値段
ISBN をもつとする。

```
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
  tanzyoubi : tanzyoubi_t ;
  ketuekigata : string
}
```
# データ定義に対するデザインレシピ

入出力データにレコードが出てくる場合。あらかじめレコードの型を定義しておく必要がある。
入力データの型はプログラムの構造に大きな影響を与えるので型の定義、データの定義をきちんとするのは重要です。

新しい項目「データ定義」

データ定義
入力データの型、出力データの型を考える。もしそれらが構造を持つならその方を定義する。
他の型に埋め込んでしまうことの無いようにする、意味のあるかたまりに対して１つの型を定義するのが望ましいプログラミングスタイル

復習「テンプレート」
テンプレート
入力（の一部が）構造データの場合は、その中身を取り出すmatch 文を作り、その際必ずテストプログラムを実行し、match文があっていることを確認する。


-------



hyoukaは学生データを受け取る。
学生データを表す型が必要。
学生データは整数、文字列、複数の要素を含む。
レコード型を選択。

```
(* 学生一人分のデータ （名前、点数、成績）を表す型*)
type gakusei_t {
       name : string ;   (*名前*)
       tensuu : int ;      (*点数*)
       seiseki : string ; (*成績*)
}
```
コメントで　何を定義しているのか　を先頭に書く。
各フィールド何を意味しているのかも書く。　わかりやすさが違う。
中身を想像しやすいようにする。

目的

テスト

テンプレート

本体

##問題

# 駅名と駅間の情報の定義

```
(*  駅名データ*)
type ekimei_t = {
      kanji : string ;  (*漢字名*)
      kana : string ; (*かな名*)
      romaji : string ; (*ローマ字名*)
      shozoku : string ; (*所属路線名*)
}

(*駅名の表示*)
(* ekimei_t -> string *)
let hyouji ekimei =
          match ekimei with
                {kanji = kanji ; kana = kana ; romaji = r ; shozoku = shozoku} ->
                       shozoku ^ ", " ^ kanji ^ "(" ^ kana  ^ ")" ;;

hyouji {kanji = "茗荷谷" ; kana = "みょうがだに"; romaji = "myougadani" ; shozoku = "丸ノ内線"} ;;
let hyoujiTest = hyouji {kanji = "茗荷谷" ; kana = "みょうがだに"; romaji = "myougadani" ; shozoku = "丸ノ内線"} = "丸ノ内線, 茗荷谷(みょうがだに)";;

(* 駅と駅の接続情報 *)
type ekikan_t = {
    kiten : string ; (*起点の駅名*)
    shuten : string ; (*終点の駅名*)
    keiyu : string; (*経由する路線名*)
    kyori : float ; (*距離　km*)
    jikan : int ; (*時間　分*)
}
```
