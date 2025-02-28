#!/bin/zsh
#
take ~/.config
for k in swroot keyfactorswroot
do
	curl -LO http://swroot.sherwin.com/$k.pem
	sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ./$k.pem
done
