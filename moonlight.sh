#!/bin/bash

echo -e "\n******************************************************"
echo -e "Bem vindo ao script de instalação do Moonlight para RetroPie"
echo -e "Versão: 2.1 - 2018-12-08" 
echo -e "******************************************************\n"
echo -e "Este script é uma contribuição para a comunidade."
echo -e "Este script, além de permitir instalar o moonlight,"
echo -e "cria o menu dos jogos e baixa as capas automaticamente."
echo -e "Desenvolvido por TechWizTime e rpf16rj do blog http://tudosobreraspberry.info"
echo -e "\n***************************************************\n"
echo -e "Selecione uma opcao:"
echo -e " * 1: Install Moonlight"
echo -e " * 2: Pair Moonlight"
echo -e " * 3: Create or Update Menu Games and Scrapping"
echo -e " * 4: Restart Retropie to apply Moonlight changes."
echo -e " * 5: Unpair Moonlight"
echo -e " * 6: Unninstall Moonlight"
echo -e " * 0: Exit"
echo -e "\n"
echo -e "Digite um número: "
read NUM
case $NUM in
	1) echo -e "\n*******************************************"
		echo -e "Adding Moonlight to Sources List"
		echo -e "*******************************************\n"
		echo "deb http://archive.itimmer.nl/raspbian/moonlight stretch main" >> /etc/apt/sources.list
		echo -e "\nDONE!!\n"


		echo -e "\n****************************************"
		echo -e "Fetch and install the GPG key"
		echo -e "****************************************\n"
		wget http://archive.itimmer.nl/itimmer.gpg
		apt-key add itimmer.gpg


		echo -e "\n*******************************"
		echo -e "Run a quick UPDATE"
		echo -e "*******************************\n"
		apt-get update -y
		
		
		echo -e "\n**************************************"
		echo -e "Install Moonlight Software"
		echo -e "**************************************\n"
		apt-get install moonlight-embedded -y
		echo -e "\nDONE!! Moonlight Embedded installed!\n"
		./moonlight.sh
	;;
	2) echo -e "\n***************************************"
		echo -e "Pairing Moonlight with STEAM"
		echo -e "***************************************\n"
		echo -e "Once you have input your STEAM PC's IP Address below, you will be given a PIN"
		echo -e "Input this on the STEAM PC to pair with Moonlight. \n"
		read -p "Input STEAM PC's IP Address here :`echo $'\n> '`" ip
		sudo -u pi moonlight pair $ip

		echo -e "\n*******************************************"
		echo -e "Create STEAM Menu List"
		echo -e "*******************************************\n"
		
		if [ -f /home/pi/.emulationstation/es_systems.cfg ]
		then
			
			if ! grep -q steam "/home/pi/.emulationstation/es_systems.cfg"; then
				echo -e "\nAdding Steam to Systems \n"
				sed -i -e 's|</systemList>|  <system>\n    <name>steam</name>\n    <fullname>Steam</fullname>\n    <path>/home/pi/RetroPie/roms/moonlight</path>\n    <extension>.txt .TXT</extension>\n    <command>/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ moonlight %ROM%</command>\n    <platform>steam</platform>\n    <theme>steam</theme>\n  </system>\n</systemList>|g' /home/pi/.emulationstation/es_systems.cfg
			fi
			
		else
			echo -e "\nCopying Systems Config File \n"
			cp /etc/emulationstation/es_systems.cfg /home/pi/.emulationstation/es_systems.cfg
		
			if ! grep -q steam "/home/pi/.emulationstation/es_systems.cfg"; then
				echo -e "\nAdding Steam to Systems \n"
				sed -i -e 's|</systemList>|  <system>\n    <name>steam</name>\n    <fullname>Steam</fullname>\n    <path>/home/pi/RetroPie/roms/moonlight</path>\n    <extension>.txt .TXT</extension>\n    <command>/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ moonlight %ROM%</command>\n    <platform>steam</platform>\n    <theme>steam</theme>\n  </system>\n</systemList>|g' /home/pi/.emulationstation/es_systems.cfg
			fi
		
		fi
		
		chown -R pi:pi /home/pi/RetroPie/roms/moonlight/
		chown pi:pi /home/pi/.emulationstation/es_systems.cfg
		
		echo -e "\n*****************************************"
		echo -e "Creating Steam emu option in emulators.cfg :)"
		echo -e "*****************************************\n"
		[ ! -d "/opt/retropie/configs/moonlight" ] && mkdir -p "/opt/retropie/configs/moonlight"
		
		echo '#!/bin/bash' >>  /opt/retropie/configs/moonlight/start_stream_1080_60.sh
		echo 'game=$(cat "$1") &&' >>  /opt/retropie/configs/moonlight/start_stream_1080_60.sh
		echo 'moonlight stream -1080 -fps 60 -app "$game"' >>  /opt/retropie/configs/moonlight/start_stream_1080_60.sh
		
		echo '#!/bin/bash' >>  /opt/retropie/configs/moonlight/start_stream_1080_30.sh
		echo 'game=$(cat "$1") &&' >>  /opt/retropie/configs/moonlight/start_stream_1080_30.sh
		echo 'moonlight stream -1080 -fps 30 -app "$game"' >>  /opt/retropie/configs/moonlight/start_stream_1080_30.sh
		
		echo '#!/bin/bash' >>  /opt/retropie/configs/moonlight/start_stream_720_60.sh
		echo 'game=$(cat "$1") &&' >>  /opt/retropie/configs/moonlight/start_stream_720_60.sh
		echo 'moonlight stream -720 -fps 60 -app "$game"' >>  /opt/retropie/configs/moonlight/start_stream_720_60.sh
		
		echo '#!/bin/bash' >>  /opt/retropie/configs/moonlight/start_stream_720_30.sh
		echo 'game=$(cat "$1") &&' >>  /opt/retropie/configs/moonlight/start_stream_720_30.sh
		echo 'moonlight stream -720 -fps 30 -app "$game"' >>  /opt/retropie/configs/moonlight/start_stream_720_30.sh
		
		echo 'steam_1080p_60fps = "/opt/retropie/configs/moonlight/start_stream_1080_60.sh %ROM%"' >>  /opt/retropie/configs/moonlight/emulators.cfg
		echo 'steam_1080p_30fps = "/opt/retropie/configs/moonlight/start_stream_1080_30.sh %ROM%"' >>  /opt/retropie/configs/moonlight/emulators.cfg
		echo 'steam_720p_60fps = "/opt/retropie/configs/moonlight/start_stream_720_60.sh %ROM%"' >>  /opt/retropie/configs/moonlight/emulators.cfg
		echo 'steam_720p_30fps = "/opt/retropie/configs/moonlight/start_stream_720_30.sh %ROM%"' >>  /opt/retropie/configs/moonlight/emulators.cfg
		echo 'default = "steam_1080p_60fps"' >>  /opt/retropie/configs/moonlight/emulators.cfg
		
		chown -R pi:pi /opt/retropie/configs/moonlight/
		chown pi:pi /opt/retropie/configs/moonlight/emulators.cfg
		chown pi:pi /opt/retropie/configs/moonlight/start_stream_1080_60.sh
		chown pi:pi /opt/retropie/configs/moonlight/start_stream_1080_30.sh
		chown pi:pi /opt/retropie/configs/moonlight/start_stream_720_60.sh
		chown pi:pi /opt/retropie/configs/moonlight/start_stream_720_30.sh

		chmod +x /opt/retropie/configs/moonlight/start_stream_1080_60.sh
		chmod +x /opt/retropie/configs/moonlight/start_stream_1080_30.sh
		chmod +x /opt/retropie/configs/moonlight/start_stream_720_60.sh
		chmod +x /opt/retropie/configs/moonlight/start_stream_720_30.sh


		wget http://tudosobreraspberry.info/moonlight/launching.jpg -O "/opt/retropie/configs/moonlight/launching.jpg" >/dev/null 2>&1
		
		echo -e "\n\n\n************************************************"
		echo -e "INSTALL and SETUP Script for Moonlight completed"
		echo -e "************************************************\n\n\n"
		echo -e "\nDONE!!\n"
		./moonlight.sh
	;;
	3) echo -e "\n**************************************************"
		echo -e "Creating gamelist.xml and scrap"
		echo -e "**************************************************\n"
		[ ! -d "/home/pi/RetroPie/roms/moonlight" ] && mkdir -p "/home/pi/RetroPie/roms/moonlight"	

		rm /home/pi/RetroPie/roms/moonlight/*
		
		echo -e "Creating games..."
		#sudo -u pi moonlight list 2>/dev/null | grep '^[0-9][0-9.]' | cut -d "." -f2 | sed 's/[^a-z A-Z 0-9 -]//g' >> games.txt
		sudo -u pi moonlight list 2>/dev/null | grep '^[0-9][0-9.]' | cut -d "." -f2 | sed 's/^ \(.*\)$/\1/' >> gamesreal.txt
		
		#while read line
		#do
		#touch "/home/pi/RetroPie/roms/moonlight/${line}.txt"
		#done < games.txt
		
		while read line
		do
		realname=${line//:/}
		if ! grep -q realname "/home/pi/RetroPie/roms/moonlight/${realname}.txt"; then
			echo -e $line >> "/home/pi/RetroPie/roms/moonlight/${realname}.txt"
		fi
		
		done < gamesreal.txt
		
		echo -e "Game menu created!"
		
		echo -e "Skipping scrapping... api down!"
		
		#echo -e "Scrapping... please wait. Take a coffe."
		
		#GDBURL="http://thegamesdb.net/api/GetGame.php?platform=pc&exactname="
	  #GAMELIST=/home/pi/RetroPie/roms/moonlight/gamelist.xml
	  #IMGPATH=/home/pi/RetroPie/roms/moonlight/downloaded_images

	  # Test if $GDBURL is online, and stop if it's offline
	  #dbdns=$(echo $GDBURL | awk -F/ '{print $3}')
	  #ping -c 1 $dbdns > /dev/null 2>&1
	  #if [ $? -ne '0' ]
	  #then
    #echo "$dbdns is not online. Can't scrape" >&2
    #exit
 # fi

  # Make sure the $IMGPATH exists
 # [ ! -d $IMGPATH ] && mkdir -p $IMGPATH


  # This is what we were waiting for : generate the gamelist.xml
  echo '<?xml version="1.0"?>' > $GAMELIST
  echo '<gameList>' >> $GAMELIST

  while read line
  do
    xmlfilename="/tmp/${line}.xml"
    gamename=$line

    # download XML game data from TheGamesDB.net
    #wget "$GDBURL$gamename" -O "$xmlfilename" >/dev/null 2>&1

    # Time to get values for the gamelist.xml
    #id=$(xmlstarlet sel -t -v "Data/Game/id" "$xmlfilename" 2>/dev/null)
    #source="theGamesDB.net"
    #path="./${line}.txt"
    #desc=$(xmlstarlet sel -t -v "Data/Game/Overview" "$xmlfilename" 2>/dev/null)

    # A few steps to get the cover art url
    #imgurl=$(xmlstarlet sel -t -v "Data/baseImgUrl" -v "Data/Game/Images/boxart[@side='front']/@thumb" "$xmlfilename" 2>/dev/null)
    #extension=$(echo $imgurl | awk -F . '{print $NF}')
    #img="$IMGPATH/${gamename}.${extension}"
    #wget "$imgurl" -O "$img" >/dev/null 2>&1

    #rating=$(xmlstarlet sel -t -v "Data/Game/Rating" "$xmlfilename" 2>/dev/null)
    #releasedate=$(xmlstarlet sel -t -v "Data/Game/ReleaseDate" "$xmlfilename" 2>/dev/null | sed 's/^\([0-9]\{2\}\)\/\([0-9]\{2\}\)\/\([0-9]\{4\}\)/\3\1\2T0000/')
    #developer=$(xmlstarlet sel -t -v "Data/Game/Developer" "$xmlfilename" 2>/dev/null)
    #publisher=$(xmlstarlet sel -t -v "Data/Game/Publisher" "$xmlfilename" 2>/dev/null)
    #genre=$(xmlstarlet sel -T -t -m "Data/Game/Genres/genre" -v 'text()' -i 'not(position()=last())' -o ' / ' "$xmlfilename" 2>/dev/null)
    #players=$(xmlstarlet sel -t -v "Data/Game/Players" "$xmlfilename" 2>/dev/null)
    # Write the XML data
    cat << EOF >> $GAMELIST
  <game id="$id" source="$source">
    <path>$path</path>
    <name>$gamename</name>
    #<desc>$desc</desc>
    #<image>./downloaded_images/${gamename}.${extension}</image>
    #<rating>$rating</rating>
    #<releasedate>$releasedate</releasedate>
    #<developer>$developer</developer>
    #<publisher>$publisher</publisher>
    #<genre>$genre</genre>
    #<players>$players</players>
  </game>
EOF

  rm "$xmlfilename"
  done < gamesreal.txt
  
  
  echo '</gameList>' >> $GAMELIST
		
		echo -e "\n\n\n************************************************"
		echo -e "Games Menu Creation completed"
		echo -e "************************************************\n\n\n"
		./moonlight.sh
	;;
	4) 	echo -e "\nRestart Retropie to apply changes Moonlight\n"
		
		read -p "Restart now? (y/n)?" choice
		case "$choice" in 
		  y|Y ) reboot;;
		  n|N ) ./moonlight.sh
		  ;;
		  * ) echo "invalid";;
		  esac
	;;
	5) 
		echo -e "\n***************************************"
		echo -e "RE Unpairing Moonlight"
		echo -e "***************************************\n"
		sudo -u pi moonlight unpair
		
		echo -e "\n\n\n************************************************"
		echo -e "Unpair completed"
		echo -e "************************************************\n\n\n"
		./moonlight.sh
	;;
	6) 
		echo -e "\n***************************************"
		echo -e "Unninstall Moonlight"
		echo -e "***************************************\n"
		apt-get remove moonlight-embedded -y 
		
		rm /home/pi/RetroPie/roms/moonlight/downloaded_images/*
		rmdir /home/pi/RetroPie/roms/moonlight/downloaded_images
		rm /home/pi/RetroPie/roms/moonlight/*
		rm /opt/retropie/configs/moonlight/*
		rmdir /opt/retropie/configs/moonlight
		
		echo -e "\n\n\n************************************************"
		echo -e "Unninstall completed"
		echo -e "************************************************\n\n\n"
		./moonlight.sh
	;;
	0)  exit 1;;
	*) echo "INVALID NUMBER!" ;;
esac
