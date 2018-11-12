#!/bin/bash
ssh-add -l | grep "runabout_test" > /dev/null
if [ $? -ne 0 ]; then
    ssh-add ~/.ssh/runabout_test.id_rsa
fi
ssh runabout_test
