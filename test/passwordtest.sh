#!/bin/bash
pro() {
    PROMPT=$1
    while read -p "$PROMPT" -s line; do
	if [ -z "$line" ]; then
	    exit
	fi
	echo
	return
    done
    exit
}

pro "パスワード again: "
pro "パスワード, try again: "
pro "パスワード (empty for no passphrase): "
pro "パスワード (again): "

pro "Enter Response:"
pro "ססמה:"
pro "كلمة السر:"

pro "adgangskode:"
pro "contrasenya:"
pro "contraseña:"
pro "decryption key:"
pro "encryption key:"
pro "geslo:"
pro "hasło:"
pro "heslo:"
pro "iphasiwedi:"
pro "jelszó:"
pro "lozinka:"
pro "lösenord:"
pro "mot de passe:"
pro "mật khẩu:"
pro "parola:"
pro "pasahitza:"
pro "pass phrase:"
pro "passcode:"
pro "passord:"
pro "passphrase:"
pro "password:"
pro "passwort:"
pro "pasvorto:"
pro "pin:"
pro "salasana:"
pro "senha:"
pro "slaptažodis:"
pro "wachtwoord:"
pro "лозинка:"
pro "пароль:"
pro "गुप्तशब्द:"
pro "शब्दकूट:"
pro "গুপ্তশব্দ:"
pro "পাসওয়ার্ড:"
pro "ਪਾਸਵਰਡ:"
pro "પાસવર્ડ:"
pro "ପ୍ରବେଶ ସଙ୍କେତ:"
pro "கடவுச்சொல்:"
pro "సంకేతపదము:"
pro "ಗುಪ್ತಪದ:"
pro "അടയാളവാക്ക്:"
pro "රහස්පදය:"
pro "ពាក្យសម្ងាត់:"
pro "パスワード:"
pro "密码:"
pro "密碼:"
pro "암호:"

pro "XX smb PaSsWoRd: "
pro "Ken's Password: " 
pro "XXbad pAsSwOrD: "
pro "XXCVS Password: " 
pro "XXcurrent Password: " 
pro "XXEnter Password: " 
pro "XXenter auth Password: " 
pro "XXEnter same Password: " 
pro "XXenter the Password: " 
pro "XXkerberos Password: " 
pro "XXldap Password: " 
pro "XXNew Password: " 
pro "XXold password: " 
pro "XXpem password: " 
pro "XXrepeat Passphrase: "
pro "XXretype Passphrase: "
pro "XXunix Password: " 
pro "XXsudo Password: " 
pro "XXverify Password: " 
pro "XX[sudo] Password: " 
pro "XXDOAS Password: " 
pro "XXlogin Password: " 
pro "Some Old Password: " 
pro "pass phrase: "
pro "passphrase: "
pro "Enter Passphrase: "
pro "Bad passphrase: "
pro "New Password for F1RACING: " 

pro "Password for 'https://akira0000k@github.com': "
#pro "Password for 'https://akira0000k github.com' : "
#pro "Password forrrrrrrrrrrrr ::::: ::::::::'https;//akira0000k@github.com':"
#pro "Password for 'https://akira0000k@github.com':: "
#pro "Password for 'https//akira0000k@github.com': "

pro "Enter encryption key: (repeat) "
pro "enter Encryption key: (repeat) "
pro "Password:" 
pro "Password: " 
pro "Password:  " 
pro "Password:
 " 
pro "Password:	" 
pro "Password:		" 
pro "Password: 	 	 " 
exit

## (setq comint-password-prompt-regexp
##	 "\\(\\([Ee]nter \\|[Oo]ld \\|[Nn]ew \\|'s \\|login \\|Kerberos \\|CVS \\|UNIX \\| SMB \\|LDAP \\|\\[sudo] \\|^\\)[Pp]assword\\( (again)\\)?\\|pass phrase\\|パスワード\\|\\(Enter \\|Repeat \\|Bad \\)?[Pp]assphrase\\)\\(, try again\\)?\\( for [^:]+\\)?:\\s *\\'"
##	 )

##    "
##    (
##      (
##        [Ee]nter \\|[Oo]ld \\|[Nn]ew \\|'s \\|login \\|Kerberos \\|CVS \\|UNIX \\| SMB \\|LDAP \\|\\[sudo] \\|^
##      )
##      [Pp]assword
##      (
##        (again)
##      )?
##      \\|
##      pass phrase
##      \\|
##      パスワード
##      \\|
##      (
##        Enter \\|Repeat \\|Bad 
##      )?[Pp]assphrase
##    )
##    (
##    , try again
##    )?
##    (
##     for [^:]+
##    )?
##    :\\s *\\'
##    "


## (setq comint-password-prompt-regexp
##       "\\(\\(enter \\|old \\|new \\|'s \\|login \\|kerberos \\|cvs \\|unix \\| smb \\|ldap \\|\\[sudo] \\|^\\)password\\( (again)\\)?\\|pass phrase\\|パスワード\\|\\(enter \\|repeat \\|bad \\)?passphrase\\)\\(, try again\\)?\\(?: [[:alpha:]]+ .+\\)?[[:blank:]]*[:：៖][[:space:]]*\\'\\|^enter encryption key: (repeat) *\\'"
##       )


##    "\\(^ *\\|\\( SMB\\|'s\\|Bad\\|C\\(?:VS\\|urrent\\)\\|Enter\\(?: \\(?:Auth\\|\\(?:sam\\|th\\)e\\)\\)?\\|Kerberos\\|LDAP\\|New\\|Old\\|PEM\\|Re\\(?:peat\\|type\\)\\|SUDO\\|UNIX\\|Verify\\|\\[sudo]\\|doas\\|enter\\(?: \\(?:auth\\|\\(?:sam\\|th\\)e\\)\\)?\\|login\\|new\\|old\\) +.*\\)\\(?:\\(?:adgangskode\\|contrase\\(?:\\(?:ny\\|ñ\\)a\\)\\|decryption key\\|encryption key\\|geslo\\|h\\(?:\\(?:asł\\|esl\\)o\\)\\|iphasiwedi\\|jelszó\\|l\\(?:ozinka\\|ösenord\\)\\|m\\(?:ot de passe\\|ật khẩu\\)\\|p\\(?:a\\(?:rola\\|s\\(?:ahitza\\|s\\(?: phrase\\|code\\|ord\\|phrase\\|wor[dt]\\)\\|vorto\\)\\)\\|in\\)\\|s\\(?:alasana\\|enha\\|laptažodis\\)\\|wachtwoord\\|лозинка\\|пароль\\|ססמה\\|كلمة السر\\|गुप्तशब्द\\|शब्दकूट\\|গুপ্তশব্দ\\|পাসওয়ার্ড\\|ਪਾਸਵਰਡ\\|પાસવર્ડ\\|ପ୍ରବେଶ ସଙ୍କେତ\\|கடவுச்சொல்\\|సంకేతపదము\\|ಗುಪ್ತಪದ\\|അടയാളവാക്ക്\\|රහස්පදය\\|ពាក្យសម្ងាត់\\|パスワード\\|密[码碼]\\|암호\\)\\|Response\\)\\(?:\\(?:, try\\)? *again\\| (empty for no passphrase)\\| (again)\\)?\\(?: [[:alpha:]]+ .+\\)?[[:blank:]]*[:：៖][[:space:]]*\\'\\|^Enter encryption key: (repeat) *\\'"


"
(
	^ *
	\\|(
		 SMB\\|'s\\|Bad
		\\|C(?:VS\\|urrent)
		\\|Enter(?: (?:Auth\\|(?:sam\\|th)e))?
		\\|Kerberos\\|LDAP\\|New\\|Old\\|PEM
		\\|Re(?:peat\\|type)
		\\|SUDO\\|UNIX\\|Verify\\|\\[sudo]\\|doas
		\\|enter(?: (?:auth\\|(?:sam\\|th)e))?    <--noneed
		\\|login\\|new\\|old
	)
	 +.*
)
(?:
	(?:
		adgangskode
		\\|contrase(?:(?:ny\\|ñ)a)
		\\|decryption key\\|encryption key\\|geslo
		\\|h(?:(?:asł\\|esl)o)
		\\|iphasiwedi\\|jelszó
		\\|l(?:ozinka\\|ösenord)
		\\|m(?:ot de passe\\|ật khẩu)
		\\|p(?:
			a(?:
				rola
				\\|s(?:
					ahitza
					\\|s(?:
						 phrase\\|code\\|ord
						\\|phrase\\|wor[dt]
					)
					\\|vorto
				)
			)
			\\|in
		)
		\\|s(?:alasana\\|enha\\|laptažodis)
		\\|wachtwoord\\|лозинка\\|пароль\\|ססמה\\|كلمة السر\\|गुप्तशब्द\\|शब्दकूट\\|গুপ্তশব্দ\\|পাসওয়ার্ড\\|ਪਾਸਵਰਡ\\|પાસવર્ડ\\|ପ୍ରବେଶ ସଙ୍କେତ\\|கடவுச்சொல்\\|సంకేతపదము\\|ಗುಪ್ತಪದ\\|അടയാളവാക്ക്\\|රහස්පදය\\|ពាក្យសម្ងាត់
		\\|パスワード\\|密[码碼]\\|암호
	)
	\\|Response
)
(?:
	(?:, try)? *again\\| (empty for no passphrase)\\| (again)
)?
(?:
	 [[:alpha:]]+ .+
)?
[[:blank:]]*[:：៖][[:space:]]*\\'
\\|^Enter encryption key: (repeat) *\\'
"

#pro "Password for 'https://akira0000k@github.com': "


#  https://maeyan.blogspot.com/2008/07/blog-post_9966.html
#  (?: でメモリーに入れない


#  https://ayatakesi.github.io/emacs/28.2/emacs-ja.html
#  15.7 正規表現でのバックスラッシュ
#  \(?: … \)
#     マッチした部分文字列を記録しない、shy(内気)なグループ化を指定します。マッチした部分文字列は、‘\d’により後方参照できません(以下参照)。
#     この機能は正規表現を機械的にまとめるときに役立ちます。これにより後方参照するためのグループにたいする番号づけに影響することなく、文法的な目的によるグループ化を行うことができます。

#  \'
#      空の文字列にマッチしますが、文字列またはバッファー(またはアクセスできる部分)の最後に限定されます。

#   "\\(^ *\\|\\( SMB\\|'s\\|Bad\\|CVS\\|Current\\|Enter\\(?: \\(?:Auth\\|same\\|the\\)\\)?\\|Kerberos\\|LDAP\\|New\\|Old\\|PEM\\|Repeat\\|Retype\\|SUDO\\|UNIX\\|Verify\\|\\[sudo]\\|doas\\|login\\|new\\|old\\) +.*\\)\\(?:\\(?:adgangskode\\|contrasenya\\|contraseña\\|decryption key\\|encryption key\\|geslo\\|hasło\\|heslo\\|iphasiwedi\\|jelszó\\|lozinka\\|lösenord\\|mot de passe\\|mật khẩu\\|parola\\|pasahitza\\|pass phrase\\|passcode\\|passord\\|passphrase\\|passwor[dt]\\|pasvorto\\|pin\\|salasana\\|senha\\|slaptažodis\\|wachtwoord\\|лозинка\\|пароль\\|ססמה\\|كلمة السر\\|गुप्तशब्द\\|शब्दकूट\\|গুপ্তশব্দ\\|পাসওয়ার্ড\\|ਪਾਸਵਰਡ\\|પાસવર્ડ\\|ପ୍ରବେଶ ସଙ୍କେତ\\|கடவுச்சொல்\\|సంకేతపదము\\|ಗುಪ್ತಪದ\\|അടയാളവാക്ക്\\|රහස්පදය\\|ពាក្យសម្ងាត់\\|パスワード\\|密[码碼]\\|암호\\)\\|Response\\)\\(?:\\(?:, try\\)? *again\\| (empty for no passphrase)\\| (again)\\)?\\(?: [[:alpha:]]+ .+\\)?[[:blank:]]*[:：៖][[:space:]]*\\'\\|^Enter encryption key: (repeat) *\\'"

"
(
	^ *
	\\|
	(
!	 	 SMB
	 	\\|'s
	 	\\|Bad
	 	\\|CVS
	 	\\|Current
	 	\\|Enter
	 	 	(?: 
	 	 		(?:Auth
	 	 		\\|same
!	 	 		\\|the
!	 	 		)
	 	 	)?
	 	\\|Kerberos
	 	\\|LDAP
	 	\\|New
	 	\\|Old
	 	\\|PEM
	 	\\|Repeat
	 	\\|Retype
	 	\\|SUDO
	 	\\|UNIX
	 	\\|Verify
	 	\\|\\[sudo]
	 	\\|doas
	 	\\|login
	 	\\|new    <--noneed
	 	\\|old    <--noneed
	) +.*
)
(?:
	(?:          <------noneed
		adgangskode
	 	\\|contrasenya
	 	\\|contraseña
	 	\\|decryption key
	 	\\|encryption key
	 	\\|geslo
	 	\\|hasło
	 	\\|heslo
	 	\\|iphasiwedi
	 	\\|jelszó
	 	\\|lozinka
	 	\\|lösenord
	 	\\|mot de passe
	 	\\|mật khẩu
	 	\\|parola
	 	\\|pasahitza
	 	\\|pass phrase
	 	\\|passcode
	 	\\|passord
	 	\\|passphrase
	 	\\|passwor[dt]
	 	\\|pasvorto
	 	\\|pin
	 	\\|salasana
	 	\\|senha
	 	\\|slaptažodis
	 	\\|wachtwoord
	 	\\|лозинка
	 	\\|пароль
	 	\\|ססמה
	 	\\|كلمة السر
	 	\\|गुप्तशब्द
	 	\\|शब्दकूट
	 	\\|গুপ্তশব্দ
	 	\\|পাসওয়ার্ড
	 	\\|ਪਾਸਵਰਡ
	 	\\|પાસવર્ડ
	 	\\|ପ୍ରବେଶ ସଙ୍କେତ
	 	\\|கடவுச்சொல்
	 	\\|సంకేతపదము
	 	\\|ಗುಪ್ತಪದ
	 	\\|അടയാളവാക്ക്
	 	\\|රහස්පදය
	 	\\|ពាក្យសម្ងាត់
	 	\\|パスワード
	 	\\|密[码碼]
	 	\\|암호
	)          <------noneed
	\\|Response
)
(?:
	(?:, try\\)? *again
	\\| (empty for no passphrase)
	\\| (again)
)?
(?: [[:alpha:]]+ .+\\)?
[[:blank:]]*[:：៖][[:space:]]*\\'
\\|^Enter encryption key: (repeat) *\\'
"
