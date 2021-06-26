#!/bin/bash

################################################################
# get tunnel ip
################################################################
ip=$(ip addr show tun0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

################################################################
# Refresh ip
################################################################
#change ip addresses in scripts
sed -i "s/10.10.10.10/$ip/g" ~/script/*

#change ip addresses in reverse shell
sed -i "s/10.10.10.10/$ip/g" ~/reverse-shell/*
sed -i "s/192.168.254.1/$ip/g" ~/reverse-shell/*
