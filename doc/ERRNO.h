#ifndef _I386_ERRNO_H
#define _I386_ERRNO_H

#define	EPERM		 1	/* Operation not permitted */
#define	ENOENT		 2	/* No such file or directory */
#define	ESRCH		 3	/* No such process */
#define	EINTR		 4	/* Interrupted system call */
#define	EIO		 5	/* I/O error */
#define	ENXIO		 6	/* No such device or address */
#define	E2BIG		 7	/* Argument list too long */
#define	ENOEXEC		 8	/* Exec format error */
#define	EBADF		 9	/* Bad file number */
#define	ECHILD		10	/* No child processes */
#define	EAGAIN		11	/* Try again */
#define	ENOMEM		12	/* Out of memory */
#define	EACCES		13	/* Permission denied */
#define	EFAULT		14	/* Bad address */
#define	ENOTBLK		15	/* Block device required */
#define	EBUSY		16	/* Device or resource busy */
#define	EEXIST		17	/* File exists */
#define	EXDEV		18	/* Cross-device link */
#define	ENODEV		19	/* No such device */
#define	ENOTDIR		20	/* Not a directory */
#define	EISDIR		21	/* Is a directory */
#define	EINVAL		22	/* Invalid argument */
#define	ENFILE		23	/* File table overflow */
#define	EMFILE		24	/* Too many open files */
#define	ENOTTY		25	/* Not a typewriter */
#define	ETXTBSY		26	/* Text file busy */
#define	EFBIG		27	/* File too large */
#define	ENOSPC		28	/* No space left on device */
#define	ESPIPE		29	/* Illegal seek */
#define	EROFS		30	/* Read-only file system */
#define	EMLINK		31	/* Too many links */
#define	EPIPE		32	/* Broken pipe */
#define	EDOM		33	/* Math argument out of domain of func */
#define	ERANGE		34	/* Math result not representable */
#define	EDEADLK		35	/* Resource deadlock would occur */
#define	ENAMETOOLONG	36	/* File name too long */
#define	ENOLCK		37	/* No record locks available */
#define	ENOSYS		38	/* Function not implemented */
#define	ENOTEMPTY	39	/* Directory not empty */
#define	ELOOP		40	/* Too many symbolic links encountered */
#define	EWOULDBLOCK	EAGAIN	/* Operation would block */
#define	ENOMSG		42	/* No message of desired type */
#define	EIDRM		43	/* Identifier removed */
#define	ECHRNG		44	/* Channel number out of range */
#define	EL2NSYNC	45	/* Level 2 not synchronized */
#define	EL3HLT		46	/* Level 3 halted */
#define	EL3RST		47	/* Level 3 reset */
#define	ELNRNG		48	/* Link number out of range */
#define	EUNATCH		49	/* Protocol driver not attached */
#define	ENOCSI		50	/* No CSI structure available */
#define	EL2HLT		51	/* Level 2 halted */
#define	EBADE		52	/* Invalid exchange */
#define	EBADR		53	/* Invalid request descriptor */
#define	EXFULL		54	/* Exchange full */
#define	ENOANO		55	/* No anode */
#define	EBADRQC		56	/* Invalid request code */
#define	EBADSLT		57	/* Invalid slot */

#define	EDEADLOCK	EDEADLK

#define	EBFONT		59	/* Bad font file format */
#define	ENOSTR		60	/* Device not a stream */
#define	ENODATA		61	/* No data available */
#define	ETIME		62	/* Timer expired */
#define	ENOSR		63	/* Out of streams resources */
#define	ENONET		64	/* Machine is not on the network */
#define	ENOPKG		65	/* Package not installed */
#define	EREMOTE		66	/* Object is remote */
#define	ENOLINK		67	/* Link has been severed */
#define	EADV		68	/* Advertise error */
#define	ESRMNT		69	/* Srmount error */
#define	ECOMM		70	/* Communication error on send */
#define	EPROTO		71	/* Protocol error */
#define	EMULTIHOP	72	/* Multihop attempted */
#define	EDOTDOT		73	/* RFS specific error */
#define	EBADMSG		74	/* Not a data message */
#define	EOVERFLOW	75	/* Value too large for defined data type */
#define	ENOTUNIQ	76	/* Name not unique on network */
#define	EBADFD		77	/* File descriptor in bad state */
#define	EREMCHG		78	/* Remote address changed */
#define	ELIBACC		79	/* Can not access a needed shared library */
#define	ELIBBAD		80	/* Accessing a corrupted shared library */
#define	ELIBSCN		81	/* .lib section in a.out corrupted */
#define	ELIBMAX		82	/* Attempting to link in too many shared libraries */
#define	ELIBEXEC	83	/* Cannot exec a shared library directly */
#define	EILSEQ		84	/* Illegal byte sequence */
#define	ERESTART	85	/* Interrupted system call should be restarted */
#define	ESTRPIPE	86	/* Streams pipe error */
#define	EUSERS		87	/* Too many users */
#define	ENOTSOCK	88	/* Socket operation on non-socket */
#define	EDESTADDRREQ	89	/* Destination address required */
#define	EMSGSIZE	90	/* Message too long */
#define	EPROTOTYPE	91	/* Protocol wrong type for socket */
#define	ENOPROTOOPT	92	/* Protocol not available */
#define	EPROTONOSUPPORT	93	/* Protocol not supported */
#define	ESOCKTNOSUPPORT	94	/* Socket type not supported */
#define	EOPNOTSUPP	95	/* Operation not supported on transport endpoint */
#define	EPFNOSUPPORT	96	/* Protocol family not supported */
#define	EAFNOSUPPORT	97	/* Address family not supported by protocol */
#define	EADDRINUSE	98	/* Address already in use */
#define	EADDRNOTAVAIL	99	/* Cannot assign requested address */
#define	ENETDOWN	100	/* Network is down */
#define	ENETUNREACH	101	/* Network is unreachable */
#define	ENETRESET	102	/* Network dropped connection because of reset */
#define	ECONNABORTED	103	/* Software caused connection abort */
#define	ECONNRESET	104	/* Connection reset by peer */
#define	ENOBUFS		105	/* No buffer space available */
#define	EISCONN		106	/* Transport endpoint is already connected */
#define	ENOTCONN	107	/* Transport endpoint is not connected */
#define	ESHUTDOWN	108	/* Cannot send after transport endpoint shutdown */
#define	ETOOMANYREFS	109	/* Too many references: cannot splice */
#define	ETIMEDOUT	110	/* Connection timed out */
#define	ECONNREFUSED	111	/* Connection refused */
#define	EHOSTDOWN	112	/* Host is down */
#define	EHOSTUNREACH	113	/* No route to host */
#define	EALREADY	114	/* Operation already in progress */
#define	EINPROGRESS	115	/* Operation now in progress */
#define	ESTALE		116	/* Stale NFS file handle */
#define	EUCLEAN		117	/* Structure needs cleaning */
#define	ENOTNAM		118	/* Not a XENIX named type file */
#define	ENAVAIL		119	/* No XENIX semaphores available */
#define	EISNAM		120	/* Is a named type file */
#define	EREMOTEIO	121	/* Remote I/O error */
#define	EDQUOT		122	/* Quota exceeded */

#define	ENOMEDIUM	123	/* No medium found */
#define	EMEDIUMTYPE	124	/* Wrong medium type */

#endif

  /usr/src/linux/include/asm:
  -rw-r--r--    1 root     root         6162 2001-02-10 04:40 errno.h




HTTP STATUS
300番台
300     Multiple Choices                複数ページの利用が可能です。
301     Moved Parmanently               このアドレスは違うアドレスに移動しました。
302     Moved Temporarily               このアドレスは一時的に別のアドレスにおいています。
303     See Other                       他のページを参照してください。
304     Not Modified                    アクセスは許可されたが、対象の文書は更新されていなかった。
305     Use Proxy                       LocationフィールドのProxy経由でないとアクセス許可されません。
307     Temporary Redirect              このアドレスは一時的に別のアドレスに属しています。

400番台
400     Bad Request                     タイプミス等、リクエストにエラーがあります。
401     Unauthorixed                    認証に失敗しました。（パスワードを適当に入れてみた時などに発生）
402     Payment Required                （将来の使用のための予約コード）
403     Forbidden                       あなたにはアクセス権がありません。
404     (File)Not Found                 該当アドレスのページはありません、またはそのサーバーが落ちている。
405     Method Not Allowed              許可されていないメソッドタイプのリクエストを受けた。
406     Not Acceptable                  Acceptヘッダから判断された結果、受け入れられない内容を持っていた。
407     Proxy Authentication Required   最初にProxy認証が必要です。
408     Request Time-out                リクエストの待ち時間内に反応がなかった。
409     Conflict                        そのリクエストは現在の状態のリソースと矛盾するため完了できなかった。
410     Gone                            そのリクエストはサーバでは利用できず転送先のアドレスも分からない。
411     Length Required                 定義されたContent-Lengthの無いリクエストを拒否しました。
412     Precondition Failed             1つ以上のリクエストヘッダフィールドで与えられた条件がサーバ上のテストで不正であると判断しました。
413     Request Entity Too Large        処理可能量より大きいリクエストのため拒否しました。
414     Request-URI Too Large           リクエストURIが長すぎるため拒否しました。
415     Unsupported Media Type          リクエストされたメソッドに対してリクエストされたリソースがサポートしていないフォーマットであるため、
                                        サーバはリクエストのサービスを拒否しました。
416     Requested range not satisfiable リクエストにRangeヘッダフィールドは含まれていたが、If-Rangeリクエストヘッダフィールドがありません。
417     Expectation Failed              Expectリクエストヘッダフィールド拡張が受け入れられなかった。

500番台
500     Internal Server Error           CGIスクリプトなどでエラーが出た。
501     Not Implemented                 リクエストを実行するための必要な機能をサポートしていない。
502     Bad Gateway                     ゲートウェイやProxyとして動作しているサーバがリクエストを実行しようとしたら不正なレスポンスを受け取った。
503     Service Unavailable             そのアドレスは事情によりアクセスできません。
　      Mapping Server Error            クリッカブルマップで、変なアドレスを指定した。
　      Too many users                  この時間このページにアクセスできる定員オーバーをしました。
　      Method Not Allowed              CGIで送信時にPOSTかGETの一方しかできないのに、違う方を行った。
504     Gateway Time-out                リクエストを完了するために必要なDNSなどのサーバからレスポンスを受信できなかった。
505     HTTP Version not supported      サポートされていないHTTPプロトコルバージョンを受けた。


requests/status_codes.py
_codes = {

    # Informational.
    100: ('continue',),
    101: ('switching_protocols',),
    102: ('processing',),
    103: ('checkpoint',),
    122: ('uri_too_long', 'request_uri_too_long'),
    200: ('ok', 'okay', 'all_ok', 'all_okay', 'all_good', '\\o/', '?'),
    201: ('created',),
    202: ('accepted',),
    203: ('non_authoritative_info', 'non_authoritative_information'),
    204: ('no_content',),
    205: ('reset_content', 'reset'),
    206: ('partial_content', 'partial'),
    207: ('multi_status', 'multiple_status', 'multi_stati', 'multiple_stati'),
    208: ('already_reported',),
    226: ('im_used',),

    # Redirection.
    300: ('multiple_choices',),
    301: ('moved_permanently', 'moved', '\\o-'),
    302: ('found',),
    303: ('see_other', 'other'),
    304: ('not_modified',),
    305: ('use_proxy',),
    306: ('switch_proxy',),
    307: ('temporary_redirect', 'temporary_moved', 'temporary'),
    308: ('permanent_redirect',
          'resume_incomplete', 'resume',), # These 2 to be removed in 3.0

    # Client Error.
    400: ('bad_request', 'bad'),
    401: ('unauthorized',),
    402: ('payment_required', 'payment'),
    403: ('forbidden',),
    404: ('not_found', '-o-'),
    405: ('method_not_allowed', 'not_allowed'),
    406: ('not_acceptable',),
    407: ('proxy_authentication_required', 'proxy_auth', 'proxy_authentication'),
    408: ('request_timeout', 'timeout'),
    409: ('conflict',),
    410: ('gone',),
    411: ('length_required',),
    412: ('precondition_failed', 'precondition'),
    413: ('request_entity_too_large',),
    414: ('request_uri_too_large',),
    415: ('unsupported_media_type', 'unsupported_media', 'media_type'),
    416: ('requested_range_not_satisfiable', 'requested_range', 'range_not_satisfiable'),
    417: ('expectation_failed',),
    418: ('im_a_teapot', 'teapot', 'i_am_a_teapot'),
    422: ('unprocessable_entity', 'unprocessable'),
    423: ('locked',),
    424: ('failed_dependency', 'dependency'),
    425: ('unordered_collection', 'unordered'),
    426: ('upgrade_required', 'upgrade'),
    428: ('precondition_required', 'precondition'),
    429: ('too_many_requests', 'too_many'),
    431: ('header_fields_too_large', 'fields_too_large'),
    444: ('no_response', 'none'),
    449: ('retry_with', 'retry'),
    450: ('blocked_by_windows_parental_controls', 'parental_controls'),
    451: ('unavailable_for_legal_reasons', 'legal_reasons'),
    499: ('client_closed_request',),

    # Server Error.
    500: ('internal_server_error', 'server_error', '/o\\', '?'),
    501: ('not_implemented',),
    502: ('bad_gateway',),
    503: ('service_unavailable', 'unavailable'),
    504: ('gateway_timeout',),
    505: ('http_version_not_supported', 'http_version'),
    506: ('variant_also_negotiates',),
    507: ('insufficient_storage',),
    509: ('bandwidth_limit_exceeded', 'bandwidth'),
    510: ('not_extended',),
}





SIGNAL(7)                  Linux Programmer's Manual                 SIGNAL(7)

名前
       signal - 使用可能なシグナルの一覧

説明
       Linux は POSIX 信頼シグナル(以後 "標準シグナル"と表記)と POSIX リアルタ
       イムシグナルの両方に対応している。

   標準シグナル
       Linux は以下に示す標準シグナルに対応している。シグナル番号の一部は アー
       キテクチャ依存であり、"値"欄で示している。 (3つの値が与えられているもの
       は、1 つ目のものが alpha (DEC alpha chip) と sparc (SUN sparc chip)  で
       有効な値であり、中央の値が i386, ppc, sh で有効な値であり、最後のものは
       mips での値である。ここで、- はそのアーキテクチャにおいて未実装のシグナ
       ルを示す。)

       "動作" の欄の文字はシグナルのデフォルト動作を示し、以下のような意味を持
       つ。

       Term   デフォルトの動作は、プロセスの終了である。

       Ign    デフォルトの動作は、このシグナルの無視である。

       Core   デフォルトの動作は、プロセスの終了とコアダンプ出力である。

       Stop   デフォルトの動作は、プロセスの一時停止である。

       最初に、POSIX.1 に定義されているシグナルを示す。

       シグナル      値      動作   コメント
       ------------------------------------------------------------------------
       SIGHUP         1      Term   制御端末(controlling terminal)のハングアッ
                                    プ検出、または制御しているプロセスの死
       SIGINT         2      Term   キーボードからの割り込み (Interrupt)
       SIGQUIT        3      Core   キーボードによる中止 (Quit)
       SIGILL         4      Core   不正な命令
       SIGABRT        6      Core   abort(3) からの中断 (Abort) シグナル
       SIGFPE         8      Core   浮動小数点例外
       SIGKILL        9      Term   Kill シグナル
       SIGSEGV       11      Core   不正なメモリ参照
       SIGPIPE       13      Term   パイプ破壊: 読み手の無いパイプへの書き出し
       SIGALRM       14      Term   alarm(2) からのタイマーシグナル
       SIGTERM       15      Term   終了 (termination) シグナル
       SIGUSR1    30,10,16   Term   ユーザ定義シグナル 1
       SIGUSR2    31,12,17   Term   ユーザ定義シグナル 2
       SIGCHLD    20,17,18   Ign    子プロセスの一旦停止 (stop) または終了
       SIGCONT    19,18,25          一旦停止 (stop) からの再開
       SIGSTOP    17,19,23   Stop   プロセスの一旦停止 (stop)
       SIGTSTP    18,20,24   Stop   端末 (tty) より入力された一旦停止 (stop)  Control-Z で
       SIGTTIN    21,21,26   Stop   バックグランドプロセスの tty 入力
       SIGTTOU    22,22,27   Stop   バックグランドプロセスの tty 出力

       SIGKILL と SIGSTOP のシグナルはキャッチ、ブロック、無視できない。

       次に、 POSIX.1 標準にはないが SUSv2 と SUSv3 / POSIX 1003.1-2001 に記述
       されているシグナルを示す。

       シグナル       値      動作   コメント

       -----------------------------------------------------------------
       SIGBUS      10,7,10    Core   バスエラー (不正なメモリアクセス)
       SIGPOLL                Term   ポーリング可能なイベント (Sys V)。
                                     SIGIOと同義
       SIGPROF     27,27,29   Term   profiling タイマの時間切れ
       SIGSYS      12,-,12    Core   ルーチンへの引数が不正 (SVID)
       SIGTRAP        5       Core   トレース/ブレークポイント トラップ
       SIGURG      16,23,21   Ign    ソケットの緊急事態 (urgent condi-
                                     tion) (4.2 BSD)
       SIGVTALRM   26,26,28   Term   仮想アラームクロック (4.2 BSD)
       SIGXCPU     24,24,30   Core   CPU時間制限超過 (4.2 BSD)
       SIGXFSZ     25,25,31   Core   ファイルサイズ制限の超過 (4.2 BSD)

       Linux 2.2 以前では、 SIGSYS, SIGXCPU, SIGXFSZ および SPARC と MIPS 以外
       のアーキテクチャでは SIGBUS のデフォルトの振る舞いは(コアダンプを出力せ
       ずに)プロセスを終了させる。 (その他の Unix には SIGXCPUとSIGXFSZ  の デ
       フォルトの動作がコアダンプなしにプロセスを終了させるものもある。) Linux
       2.4 では、POSIX 1003.1-2001 での要求に準拠して、これらのシグナルでは プ
       ロセスを終了させ、コアダンプを出力する。

       次にその他の様々なシグナルを示す。

       シグナル       値      動作   コメント
       -------------------------------------------------------------------
       SIGIOT         6        C     IOT トラップ。SIGABRT と同義
       SIGEMT       7,-,7
       SIGSTKFLT    -,16,-     A     数値演算プロセッサにおけるスタック
                                     フォルト (未使用)
       SIGIO       23,29,22    A     入出力が可能になった (4.2 BSD)
       SIGCLD       -,-,18           SIGCHLD と同義
       SIGPWR      29,30,19    A     電源喪失 (Power failure) (System V)
       SIGINFO      29,-,-           SIGPWR と同義
       SIGLOST      -,-,-      A     ファイルロックが失われた
       SIGWINCH    28,28,20    B     ウィンドウ リサイズ シグナル  (4.3
                                     BSD, Sun)
       SIGUNUSED    -,31,-     A     未使用シグナル (SIGSYS となるだろう)

       ( シ グ ナ ル  29   は alpha では SIGINFO / SIGPWR であるが、sparc では
       SIGLOST である。)

       SIGEMT は POSIX 1003.1-2001 に規定されていないが、その他の多く の  Unix
       に 存在する。デフォルトの動作は一般的にはプロセスを停止して、コアダンプ
       を出力する。

       SIGPWR (POSIX 1003.1-2001 に規定されていない) はこのシグナルが存在す る
       その他の Unix では一般的なデフォルトの動作は無視である。

       SIGIO (POSIX 1003.1-2001 に規定されていない) はその他の Unix ではデフォ
       ルトの動作は無視である。

   リアルタイムシグナル
       Linux は POSIX.4 リアルタイム拡張で定義されている (そして今で は  POSIX
       1003.1-2001  に含まれている) リアルタイムシグナルに対応している。 Linux
       は 32 番 (SIGRTMIN) から 63 番 (SIGRTMAX) までの 32 個のリアルタイム シ
       グ ナルに対応している。 (プログラムではリアルタイムシグナルを使うときに
       常に SIGRTMIN+n の形で使うべきである。なぜならリアルタイムシグナルの 番
       号は Unix の種類によって異なるからである。)

       標 準シグナルと異なり、リアルタイムシグナルには事前に定義された意味はな
       い。リアルタイムシグナルの全部をアプリケーションで定義した用途 に 使 え
       る。 (但し、LinuxThreads 実装は最初の三つのリアルタイムシグナルを使用し
       ていることに注意すること)

       ハンドリングしないリアルタイムシグナルのデフォルトの動作は受信したプ ロ
       セスの終了である。

       リアルタイムシグナルは以下の特徴がある:

       1.   リ ア ルタイムシグナルの複数の実体をキューに入れることができる。一
           方、シグナルがブロックされている時に複数の標準シグナルの実体が配 達
           さ れた場合、一つだけがキューに入れられる。リアルタイムシグナルは複
           数の実体をキューに入れることができる。一方、標準シグナルの場合、 そ
           の シ グ ナルがブロックされている間に複数のインスタンスが配送されて
           も、 1 つだけがキューに入れられる。

       2.  シグナルが sigqueue(2) を用いて送信された場合、付随する値(整数か ポ
           インタ)をシグナルと共に送信できる。受信側プロセスが sigaction(2) に
           SA_SIGACTION を指定してシグナルハンドラを設定した場合、ハンドラの第
           2 引数として渡される siginfo_t 構造体の si_value フィールドを介して
           このデータを所得できる。さらに、この構造 体 の  si_pid   と  si_uid
           フィールドでシグナルを送信したプロセスの PID と実ユーザ ID を得るこ
           とができる。

       3.  リアルタイムシグナルは保証された順序で到着する。同じタイプのリア ル
           タ イムシグナルは送信された順番に到着する。異なるリアルタイムシグナ
           ルが一つのプロセスに送信された場合、番号の小さいシグナルから先に 到
           着する。 (つまり小さい番号のシグナルが高い優先順位を持つ。)

       一 つのプロセスに対して標準シグナルとリアルタイムシグナルの両方が待機し
       ている場合、 POSIX はどちらが先に配送されるかを規定していな い。  Linux
       で は、その他の多くの実装と同様、このような場合には標準シグナルに優先順
       位を与えている。

       POSIX によれば、1 プロセスにつき最低 _POSIX_SIGQUEUE_MAX (32) 個のリ ア
       ル タイムシグナルをキューに入れられるべきとしている。しかし、Linux では
       プロセス毎の制限の代わりに、全てのプロセスに対するリアルタイムシグナ ル
       の キュー の 数 のシステムとしての制限がある。この制限は /proc/sys/ker-
       nel/rtsig-max ファイルで見ることができ、(権限があれば)変更もできる。 関
       係するファイルとして、 /proc/sys/kernel/rtsig-nr を見ることで現在キュー
       に入っているリアルタイムシグナルの数を知ることができる。

準拠
       POSIX.1

バグ
       SIGIO と SIGLOST は同じ値を持っている。後者 (SIGLOST) はカーネルの ソー
       ス ではコメントアウトされている。しかしソフトウェアによってはビルドの過
       程でシグナル 29 を SIGLOST とみなしてしまうものがある。

関連項目
       kill(1),  kill(2),  setitimer(2),  sigaction(2),  signal(2),   sigproc-
       mask(2), sigqueue(2)



SIGNAL(2)                  Linux Programmer's Manual                 SIGNAL(2)

名前
       signal - ANSI C シグナル操作

書式
       #include <signal.h>

       typedef void (*sighandler_t)(int);

       sighandler_t signal(int signum, sighandler_t sighandler);

説明
       signal() システム・コールは signum で指定された番号のシグナルに新しいシ
       グナル・ハンドラーを設定する。このシグナル・ハンドラーは sighandler  に
       設 定される。 sighandler は、ユーザーの指定した関数、 SIG_IGN、 SIG_DFL
       のいずれかである。

       シグナル番号 signum のシグナルを受けると次のように動作する。対応する ハ
       ンドラーが SIG_IGN に設定されている場合は、シグナルは無視される。ハンド
       ラーが SIG_DFL に設定されている場合は、シグナルに関連づけられたデフォル
       トの動作を行う (signal(7) を参照)。ハンドラーが関数 sighandler に設定さ
       れている場合は、まず最初にハンドラーが SIG_DFL にリセットされ (あるいは
       実装に依存するシグナルのブロックが実行され)、次に signum を引き数として
       sighandler が呼ばれる。

       シグナルに対してシグナルハンドラー関数を使うことは、「シグナルの キャッ
       チ」 と呼ばれる。シグナル SIGKILL と SIGSTOP はキャッチできず、無視する
       こともできない。

返り値
       signal() 関数は今までのシグナル・ハンドラーの値を返すか、エラーの場合は
       SIG_ERR を返す。

移植性
       Unix   の オリジナルの signal() はハンドラーを SIG_DFL にリセットする。
       System V (と Linux カーネルと libc4,5) も同じである。一方、BSD ではハン
       ド ラーのリセットを行わず、ハンドラーが呼ばれている間にシグナルの新しい
       インスタンスが発生するのをブロックする。 glibc2 ライブラリでは BSD の動
       作に従っている。

       libc5   シ ステムにおいて <signal.h> のかわりに <bsd/signal.h> をインク
       ルードすると、 signal() は __bsd_signal に再定義されて BSD 方式となる。
       これは推奨されない。

       glibc2  システムにおいて _XOPEN_SOURCE のような機能検査マクロを定義した
       り、この関数とは別の sysv_signal 関数を使ったりすれば、以前のような動作
       をする。これは推奨されない。

       マ クロの定義やファイルのインクルードでこの関数の方式を変更しようとする
       のは、良くない考え方である。 signal() を使うのを完全に避けて、代わり に
       sigaction(2) を使った方が良い。

注意
       マルチスレッドプロセスにおけるこの関数の結果は、指定されていない。

       他の場所での処理が任意の箇所で割り込まれるため、ルーチン handler は非常
       に注意しなければならない。 POSIX には「安全な関数」という概念がある。シ
       グナルが安全でない関数に割り込み、かつ handler がその安全でない関数を呼
       び出していた場合、その挙動は未定義である。安全な関数は様々な規格に明 確
       にリストされている。 POSIX 1003.1-2003 でのリストは以下の通りである:

       _Exit()  _exit()  abort()  accept()  access()  aio_error() aio_return()
       aio_suspend() alarm() bind() cfgetispeed() cfgetospeed()  cfsetispeed()
       cfsetospeed() chdir() chmod() chown() clock_gettime() close() connect()
       creat() dup() dup2() execle() execve() fchmod() fchown() fcntl() fdata-
       sync()   fork()   fpathconf()  fstat()  fsync()  ftruncate()  getegid()
       geteuid() getgid() getgroups() getpeername() getpgrp()  getpid()  getp-
       pid()   getsockname()  getsockopt()  getuid()  kill()  link()  listen()
       lseek() lstat()  mkdir()  mkfifo()  open()  pathconf()  pause()  pipe()
       poll()  posix_trace_event()  pselect() raise() read() readlink() recv()
       recvfrom()  recvmsg()  rename()  rmdir()  select()  sem_post()   send()
       sendmsg()  sendto()  setgid()  setpgid() setsid() setsockopt() setuid()
       shutdown()  sigaction()  sigaddset()  sigdelset()  sigemptyset()   sig-
       fillset()  sigismember() signal() sigpause() sigpending() sigprocmask()
       sigqueue() sigset() sigsuspend() sleep() socket()  socketpair()  stat()
       symlink() sysconf() tcdrain() tcflow() tcflush() tcgetattr() cgetpgrp()
       tcsendbreak()   tcsetattr()   tcsetpgrp()   time()   timer_getoverrun()
       timer_gettime()   timer_settime()   times()  umask()  uname()  unlink()
       utime() wait() waitpid() write().

       POSIX によると、 kill(2) や raise(3) 関数で生成できない SIGFPE, SIGILL,
       SIGSEGV シグナルを無視した後の動作は未定義である。 0 による整数割り算の
       結果は未定義となる。ある種のアーキテクチャーでは、これは SIGFPE シグ ナ
       ル を生成する。 (同様に負の最大整数を -1 で割ると SIGFPE が生成されるか
       もしれない。) このシグナルを無視すると無限ループに陥るかもしれない。

       SIGCHLD の動作として SIG_IGN を設定した場合の詳細な動作に つ い て は、
       sigaction(2) を参照すること。

       sighandler_t  の使用は GNU 拡張である。各種バージョンの libc でこの型は
       定義済みである; libc4 と libc5 では SignalHandler を定 義 し て い る。
       glibc  では sig_t を定義しており、 _GNU_SOURCE が定義されている場合には
       sighandler_t も定義されている。

準拠
       ANSI C

関連項目
       kill(1), alarm(2), kill(2), pause(2), sigaction(2), sigpending(2), sig-
       procmask(2),  sigqueue(2),  sigsuspend(2),  killpg(3), raise(3), sigse-
       tops(3), sigvec(3), signal(7)

Linux 2.2                         2000-04-28                         SIGNAL(2)

$ trap -lp
1) SIGHUP
2) SIGINT
3) SIGQUIT
4) SIGILL
5) SIGTRAP
6) SIGABRT
7) SIGBUS
8) SIGFPE
9) SIGKILL
10) SIGUSR1
11) SIGSEGV
12) SIGUSR2
13) SIGPIPE
14) SIGALRM
15) SIGTERM
16) SIGSTKFLT
17) SIGCHLD
18) SIGCONT
19) SIGSTOP
20) SIGTSTP
21) SIGTTIN
22) SIGTTOU
23) SIGURG
24) SIGXCPU
25) SIGXFSZ
26) SIGVTALRM
27) SIGPROF
28) SIGWINCH
29) SIGIO
30) SIGPWR
31) SIGSYS
34) SIGRTMIN
35) SIGRTMIN+1
36) SIGRTMIN+2
37) SIGRTMIN+3
38) SIGRTMIN+4
39) SIGRTMIN+5
40) SIGRTMIN+6
41) SIGRTMIN+7
42) SIGRTMIN+8
43) SIGRTMIN+9
44) SIGRTMIN+10
45) SIGRTMIN+11
46) SIGRTMIN+12
47) SIGRTMIN+13
48) SIGRTMIN+14
49) SIGRTMIN+15
50) SIGRTMAX-14
51) SIGRTMAX-13
52) SIGRTMAX-12
53) SIGRTMAX-11
54) SIGRTMAX-10
55) SIGRTMAX-9
56) SIGRTMAX-8
57) SIGRTMAX-7
58) SIGRTMAX-6
59) SIGRTMAX-5
60) SIGRTMAX-4
61) SIGRTMAX-3
62) SIGRTMAX-2
63) SIGRTMAX-1
64) SIGRTMAX
