#!/bin/bash
PRIVATE_IP=$(hostname -I | awk '{print $1}')
echo "Private IP address: $PRIVATE_IP" > /home/ec2-user/private-ip.txt
