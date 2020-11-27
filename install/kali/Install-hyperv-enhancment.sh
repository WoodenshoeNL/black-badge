#!/bin/bash

sudo git clone https://github.com/mimura1133/linux-vm-tools /opt/linux-vm-tools

sudo chmod 0755 /opt/linux-vm-tools/kali/2020.x/install.sh

sudo /opt/linux-vm-tools/kali/2020.x/install.sh

sudo reboot -f

#in host: Set-VM "(YOUR VM NAME HERE)" -EnhancedSessionTransportType HVSocket
