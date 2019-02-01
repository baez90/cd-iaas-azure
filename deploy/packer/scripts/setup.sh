#!/usr/bin/env bash

sudo chown -R ca:ca /opt/ca
sudo mv /tmp/hackathon.service /lib/systemd/system/hackathon.service
sudo systemctl enable hackathon.service