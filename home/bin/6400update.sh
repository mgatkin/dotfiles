#!/bin/bash
rsync -avz `find ~/trunk/app/evcode/Debug -maxdepth 1 -perm 755 -type f` -e ssh windrock@10.75.20.59:~/evcode
rsync -avz `find ~/trunk/app -name "libWindrock*.so" -perm 755 -type f` -e ssh windrock@10.75.20.59:~/evcode

