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

pro "Enter Password (again): " 
pro "old password: " 
pro "New Password: " 
pro "Ken's Password: " 
pro "login Password: " 
pro "Kerberos Password: " 
pro "CVS Password: " 
pro "UNIX Password: " 
pro "xx SMB Password: " 
pro "LDAP Password: " 
pro "[sudo] Password: " 
pro "Password: " 
pro "Some Old Password: " 
pro "pass phrase: "
pro "パスワード, try again: "
pro "passphrase: "
pro "Enter Passphrase: "
pro "Repeat Passphrase: "
pro "Bad passphrase: "
pro "New Password for F1RACING: " 
pro "Password:" 
pro "Password: " 
pro "Password:  " 
pro "Password:
 " 
pro "Password:	" 
pro "Password:		" 
pro "Password: 	 	 " 


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
##    )?:\\s *\\'
##    "
