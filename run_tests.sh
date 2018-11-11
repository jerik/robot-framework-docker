#!/usr/bin/env bash

zufall=$( openssl rand -hex 4 )
rduser=bot-${zufall}
echo '*** Variables ***' > suites/newuser.txt
echo "\${USER}    ${rduser}" >> suites/newuser.txt
echo "\${EMAIL}    ${rduser}@mailinator.com" >> suites/newuser.txt
echo "\${USERPW}    ${zufall}#Mii" >> suites/newuser.txt

docker run --rm \
           -e USERNAME="Ipatios Asmanidis" \
           --net=host \
           -v "$PWD/output":/output \
           -v "$PWD/suites":/suites \
           -v "$PWD/scripts":/scripts \
           -v "$PWD/reports":/reports \
           --security-opt seccomp:unconfined \
           --shm-size "256M" \
           ypasmk/robot-framework
