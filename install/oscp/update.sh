#!/bin/bash

################################################################
# pull repository
################################################################
# black-badge
cd ~/black-badge
git pull >/dev/null

# black-badge-private
cd ~/black-badge-private
git pull >/dev/null

#lab
cd ~/lab
git pull >/dev/null


################################################################
# Refresh Enum
################################################################
cd ~
rm -rf -d enum
mkdir enum 2>/dev/null
cd enum

#get LinEnum script
wget https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh -O linEnum.sh
chmod +x linEnum.sh

#get linpeas script
wget https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/linPEAS/linpeas.sh -O linpeas.sh
chmod +x linpeas.sh

#get winpeas script
wget https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/winPEAS/winPEASbat/winPEAS.bat -O winPEAS.bat
wget https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/winPEAS/winPEASexe/binaries/x64/Release/winPEASx64.exe -O winPEASx64.exe
wget https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/winPEAS/winPEASexe/binaries/x86/Release/winPEASx86.exe -O winPEASx86.exe

#get Linux suggester:
wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -O les.sh
chmod +x les.sh

#get Linux Smart Enumeration:
wget https://raw.githubusercontent.com/diego-treitos/linux-smart-enumeration/master/lse.sh -O lse.sh
chmod +x lse.sh

#add start python web server script:
echo "sudo python3 -m http.server 6680" > start-pythonwebserver.sh
chmod +x start-pythonwebserver.sh

################################################################
# Refresh Recon
################################################################
cd ~
rm -rf -d recon
mkdir recon 2>/dev/null
cd recon
cp ~/black-badge/K/Battle/Red/Recon/ . -r
