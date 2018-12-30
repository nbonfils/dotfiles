#! /bin/bash
#
# 160824.0930
#
# add ssh pub key of this machine to all up servers

P="password"
PASS="" # TODO

RSA=`cat ~/.ssh/id_rsa.pub`

for i in seq -s ' ' 9
do
	if nc -z 127.0.0.1 3122$i
	then

		ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ubuntu@128.178.116.122 -p 3122$i "echo $RSA >> ~/.ssh/authorized_keys"
		expect $P
		send $PASS

	fi
done
