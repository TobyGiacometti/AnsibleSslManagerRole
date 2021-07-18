#!/bin/sh

log() {
	printenv >>"$log_file" || return
	echo "---" >>"$log_file"
}

log_file=/tmp/acme.sh.log

if [ "$1" = --register-account ]; then
	log || exit
	mkdir -p "$(dirname "$0")/ca"
elif [ "$1" = --update-account ] && [ "$2" = --accountemail ]; then
	log || exit
	echo "$3" >"$(dirname "$0")/ca/acme-v02.api.letsencrypt.org/email.txt"
elif [ "$1" = --revoke ] && [ "$2" = --domain ]; then
	log || exit
	rm "$(dirname "$0")/$3/$3.cer"
elif [ "$2" = --issue ] && [ "$5" = --domain ]; then
	log || exit
	mkdir -p "$(dirname "$0")/$6" || exit
	touch "$(dirname "$0")/$6/$6.conf" || exit
	touch "$(dirname "$0")/$6/$6.csr" || exit
	touch "$(dirname "$0")/$6/$6.csr.conf" || exit
	touch "$(dirname "$0")/$6/$6.key" || exit
	touch "$(dirname "$0")/$6/$6.cer" || exit
	touch "$(dirname "$0")/$6/ca.cer" || exit
	touch "$(dirname "$0")/$6/fullchain.cer"
else
	sh "$(dirname "$0")/acme.sh.orig" "$@"
fi
