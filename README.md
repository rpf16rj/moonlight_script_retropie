# Moonlight Automatize Install <br>(By TechWizTime - Addapted by me)

A script to automate install Moonlight Embeddeg in Retropie for Raspberry.

This script automates the process of installing Moonlight Embedded on the Debian-based operating systems for Raspberry Pi.

What this script does is update the source.list with the Moonlight installation repository, install moonlight, pause the desktop host, and create the list of games in the Emullationstation Retropie.

I used as a basis the TechWizTime script and added the features it has in the script to Recalbox which already creates the gamelist.xml and lowers the covers.

I'm sorry for any bug, as I'm still noob in bash scripts.

# Features
- Automatize install moonlight process
- Auto create Steam Menu in es_system.cfg
- Auto create gamelist.xml based output 'moonlight list' command
- Auto scrap games
- launching.jpg image added on launch a game.
- If press any button on loading a game, have choice option of Stream (1080p 60fps, 1080p 30fps, 720p 60fps, 720p 30fps).

# Usage: 

1 - Log into your retropie via ssh.<br>

2 - Execute the commands:

git clone https://github.com/rpf16rj/moonlight_script_retropie && cd moonlight_script_retropie && sudo chmod +x moonlight.sh && sudo ./moonlight.sh

3 - Select the desired option. To install moonlight completely, perform steps 1 through 4.

4 - Visit blog http://tudosobreraspberry.info
