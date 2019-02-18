#!/usr/bin/env bash
set -e

# ex: ./run_test.sh 
CMD="robot --console verbose --exclude once --outputdir /reports /suites"

# Test if not variabel is empty
if [[ ! -z "$@" ]]; then 

	if [[ "$@" = "once" ]]; then 
		# ex: ./run_test.sh once
		# this will run the testcases with the tag "once"
		# In this testcase I create a random new user with the login credetials of suites/newuser.txt
		# the user is then activated and can be used by the other tests, where the testcases with tag "once" are excluded
		echo ":: RUN ONCE"
		zufall=$( openssl rand -hex 4 )
		rduser=bot-${zufall}
		config_file=suites/newuser.txt
		echo '*** Variables ***' > $config_file
		echo "\${USER}    ${rduser}" >> $config_file
		echo "\${EMAIL}    ${rduser}@mailinator.com" >> $config_file
		#echo "\${USERPW}    ${zufall}#Mii" >> $config_file
		echo "\${USERPW}    Calvin#007" >> $config_file

		# ${AUTHURL}    https://admin:testserver@dev1.doccons24.de/login
		# ${BASEURL}    https://dev1.doccons24.de
		echo >> $config_file
		echo "\${AUTHURL}    https://admin:testserver@test.doccons24.de/login" >> $config_file
		echo "\${BASEURL}    https://test.doccons24.de" >> $config_file

		CMD="robot --console verbose --include once --outputdir /reports /suites"
	else 
		# ex: ./run_test.sh --include capture
		# ex: ./run_test.sh --exclude capture
		CMD="robot --console verbose $@ --outputdir /reports /suites"
	fi
fi

echo Script run with arguments :: "$@"
echo ${CMD}

``${CMD}``
