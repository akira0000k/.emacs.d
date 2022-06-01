# 簡単なEmacs 使用法

## 起動と終了

    $ emacs .
    . をパラメタとして指定、カレントディレクトリ 表示


      /home/user:
      used 352 available 53380644
      drwxr-xr-x   22 user   users        4096 Mar  4 18:06 .
      drwxrwsr-x    5 root   staff        4096 Feb 26 14:21 ..
      drwxr-xr-x    3 user   users        4096 Feb 26 11:37 .emacs.d
    -EEE:%%-F1  ~             6:27午後   (Dired by name)--L5--C58--Top----------------
    
    C-x C-c     Ctrl を押したまま x c  で終了する


## キー表記方法

    C-x    ....  Ctrl + x
    M-x    ....  Esc + x
    M-x    ....  Alt + x            (IME表示が 'あ' のときはだめ)
    S-x    ....  Shift + x
    s-x    ....  Command + x        (MAC)
    
    例
    C-g         ....  Ctrl + g  : 動作のキャンセル
    C-x d       ....  Ctrl + x  (Ctrlを放して) d  :  ディレクトリリスト表示(dired)
    C-x C-b     ....  Ctrlを押したまま x b  :  バッファリスト表示
    s-a         ....  全選択    (MAC)
    M-x shell   ....  Alt + x (Altを放して) "shell"  : 内部shell を表示

## 画面操作

        keybind
    標準        代替キー
     ↓           ↓
    C-x 2       f2, S-f2: 画面分割 上下 (一画面の時)
    C-x 3               : 画面分割 左右
    C-x 1       f2      : 現画面だけにする (分割されている時)
    C-x o       S-f1    : 画面移動
                S-f2    : 画面移動 (逆回り) (分割されている時)
    C-x o       C-Tab   : 画面移動
                C-S-Tab : 画面移動 (逆回り)
    C-x 0       S-f4    : カーソルのいる画面をひっこめる (分割されているとき)
                C-next  : バッファ切り替え 奥へ    (Ctrl + PageDown)
                C-prior : バッファ切り替え 戻る    (Ctrl + PageUp)
                f7      : 画面縮小 (分割されているとき)  M-x shrink-window
                f8      : 画面拡大 (分割されているとき)  M-x enlarge-window
    C-x C-b             : バッファリスト表示


## ファイルリストの表示 (dired)

    C-x d       S-f5    : ディレクトリリスト表示
    g           f5      : ディレクトリ表示更新
    p           up      : 前の行
    n           down    : 次の行
    f           right   : directory降下 または ファイルを開く
    ^           left    : directory上昇
    <                   : 前のdirectory行
    >                   : 次のdirectory行
    v                   : ファイルを見るだけ view(read only)
    +                   : ディレクトリ作成
                h       : ~/       ホームディレクトリ表示
                r       : /        ルートディレクトリ表示
                z       : emacsを起動したディレクトリ表示
     
              マークのついていないとき、単独ファイルに対して (大文字)
    D                   : ファイル削除
    C                   : ファイルcopy
    R                   : リネーム、移動
    S                   : シンボリックリンク 作成
    Y                   : 相対シンボリックリンク 作成
                H       : ヘキサモードでファイルを表示
    M                   : chmod
     
              マークをつけて、複数ファイルに対して実行
    d d d x             : 削除選択し実行
    ~     x             : (チルダx) ~付きバックアップファイルを全て選択し削除
    m m m D             : 複数選択し削除
    m m m C             : 複数選択し別directoryに copy
    m m m R             : 複数選択し別directoryに 移動
    m m m S             : 複数選択し別directoryに シンボリックリンクを作成
    m m m Y             : 複数選択し別directoryに 相対シンボリックリンクを作成
    m m m M             : 複数選択しchmod
    u                   : マークを消して下へ
    DEL                 : (Backspace) マークを消して上へ
    M-DEL               : (Alt + Backspace)  すべのマークを消す


## ファイルを開く

    C-x C-f             : ファイル名を指定して開く。なければ新ファイル作成
       Find file: ~/ <--- ファイル名入力

## ファイル編集の終了

                ←       : ファイルの先頭で 左に行こうとしたときは、編集の終了
    C-x k       f4      : 保存せずに終了
       Buffer newfile.txt modified; kill anyway? (yes or no) <--yes:すてる no:終了しない

    C-x C-w             : 名前を付けて保存
       Write file: ~/                     <----enter or ファイル名入力
       File `~/tempfile.txt' exists; overwrite? (y or n)     <----y:上書き  n:やめる
       Wrote /home/muji/tempfile.txt
    C-x C-s             : 上書き保存
       Wrote /home/muji/tempfile.txt


## カーソル移動

● Windows流
 
    →   ←   ↑   ↓   Home   End   PageUp  PageDown   Cntl+Home   Cntl+End

● MAC流

    C-f C-b C-p C-n  Command-left  Command-right  fn+up  fn+down  Command+up  Command+down

● emacs流    　　　　　　(bashと共通)

    C-n         down    : 一行下
    C-p         up      : 一行上
    C-f         right   : 一文字右
    C-b         left    : 一文字左
    C-a         home    : 行頭
    C-e         end     : 行末
    C-v                 : (旧来は下画面だが cua-paste)
    M-v                 : (旧来は上画面だが delete-selection-repeat-replace-region)
                prior   : 上画面     (PageUp)
                next    : 下画面     (PageDown)
                M-n     : 半画面上
                M-p     : 半画面下
                C-home  : バッファ先頭
                C-end   : バッファ末尾
    M-<         C-,     : バッファ先頭
    M->         C-.     : バッファ末尾
    M-f         C-right : 一語右
    M-b         C-left  : 一語左
                C-down  : 一行下へスクロール
                C-up    : 一行上へスクロール
                C-S-down: カーソルを画面の中、下、下画面
                C-S-up  : カーソルを画面の中、上、上画面

## 行の移動

                M-g M-g : 行番号を入力してその行に移動


## 検索

    C-s string          : インクリメンタルサーチ
    C-s C-k             : ミニバッファで入力
    C-s C-r             : 逆方向インクリメンタルサーチ  (旧来はC-r)
    C-s C-s     f3      : 再検索           C-s word C-s C-s ...
    C-s C-r     S-f3    : 逆方向に再検索    C-s C-r word C-r C-r ...
                C-r     : 置換
    C-s M-r             : 正規表現検索


## 書き込み

    ふつうにタイプします。viのようにモード切替はありません。
    テラタームの場合 日本語入力はWindows側のIMEで行うこともできます。 日本語モードだと
    Altキーを使うコマンドが利かないことがあるので注意。
     
    Insert             : 上書きモードになります .. Ovwrt と表示 (Windows)
    C-\                : emacs の日本語入力on-off


## 削除

    C-d         delete : Delete
    M-d                : 一語削除 (cut)
    C-h         DEL    : Backspace    (旧来はC-h はhelp)
    C-k                : カーソルより後を削除 (cut)
    C-/         C-z    : undo   (旧来はC-z はサスペンドだが、C-x C-z で行う)
    C-_                : undo
    C-x u              : undo
    C-g                : undo の中断   次からのundo は逆方向   (emacs すべての場面でキャンセルの意味がある)


## 選択

● ターミナルの機能

    マウスで選択--> copy されている
    右クリック  --> paste

● Emacsの機能 (旧来)

    C-space            : 選択開始　　　 (Mark Set と表示されます)
                         このあと カーソル移動で 選択領域が拡大します
    C-RET              : 矩形選択の開始 (cua mode)
                         このあと カーソル移動で 矩形選択領域が拡大します
    C-x h       s-a    : バッファ全選択
    C-g                : 選択解除

● Shiftキーをつかった選択 (最近風)

    S-left    S-right      S-C-left	 S-C-right
    S-up      S-down
    S-Home	  S-End	       S-C-Home	 S-C-End
    S-PageUp  S-PageDown
    C-S-b     C-S-f        M-S-b 	 M-S-f
    C-S-p     C-S-n
    C-S-a     C-S-e        C-<       C->
    M-S-p     M-S-n
    Shiftキーを放してカーソル移動すると選択解除


    選択された状態で
    C-w         C-x    : cut      (C-x cutは cua-mode)
    M-w         C-c    : copy して選択解除
    C-d         delete : 選択領域の削除
    C-g                : 選択解除
    C-y         C-v    : 選択領域を copyしたもので置き換え
	
    copy された状態で
    C-y         C-v    : paste    (旧来C-v はPageDown相当)


## 文字コードの指定

    M-x universal-coding-system-argument
    C-x RET c	f6 : コーディングシステムの指定をしてコマンドを実行する
    	
        Coding system for following command (default utf-8-unix): sjis-dos
        Command to execute with sjis-dos:    ここで C-x C-w などコマンド実行
     
    M-x set-buffer-file-coding-system
    C-x RET f          : 読み込みバッファ内コーディングシステムの変更
        Coding system for saving file (default iso-2022-jp): 
     
    文字コード→   UTF-8          PC 　        EUC            JIS       改行表示
     lf        utf-8-unix    sjis-unix   euc-jp-unix    junet-unix    :
     crlf      utf-8-dos     sjis-dos    euc-jp-dos     junet-dos    (DOS)
     cr        utf-8-mac     sjis-mac    euc-jp-mac     junet-mac    (Mac)
                  U             E           S               J              
     
      例
    [--]-EEE:---F1  main.cc        11:30AM 0.02 Mail   (C++)--L1--C0--Top-----
    [--]-EES:---F1  index.html     11:32AM 0.08 Mail   (HTML)--L1--C0--Top----
     
      注意  通常はファイルを読み込むときは文字コードを自動認識します。
            強制的に eucで読み込む (半角カナによる文字化け対策)
                f6 euc Enter C-x C-f filename
            EUC+cr で上書き保存
                f6 euc-jp-unix Enter C-x C-s


## 再表示

    C-l                 : recenter  画面がくずれたとき再表示させる。カーソル行が中に。


## いろいろなコマンド

    M-x diff            : ファイル比較
    M-x compile         : メークする
    M-x gdb             : デバッガの起動
    M-x grep            : ファイルから検索
    M-x grep-find       : ファイルから検索 - 下のディレクトリもふくめる
    M-x occur           : 表示中のファイル内を検索
    M-x shell           : シェルを起動。実行結果をファイルとして保存できる。
    M-x man             : Man page の表示。ファイルに保存できる。


## コマンドに与える数引数

    M-3 a               : aaa 入力
    C-u 3 a             : aaa 入力
    M-5 M-x occur       : 前後5行表示
    C-u 5 M-x occur     : 前後5行表示
    C-u -5 M-x occur    : 前5行表示
    C-u C-f             : 前へ4文字進む
    C-u C-u C-f         : 前へ16文字進む


## シェルの起動

    M-x shell      M-s  : シェル起動
    M-p             ↑   : history 前      シェルと違いアプリケーション入力中でも可
    M-n             ↓   : history 次      同上
    xx↑                 : xx で始まる history 前
    C-p                 : カーソル上
    C-n                 : カーソル下
    C-d                 : EOF (promptのところで)
    C-c C-c             : シェル中断


## 一時中断

    C-x C-z             : suspend         (旧来のC-z はundoとした)
    fg                  : (コマンド) シェルからEmacsに復帰する


## 終了

    C-x C-c             : emacs の終了


## 現在の function key 設定一覧

    M-x help    f1      : help
    C-x o       S-f1    : other screen
    C-x 2       f2      : devide screen toggle
    C-x 1       f2      : devide screen toggle
                S-f2    : devide screen or other screen(逆回り)
    C-s         f3      : re search forward
    C-s C-r     S-f3    : re search backward
    C-x k       f4      : kill buffer
    C-x 0       S-f4    : delete-window
    g           f5      : revert-buffer in dired mode
                f5      : revert-buffer in view mode
    M-x dirs    f5      : resync current directory stack (in shell mode)
    C-x d       S-f5    : dired
    C-x RET c   f6      : select coding system
                S-f6    : toggle electric indent mode
                f7      : shrink window
                f8      : enlarge window
                S-f7    : shrink window horizontally
                S-f8    : enlarge window horizontally
                f9      : describe key briefly      (旧来のf1 k)
                S-f9    : toggle case sensitive search
                f10     : rotate divided screen
                S-f10   : rotate divided screen reverse
                f11     : wrap line toggle
                f12     : line number toggle
                S-f11   : scroll right
                S-f12   : scroll left
     ↑           ↑
    標準        代替キー
        keybind


## help

    f1 a                : command-apropos    似たコマンド名表示
    f1 b                : describe-bindings
    f1 f                : describe-function
    f1 k<key>   f9<key> : describe-key       次に打つキーの説明 (よく使います)
    f1 m                : describe-mode
    f1 v                : describe-variable
    f1 w                : where-is
       ....
     
    f1                  : ヘルプメニューで選択
    You have typed , the help character.  Type a Help option:
    (Use SPC or DEL to scroll through this text.  Type q to exit the Help command.)
     
    a PATTERN   Show commands whose name matches the PATTERN (a list of words
                  or a regexp).  See also the ‘apropos’ command.
    b           Display all key bindings.
    c KEYS      Display the command name run by the given key sequence.
    C CODING    Describe the given coding system, or RET for current ones.
    d PATTERN   Show a list of functions, variables, and other items whose
                  documentation matches the PATTERN (a list of words or a regexp).
    e           Go to the *Messages* buffer which logs echo-area messages.
    f FUNCTION  Display documentation for the given function.
    F COMMAND   Show the Emacs manual’s section that describes the command.
    g           Display information about the GNU project.
    h           Display the HELLO file which illustrates various scripts.
    i           Start the Info documentation reader: read included manuals.
    I METHOD    Describe a specific input method, or RET for current.
    k KEYS      Display the full documentation for the key sequence.
    K KEYS      Show the Emacs manual’s section for the command bound to KEYS.
    l           Show last 300 input keystrokes (lossage).
    L LANG-ENV  Describe a specific language environment, or RET for current.
    m           Display documentation of current minor modes and current major mode,
                  including their special commands.
    n           Display news of recent Emacs changes.
    o SYMBOL    Display the given function or variable’s documentation and value.
    p TOPIC     Find packages matching a given topic keyword.
    P PACKAGE   Describe the given Emacs Lisp package.
    r           Display the Emacs manual in Info mode.
    s           Display contents of current syntax table, plus explanations.
    S SYMBOL    Show the section for the given symbol in the Info manual
                  for the programming language used in this buffer.
    t           Start the Emacs learn-by-doing tutorial.
    v VARIABLE  Display the given variable’s documentation and value.
    w COMMAND   Display which keystrokes invoke the given command (where-is).
    .           Display any available local help at point in the echo area.
     
    C-a         Information about Emacs.
    C-c         Emacs copying permission (GNU General Public License).
    C-d         Instructions for debugging GNU Emacs.
    C-e         External packages and information about Emacs.
    C-f         Emacs FAQ.
    C-m         How to order printed Emacs manuals.
    C-n         News of recent Emacs changes.
    C-o         Emacs ordering and distribution information.
    C-p         Info about known Emacs problems.
    C-s         Search forward "help window".
    C-t         Emacs TODO list.
    C-w         Information on absence of warranty for GNU Emacs.



    f1 t
    --------------------Tutorial  画面の例---------------------------------
    Copyright (c) 1985 Free Software Foundation, Inc;  ファイル最後を参照のこと
     	   あなたが現在見ているのは Emacs 入門ガイドです。
     
    Emacs のコマンドを入力するには、一般にコントロールキー（キートップに
    CTRL とか CTL と書いてある）やメタキー（キートップに META とか ALT と
    書いてある）を使います。そこで、CONTROL とか META とか書く代わりに、次
    のような記号を使うことにします。
     
     C-<文字>   コントロールキーを押したまま、<文字>キーを押します。例えば、
     	    C-f はコントロールキーを押しながら f のキーを押すことです。
     
     M-<文字>   メタキーを押したまま、<文字>キーを押します。もしメタキーがな
     	    い場合は、エスケープキーを押してから離し、それから<文字>キー
     	    を押します。以降エスケープキーのことを <ESC> と書きます。
     
    ！重要！: Emacsを終了するには、C-x C-c をタイプします。
     
    ">>" で始まる行は、その時何をすべきかを指示しています。例えば、
    ........



    f1 i
    --------------------Info 画面の例--------------------------------------
    File: dir,	Node: Top	This is the top of the INFO tree
     
    The Info Directory
    ******************
     
      The Info Directory is the top-level menu of major Info topics.
      Type "d" in Info to return to the Info Directory.  Type "q" to exit Info.
      Type "?" for a list of Info commands, or "h" to visit an Info tutorial.
      Type "m" to choose a menu item--for instance,
        "mEmacs<Return>" visits the Emacs manual.
      In Emacs Info, you can click mouse button 2 on a menu item
      or cross reference to follow it to its target.
      Each menu line that starts with a * is a topic you can select with "m".
      You can also select a topic by typing its ordinal number.
      Every third topic has a red * to help pick the right number to type.
     
    * Menu:
     
    Texinfo documentation system
    * Info: (info).                 How to use the documentation browsing system.
     
    Emacs
    * Emacs: (emacs).               The extensible self-documenting text editor.
    * Emacs FAQ: (efaq).            Frequently Asked Questions about Emacs.
    * Elisp: (elisp).               The Emacs Lisp Reference Manual.
    * Emacs Lisp Intro: (eintr).    A simple introduction to Emacs Lisp programming.
    * CC Mode: (ccmode).            Emacs mode for editing C, C++, Objective-C,
                                      Java, Pike, AWK, and CORBA IDL code.
    .............


## 初期画面
(C-h は f1 と読み替えてください)


    Welcome to GNU Emacs, a part of the GNU operating system.
     
    Get help           C-h  (Hold down CTRL and press h)
    Emacs manual       C-h r        Browse manuals     C-h i
    Emacs tutorial     C-h t        Undo changes       C-x u
    Buy manuals        C-h RET      Exit Emacs         C-x C-c
    Activate menubar   M-`
    (‘C-’ means use the CTRL key.  ‘M-’ means use the Meta (or Alt) key.
    If you have no Meta key, you may instead type ESC followed by the character.)
    Useful tasks:
    Visit New File                  Open Home Directory
    Customize Startup               Open *scratch* buffer
     
    GNU Emacs 27.2 (build 1, x86_64-apple-darwin18.7.0, NS appkit-1671.60 Version 10.14.6 (Build 18G95))
     of 2021-03-28
    Copyright (C) 2021 Free Software Foundation, Inc.
     
    GNU Emacs comes with ABSOLUTELY NO WARRANTY; type C-h C-w for full details.
    Emacs is Free Software--Free as in Freedom--so you can redistribute copies
    of Emacs and modify it; type C-h C-c to see the conditions.
    Type C-h C-o for information on getting the latest version.
     
    If an Emacs session crashed recently, type M-x recover-session RET
    to recover the files you were editing.

## iTerm2 設定 (Mac OSX)

    /home/user/.emacs.lisp/TERA/Iterm2-default.itermkeymap
    iTerm2 > Preferences > Profiles > Keys > Presets > Import
    から読み込ませてください
    
    C-tab C-S-tab は iTerm2のタブ切り替えに使うかも。。
    macの ¥ キーは \ に変更(キッパリ)
    C-up C-down などの Mission Controlキーとの競合問題。
    M-C- はmagnet で使うのでemacsでは使わず、s-up などを M-C-up に読み替えて戻している。
    fn キーを押さなくても f1..f12が使えるようにする

## teraterm 設定 (Windows)

    /home/user/.emacs.lisp/TERA/KOSMAX.CNF   (xterm用)
    をteraterm install directory にダウンロードし、
         KEYBOARD.CNF のかわりに使う
       
    テラターム設定 メニュー
      Setup
         Terminal
            端末ID  VT100              (この設定はダミー)
            Kanji(receive)   UTF-8
            Kanji(transmit)  UTF-8
         Keyboard
            Backspace Key    on       (Redhat では不要)
            Delete Key       off
            Send Meta Key    check    (Altで Meta-key)
         Save Setup
       
    テラターム iniファイル
         TermType=xterm               (iniファイルでxtermにする)


## 左Cntl キーの位置について

    Emacsのキー定義では、'A' キーの左が Cntl キーであると操作しやすくなっています
    Windows の Caps Lock キーと 左Cntl キーを入れ替えるのがおすすめ

## 設定の方針

Windows や Mac OSX のキー操作を取り入れてemacsの敷居を低くすることに努めました。  
基本的な emacsのキーバインドはそのまま残しています。Mac ではemacs流が取り入れられている
ため、違和感はないと思います。
本来のemacsキーバインドを変えたところは、次の通り。

- C-h はヘルプでなく、backspace
- C-r は逆方向検索でなく、置換
- C-z はサスペンドでなく、undo
- C-x は選択領域があるときだけ、切り取り
- C-c は選択領域があるときだけ、コピー
- C-v は画面スクロールでなくて貼り付け

おわり
