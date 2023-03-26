#!/bin/bash

# This script installs Docker on an EC2 instance.
# It is intended to be run as a user data script when the instance is created.
sudo yum update -y
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
