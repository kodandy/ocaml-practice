# 第9章リスト

# 9.1リストの構造

**リストの定義**

同じ型のデータが任意の個数,並んだデータ

**レコードとの違い**

- リスト:同じ型のデータが任意の個数,並んだデータ
- レコード:レコードは名前の付いたデータの集まり(Ｃ言語の構造体と同じようなデータ構造)

**記述方法**

- 空のリストは**[]**と書く
- リストの先頭に要素を付け加えるには**::**という命令を使う(consコンス)

**例**

```ml
"日曜日" :: "月曜日" :: "火曜日" :: "水曜日" :: "木曜日" :: "金曜日" :: "土曜日" :: []
"日曜日" :: ("月曜日" :: ("火曜日" :: ("水曜日" :: ("木曜日" :: ("金曜日" :: ("土曜日" :: [])))))
```

**曖昧性のない定義方法**

空リストは[]はリストである
firstが要素,restがリストならfirst::restもリストである

**再帰的なデータ型(自己参照をするデータ型)**

自分自身を使って定義されたデータ型

##問題9.1
春、夏、秋、冬の4の文字列からなるリストを作れ

```ml
"春" :: "夏" :: "秋" :: "冬" :: []
```

##問題9.2
各人の名前,身長(m),体重(kg),誕生日(月と日)と血液型の情報を格納する長さ3のリストを作れ

```ml
"各人の名前" :: ("身長(m)" :: "体重(kg)" :: ("誕生日(月)" :: "誕生日(日)" :: []) :: []) :: "血液型" :: []
```

# 9.2リストの構文と型

**記述方法2**

```ml
[要素1; 要素2; ・・・ 要素n;]
```

**実行例1**

[1, 2, 3]を定義する.

```ml
# 1 :: 2 :: 3 :: []
- : int list = [1; 2; 3]
#
```
```ml
# [1; 2; 3;] ;;
- : int list = [1; 2; 3]
#
```
```ml
# 1 :: [2; 3;] ;;
- : int list = [1; 2; 3]
#
```
```ml
# 1 :: 2 :: [3] ;;
- : int list = [1; 2; 3]
#
```

**実行例2**

真偽値のリストを定義する.

```ml
# [true; false; true] ;;
- : bool list = [true; false; true]
#
```

**実行例3**

bool listを定義する

```ml
# [] ;;
- : 'a list = []
#
```

**実行例4**

変数lstに整数リストを代入する

```ml
# let lst = [1; 2; 3; 4; 5;];;
var lst : int list = [1; 2; 3; 4; 5;]
#
```

**実行例5**

リストのリストを定義

```ml
# [[1; 3]; [2]; [4; 1; 3; 5;]; []; [2; 5;]] ;;
- : int list list = [[1; 3]; [2]; [4; 1; 3; 5;]; []; [2; 5;]]
#
```

##問題9.3
春、夏、秋、冬の4の文字列からなるリストを要素を書き並べる方法で作れ

```ml
["春"; "夏"; "秋"; "冬" ] ;;
```

# 9.3リストとパターンマッチ

**組みやレコードにおけるパターンマッチの記述方法(復習)**

```ml
match 式 with 
     パターン -> 式
```

**一般的なパターンマッチの方法**

```ml
match 式 with 
     パターン1 -> 式1
     |パターン2 -> 式2
     |...
     |パターンn -> 式1n
```

**実行例1**

```ml
# match [] with
    [] -> 0
    | first :: rest -> first ;;
- : int = 0
#
```

**実行例2**

```ml
# match [1; 2; 3] with
    [] -> 0
    | first :: rest -> first ;;
- : int = 1
#
```

**実行例3**

パターンマッチをするmatch文を書くときに,空のリストの場合とそうでない場合の両方のパターンを書かないとWarningが出る

```ml
# match [1; 2; 3] with
    | first :: rest -> first ;;
Warning: this patten-matching that is not exhaustive.
Here is an example of a value that is not matched:
[]
- : int = 1
#
```

**実行例4**

パターンマッチをするmatch文を書くときに,書いていないパターンを書くと例外となる

```ml
# match [] with
    first :: rest -> first ;;
Warning: this patten-matching that is not exhaustive.
Here is an example of a value that is not matched:
[]
Exception: Match_failure (-6, -21).
#
```


**実行例5**

漏れたパターンが一意に定まらないときは,忠告にWarningにワイルドカードが入る

```ml
# match [] with
    [] -> 0 ;;
Warning: this patten-matching that is not exhaustive.
Here is an example of a value that is not matched:
_::_
- : int = 0
#
```

**_**は,ワイルドカードを表す

# 9.4再帰関数

**関数contain_zeroの作成**

```ml
(*int listは
  - []            空リスト,或いは
  - first :: rest 最初の要素が first で残りのリストが rest
という形*)

(* 目的:受け取ったリストlstに0が含まれているかを調べる *)
(* contain_zoro : int list -> bool *)
let contain_zero lst = false

(* テスト *)
let test1 = contain_zero [] = false
let test2 = contain_zero [0; 2] = true
let test3 = contain_zero [1; 2] = false
let test4 = contain_zero [1; 2; 3; 0; 5; 6; 7] = false
let test5 = contain_zero [1; 2; 3; 4; 5; 6; 7] = true

(* 目的:受け取ったリストlstに0が含まれているかを調べる *)
(* contain_zero : int list -> bool *)
list rec contain_zero lst = match lst with
  [] -> false
  | first :: rest -> if first = 0 then true
                                  else contain_zero rest
```

**再帰関数**

```ml
再帰呼び出し:関数内で自分自身を呼び出すこと
再帰関数:再帰呼び出しを含む関数
```
定義方法

```ml
let recで定義する.
```

再帰関数の注意

```ml
無限ループに注意
```
無限ループを避けるには,

```ml
デザインレシピに従う！
再帰関数と再帰的データ呼び出しを１対１に！（構造に従った再帰という）
```

#9.5 再帰関数に対するデザインレシピ

**再帰関数に対するデザインレシピ**

1. データ定義:入力データ、出力データを考える.再帰的なデータ型があるか確認,自己参照をするかもチェック
2. 目的:作成する関数を考える.ヘッダを作成
3. 例:入力例と出力例を考える.
4. テンプレート:構造にあわせてmatch文を作成
5. 本体:関数を実際に作成（再帰関数の作成）
6. テスト:望むプログラムかどうかをチェック.バグがあったら1へ戻る

** 作成 **

```ml
(* 1.データ定義 *)
(*int listは
  - []            空リスト,或いは
  - first :: rest 最初の要素が first で残りのリストが rest(restが自己参照のケース)
という形*)

(* 2.目的 *)
(* 目的:受け取ったリストlstの各要素の和を求める *)
(* sum : int list -> int *)
let sum lst = 0

(* 3.例 *)
(* テスト *)
let test1 = sum []  = 0
let test2 = sum [2] = 2
let test3 = sum [1; 3] = 4
let test4 = sum [1; 2; 3; 4; 5; 6; 7; 8; 9; 10] = 55

(* 4.テンプレート *)
(* 目的:受け取ったリストlstの各要素の和を求める *)
(* sum : int list -> int *)
list sum lst = match lst with
  [] -> 0
  | first :: rest -> 0 (* sum rest *)

(* 5.本体 *)
(* 目的:受け取ったリストlstの各要素の和を求める *)
(* sum : int list -> int *)
list rec sum lst = match lst with
  [] -> 0
  | first :: rest -> first + sum rest

```

##問題9.4
整数のリストを受け取ったら,そのリストの長さを返す関数lengthをデザインレシピに従って作れ.

```ml
(* 1.データ定義 *)
(*int listは
  - []            空リスト,或いは
  - first :: rest 最初の要素が first で残りのリストが rest(restが自己参照のケース)
という形*)

(* 2.目的 *)
(* 目的:受け取ったリストlstの各要素の個数を求める *)
(* length : int list -> int *)
let length lst = 0

(* 3.例 *)
(* テスト *)
let test1 = length []  = 0
let test2 = length [1] = 1
let test3 = length [1; 2] = 2
let test4 = length [1; 2; 3; 4; 5; 6; 7; 8; 9; 10] = 10

(* 4.テンプレート *)
(* 目的:受け取ったリストlstの各要素の個数を求める *)
(* length : int list -> int *)
list length lst = match lst with
  [] -> 0
  | first :: rest -> 0 (* length rest *)

(* 5.本体 *)
(* 目的:受け取ったリストlstの各要素の個数を求める *)
(* length : int list -> int *)
list rec length lst = match lst with
  [] -> 0
  | first :: rest -> 1 + length rest

```

##問題9.5
整数のリストを受け取ったら,そのリストの偶数のみを返す関数evenをデザインレシピに従って作れ.

```ml
(* 1.データ定義 *)
(*int listは
  - []            空リスト,或いは
  - first :: rest 最初の要素が first で残りのリストが rest(restが自己参照のケース)
という形*)

(* 2.目的 *)
(* 目的:受け取ったリストlstの各要素の偶数のリストを求める *)
(* even : int list -> int list *)
let even lst = []

(* 3.例 *)
(* テスト *)
let test1 = even []     = []
let test2 = even [1]    = []
let test3 = even [1; 2] = [2]
let test4 = even [1; 2; 3; 4; 5; 6; 7; 8; 9; 10] = [2; 4; 6; 8; 10]

(* 4.テンプレート *)
(* 目的:受け取ったリストlstの各要素の偶数のリストを求める *)
(* even : int list -> int list *)
list even lst = match lst with
  [] -> []
  | first :: rest -> []

(* 5.本体 *)
(* 目的:受け取ったリストlstの各要素の偶数のリストを求める *)
(* even : int list -> int list *)
list rec even lst = match lst with
  [] -> []
  | first :: rest -> if first % 2 = 0 then (first :: []) :: even rest
                                      else even rest;

```

##問題9.6

文字リストを受け取ったら,その中の要素を前から順に全部くっつけた文字列を返す関数concatをデザインレシピに従って作れ.

```ml
(* 1.データ定義 *)
(*string listは
  - []            空リスト,或いは
  - first :: rest 最初の要素が first で残りのリストが rest(restが自己参照のケース)
という形*)

(* 2.目的 *)
(* 目的:受け取ったリストlstの各要素の文字列の連結を求める *)
(* concat : string list -> string *)
let concat lst = ""

(* 3.例 *)
(* テスト *)
let test1 = concat []       = ""
let test2 = concat ["1"]    = "1"
let test3 = concat ["あ"; "い"] = "あい"
let test4 = concat ["春"; "夏"; "秋"; "冬";] = "春夏秋冬"

(* 4.テンプレート *)
(* 目的:受け取ったリストlstの各要素の文字列の連結を求める *)
(* concat : string list -> string *)
list concat lst = match lst with
  [] -> ""
  | first :: rest -> ""

(* 5.本体 *)
(* 目的:受け取ったリストlstの各要素の文字列の連結を求める *)
(* concat : string list -> string *)
list rec concat lst = match lst with
  [] -> ""
  | first :: rest -> first ^ concat rest

```

#9.6 テンプレートの複合

入力が複雑な時のテンプレートを考える.

```ml
(* 学生ひとり分のデータ(名前,点数,成績)を表す型 *)
type gukusei_t = {
  names   : string; (* 名前 *)
  tensuu  : int;    (* 点数 *)
  seiseki * string; (* 成績 *)
}

(* gakusei_t list は
  - []            空リスト,あるいは
  - first :: rest 最初の要素が first で残りのリストが rest (first は gakusei_t 型, rest が自己参照のケース)
という形 *)

(* gakusei_t list 型のデータの例 *)
let lst1 = []
let lst2 = [{nemae = "asai"; tensuu = 70; seiseki = "B"}]
let lst3 = [{nemae = "asai"; tensuu = 70; seiseki = "B"}; {nemae = "kaneko"; tensuu = 85; seiseki = "A"}]
let lst4 = [{nemae = "yoshida"; tensuu = 80; seiseki = "A"}; {nemae = "asai"; tensuu = 70; seiseki = "B"}; {nemae = "kaneko"; tensuu = 85; seiseki = "A"}]

(* 目的:学生リストlstのうち成績がAの人の数を返す *)
(* count_A : gekusei_t list -> int *)
let count_A lst = 0

(* テスト *)
let test1 = count_A lst1 = 0
let test2 = count_A lst2 = 0
let test3 = count_A lst3 = 1
let test4 = count_A lst4 = 2

(* 目的:学生リストlstのうち成績がAの人の数を返す *)
(* count_A : gekusei_t list -> int *)
let count_A lst = match lst with
  [] -> 0
  | first :: rest -> (match first with
                        ({names = n; tensuu = t; seiseki = s} as first) :: rest
                        -> if s ="A" then 0 (* count_A rest *)
                                     else 0 (* count_A rest *)

(* 目的:学生リストlstのうち成績がAの人の数を返す *)
(* count_A : gekusei_t list -> int *)
let count_A lst = match lst with
  [] -> 0
  | ({names = n; tensuu = t; seiseki = s} as first) :: rest
                        -> if s ="A" then 1 + count_A rest (* count_A rest *)
                                     else count_A rest (* count_A rest *)
```

##問題9.7

各人の名前,身長(m),体重(kg),誕生日(月と日)と血液型を格納するレコード型person_t を宣言し、データリスト宣言したら,血液型がAの人を返す関数count_ketueki_Aをデザインレシピにしたがって作れ

```ml
(* 1.データ定義 *)
(* 学生ひとり分のデータ(名前,点数,成績)を表す型 *)
ype person_t = {
  sintyou : float ;
  taizyuu : float ;
  tanzyoubi : tanzyoubi_t ;
  ketuekigata : string
}

(* person_t list は
  - []            空リスト,あるいは
  - first :: rest 最初の要素が first で残りのリストが rest (first は person_t 型, rest が自己参照のケース)
という形 *)

(* 2.目的 *)
(* 目的:学生リストlstのうち成績がAの人の数を返す *)
(* count_ketueki_A : person_t list -> int *)
let count_ketueki_A lst = 0


(* 3.例 *)
let test1 = count_ketueki_A lst1 = 0
let test2 = count_ketueki_A lst2 = 0
let test3 = count_ketueki_A lst3 = 1
let test4 = count_ketueki_A lst4 = 2

(* 4.テンプレート *)
(* 目的:学生リストlstのうち成績がAの人の数を返す *)
(* count_ketueki_A : person_t list -> int *)
let count_ketueki_A lst = match lst with
  [] -> 0
  | first :: rest -> (match first with
                        ({sintyou = s; taizyuu = ty; tanzyoubi = tb; ketuekigata = k} as first) :: rest
                        -> if s ="A" then 0 (* count_ketueki_A rest *)
                                     else 0 (* count_ketueki_A rest *)

(* 5.本体 *)
(* 目的:学生リストlstのうち成績がAの人の数を返す *)
(* ount_ketueki_A : person_t list -> int *)
let count_ketueki_A lst = match lst with
  [] -> 0
  | first :: rest -> (match first with
                        ({sintyou = s; taizyuu = ty; tanzyoubi = tb; ketuekigata = k} as first) :: rest
                        -> if s ="A" then 0 (* count_ketueki_A rest *)
                                     else 0 (* count_ketueki_A rest *)
```
##問題9.8

#9.7 駅名リストと駅間リストの整備

test.mlに記載