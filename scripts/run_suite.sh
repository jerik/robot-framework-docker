#!/usr/bin/env bash
set -e

CMD="robot --console verbose --exclude once --outputdir /reports /suites"

# FIXME test: ==: unary operator expected
if test "$@" == "once"; then 
	# this will run the testcases with the tag "once"
	# In this testcase I create a random new user with the login credetials of suites/newuser.txt
	# the user is then activated and can be used by the other tests, where the testcases with tag "once" are excluded
	echo ":: RUN ONCE"
	zufall=$( openssl rand -hex 4 )
	rduser=bot-${zufall}
	echo '*** Variables ***' > suites/newuser.txt
	echo "\${USER}    ${rduser}" >> suites/newuser.txt
	echo "\${EMAIL}    ${rduser}@mailinator.com" >> suites/newuser.txt
	echo "\${USERPW}    ${zufall}#Mii" >> suites/newuser.txt

	CMD="robot --console verbose --include once --outputdir /reports /suites"
fi

echo Script run with arguments :: "$@"
echo ${CMD}

``${CMD}``
