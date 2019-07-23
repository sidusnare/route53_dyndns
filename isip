#!/usr/bin/env bash

if [ -z "${1}" ]; then
	echo "Please pass string that might be an IPv4 IP" >&2
	exit 10
fi
octets=()
readarray -t octets < <( tr '.' '\n' <<< "${1}" )
if [ "${#octets[@]}" -gt 4 ];then
	echo "Too many (${#octets[@]}) octets." >&2
	exit 1
fi
if [ "${#octets[@]}" -lt 4 ];then
	echo "Too few (${#octets[@]}) octets." >&2
	exit 1
fi
for o in "${octets[@]}";do
	if [ "${o}" -gt 255 ] &>> /dev/null;then
		echo "Octet value (${o}) too high." >&2
		exit 1
	fi
	if [ "${o}" -lt "0" ] &>> /dev/null ;then
		echo "Octet value (${o}) too low." >&2
		exit 1
	fi
	if ! [ "${o}" -gt "-1" ] &>> /dev/null ;then
		echo "Octet value (${o}) not number." >&2
		exit 1
	fi
done
echo "Yes, ${1} can be an IPv4 IP"
exit 0
