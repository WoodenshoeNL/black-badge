#!/bin/bash

feroxbuster --url http://$1 -o ferox-extended-$1.txt --add-slash --extract-links
