#!/bin/bash

NAME='home'
DOMAIN='mydomain.com'

#Optional, if you don't want to copy this file and isip into your system's $PATH
#PATH="${PATH}:/path/to/git/repo/"

for p in isip route53 wget dig;do
	if ! command -v "${p}" &>> /dev/null; then
		echo "Unable to find ${p}, please install it." >&2
		if [ "${p}" == 'isip' ]; then
			echo "isip can be found in the git repository, and is expected to be found in \$PATH: ${PATH}" >&2
		fi
		exit 1
	fi
done

if [ -e "${HOME}/.route53_dip" ]; then
	olip="$(< "${HOME}/.route53_dip" )"
else
	olip=""
fi
nip=$( dig +short myip.opendns.com @resolver1.opendns.com )
if ! isip "${nip}"  &>> /dev/null; then
	nip=$( wget -qO- http://ipecho.net/plain )
	if ! isip "${nip}"  &>> /dev/null; then
		for d in ifconfig.co ifconfig.me icanhazip.com;do
			nip=$( curl "${d}" )
			if isip "${nip}"  &>> /dev/null; then
				break
			fi
		done
	fi
fi
if ! isip "${nip}"  &>> /dev/null; then
	echo "Error finding new IP" >&2
	exit 1
fi
if [ "${nip}" == "${olip}" ]; then
	exit 0
fi
if route53 -z "${DOMAIN}" -g --name "${NAME}.${DOMAIN}." --values "${nip}"; then
	echo "${nip}" > "${HOME}/.route53_dip"
else
	echo "Route53 error"
	exit 1
fi
