#!/bin/bash

# This script has been written for this exercise environment 
# and is not intented to be used in a production enviroment
# Execute by: ./exercise2Task4.sh


for run in {1..3}; do
    echo "Run: kubwor1-$run"
    echo "Step 1"
    scp -o "StrictHostKeyChecking=no" multipath.conf root@kubwor1-$run:/etc/multipath.conf
    echo "Step 2"
    ssh root@kubwor1-$run "sudo systemctl enable --now iscsid multipathd"
    ssh root@kubwor1-$run "sudo service multipathd restart"
    echo "Step 3"
    ssh root@kubwor1-$run "cat /etc/iscsi/initiatorname.iscsi"
    echo "Step 4"
    ssh root@kubwor1-$run "sudo modprobe nvme-tcp"
    echo "Step 5"
    ssh root@kubwor1-$run "cat /etc/nvme/hostnqn"
done

for run in {1..2}; do
    echo "Run: kubwor2-$run"
    echo "Step 1"
    scp -o "StrictHostKeyChecking=no" multipath.conf root@kubwor2-$run:/etc/multipath.conf
    echo "Step 2"
    ssh root@kubwor1-$run "sudo systemctl enable --now iscsid multipathd"
    ssh root@kubwor1-$run "sudo service multipathd restart"
    echo "Step 3"
    ssh root@kubwor1-$run "cat /etc/iscsi/initiatorname.iscsi"
    echo "Step 4"
    ssh root@kubwor1-$run "sudo modprobe nvme-tcp"
    echo "Step 5"
    ssh root@kubwor1-$run "cat /etc/nvme/hostnqn"
done
