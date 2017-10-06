# moonlight_script_retropie (By TechWizTime - Addapted by me)

A script to automate install Moonlight Embeddeg in Retropie for Raspberry.

This script automates the process of installing Moonlight Embedded on the Debian-based operating systems for Raspberry Pi.

What this script does is update the source.list with the Moonlight installation repository, install moonlight, pause the desktop host, and create the list of games in the Emullationstation Retropie.

I used as a basis the TechWizTime script and added the features it has in the script to Recalbox which already creates the gamelist.xml and lowers the covers.

I'm sorry for any bug, as I'm still noob in bash scripts.

# Usage: 

1 - Log into your retropie via ssh.<br>

2 - Execute the commands:

wget http://tudosobreraspberry.info/moonlight/moonlight.sh

sudo chmod + x moonlight.sh

sudo ./moonlight.sh

3 - Select the desired option. To install moonlight completely, perform steps 1 through 4.

4 - Visit blog http://tudosobreraspberry.info
