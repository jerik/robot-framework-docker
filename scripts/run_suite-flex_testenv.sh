#!/usr/bin/env bash
set -e

# ex: ./run_test.sh 
CMD="robot --console verbose --exclude once --outputdir /reports /suites"
resource_file="suites/newuser.txt"

# Test if variabel is empty
if [[ ! -z "$@" ]]; then 

	# get the environement which shall be tested
	# default 
	test_env="test"

	echo $@
	first_parameter="$1"
	if [[ $first_parameter =~ "--" ]]; then 
	# check if an environment is specified, ex: ./runtest test --include once
		echo "no environement detected: run tests with default environment: $test_env"
	else 
		if test $first_parameter == "dev"; then 
		# check if the dev1 environemnt should be used
			test_env="dev1"
			echo "environement detected: run tests with default environment: $test_env"
		else 
		# wrong environment found, used default one
			echo "environement detected: run tests with default environment: $test_env"
		fi
		shift
	fi

	if [[ "$first_parameter" == "once" ]]; then 
		# ex: ./run_test.sh once
		# this will run the testcases with the tag "once"
		# In this testcase I create a random new user with the login credetials of suites/newuser.txt
		# the user is then activated and can be used by the other tests, where the testcases with tag "once" are excluded
		echo ":: RUN ONCE"
		zufall=$( openssl rand -hex 4 )
		rduser=bot-${zufall}
		echo '*** Variables ***' > $resource_file
		echo "\${USER}    ${rduser}">> $resource_file
		echo "\${EMAIL}    ${rduser}" >> $resource_file
		echo "\${USERPW}    ${zufall}#Mii" >> $resource_file
		echo "\${AUTHURL}    https://admin:testserver@${test_env}.doccons24.de/login" >> $resource_file
		echo "\${BASEURL}    https://${test_env}.doccons24.de" >> $resource_file

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
