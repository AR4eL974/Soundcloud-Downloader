#!/bin/bash

BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
mkdir -p ~/.config/soundcloud_downloader/
touch ~/.config/soundcloud_downloader/playlists.csv


change_path(){
	if [[ $(ls ~/.config | grep "soundcloud_downloader") != '' ]]; then
		if [[ $(ls ~/.config/soundcloud_downloader/config | grep "config") != '' ]]; then
			if [[ $(cat ~/.config/soundcloud_downloader/config | grep "DownloadPath") == '' ]];then
				echo "DownloadPath=$1" >> ~/.config/soundcloud_downloader/config
			else
				sed -i '/DownloadPath=/d' ~/.config/soundcloud_downloader/config
				echo "DownloadPath=$1" >> ~/.config/soundcloud_downloader/config				
			fi

		else 
			echo "DownloadPath=$1" > ~/.config/soundcloud_downloader/config
		fi
	else
		mkdir -p ~/.config/soundcloud_downloader/config
		echo "DownloadPath=$1" > ~/.config/soundcloud_downloader/config


	fi


}
son(){
	downloaded_exists=0
	mkdir -p $TARGET_DIR
	current_dir=$(pwd)
	cd $TARGET_DIR
	if [[ $(ls | grep "downloaded.txt") != '' ]];then
		downloaded_exists=1
	fi
	echo "Downloading $TITRE..."
	sleep 1
	$YTMP3 "$lien"
	echo "Download finished"
	if [[ $downloaded_exists == 0 ]];then
		rm downloaded.txt
	fi
	cd $current_dir
	sleep 1
						


}


not_playlist(){

	clear
	appel_sons
	printf "   |----------------------------------------------------------------|\n"
	printf "   |       Download: D    |    ${GREEN}Edit playlists: E${NC}    |    Quit: Q    |\n"
	printf "   |----------------------------------------------------------------|\n"
	printf "   |   ${GREEN}Add playlists: A${NC}   |   Delete playlists: D   | [*]Cancel: C  |\n"
	printf "   |----------------------------------------------------------------|\n"
	printf "   |                      Paste playlist here:                      |\n"
	printf "   |        ${RED}This URL appears to be a track and not a playlist.  ${NC}    |\n"
	printf "   |                  ${RED}Do you want to download it ? ${NC}                 |\n"
	printf "   |----------------------------------------------------------------|\n"
	printf "   | Yes, Download ts anyway  : Y |     No twin please don't: N     |\n"
	printf "   |----------------------------------------------------------------|\n"
	read -sn 1 touche_son
	if [[ $touche_son == 'Y' ]] || [[ $touche_son == 'y' ]];then


			clear
		appel_sons
		printf "   |----------------------------------------------------------------|\n"
		printf "   |       Download: D    |    ${GREEN}Edit playlists: E${NC}    |    Quit: Q    |\n"
		printf "   |----------------------------------------------------------------|\n"
		printf "   |   ${GREEN}Add playlists: A${NC}   |   Delete playlists: D   | [*]Cancel: C  |\n"
		printf "   |----------------------------------------------------------------|\n"
		printf "   |                      Paste playlist here:                      |\n"
		printf "   |        ${RED}This URL appears to be a track and not a playlist.  ${NC}    |\n"
		printf "   |                  ${RED}Do you want to download it ? ${NC}                 |\n"
		printf "   |----------------------------------------------------------------|\n"
		printf "   | ${GREEN}Yes, Download ts anyway  : Y${NC} |     No twin please don't: N     |\n"
		printf "   |----------------------------------------------------------------|\n"
		downloaded_exists=0
		echo "downloading $TITRE..."
		sleep 1
		current_dir=$(pwd)
		cd $TARGET_DIR
		if [[ $(ls | grep "downloaded.txt") != '' ]];then
			downloaded_exists=1
		fi
		$YTMP3 "$lien"
		echo "Download finished"
		if [[ $downloaded_exists == 0 ]];then
			rm downloaded.txt
		fi
		sleep 1
		cd $current_dir
	elif [[ $touche_son == 'n' ]] || [[ $touche_son == 'N' ]];then
		break
	fi


}
path_refresh(){
if [[ $(ls ~/.config/soundcloud_downloader | grep "config") != '' ]];then
	if [[ $(cat ~/.config/soundcloud_downloader/config | grep "DownloadPath") != '' ]];then
		TARGET_DIR=$(cat ~/.config/soundcloud_downloader/config | grep "DownloadPath")
		TARGET_DIR=${TARGET_DIR##*DownloadPath=}  
		if [[ $(echo "$TARGET_DIR" | grep "~") != '' ]];then
			TARGET_DIR=${TARGET_DIR##*~}
			TARGET_DIR="$HOME$TARGET_DIR"
		fi

	fi
else 
	TARGET_DIR="$HOME/Music/SoundCloud_Downloader"
fi
}
path_refresh
if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory not found, creating: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

while [[ 1 == 1 ]]; do
usage() {
    echo ""
    echo "Usage: $0 [options]"
    echo ""
    echo "-h            Displays this help menu"
    echo ""

    exit 1
}




if [[ $(ls ~/.config/ | grep "soundcloud_downloader") == '' ]];then
	echo ""
	echo ""
	echo "config directory not found, creating it" 
	echo ""
	echo "mkdir -p ~/.config/soundcloud_downloader"
	mkdir -p ~/.config/soundcloud_downloader
	sleep 1
fi
while getopts "d:h" opt; do
    case $opt in
        d)
            TARGET_DIR="$OPTARG"
			change_path $TARGET_DIR
			
            ;;
        h)
            usage
            ;;
        \?)
            echo "Invalid Option: -$OPTARG" >&2
            usage
            ;;
    esac
done



# Target directory control and creation


if ! command -v yt-dlp &> /dev/null; then
    echo "Please install yt-dlp before using SoundCloud Downloader"
fi
YTMP3="yt-dlp --download-archive downloaded.txt --no-post-overwrites -ciwx --embed-thumbnail --audio-quality 0 --add-metadata --audio-format mp3 -o %(title)s "


PLAYLISTS=$(awk -F',' -v l=1 -v col=1 'NR==l {print $col}' ~/.config/soundcloud_downloader/playlists.csv)
appel_sons(){
		path_refresh
        clear
        echo ""
        echo ""
        printf "   |----------------------------------------------------------------|\n"
        printf "   |                      SoundCloud Downloader                     |\n"
        printf "   |----------------------------------------------------------------|\n"
        printf "   |                                                                |\n"   
		printf "   |  Current Dowload Path: %-39s |\n" "$TARGET_DIR"
		printf "   |  (Press F to change)                                           |\n"
		printf "   |                                                                |\n"
        printf "   |  Current Playlists to downloads:                               |\n"
		printf "   |                                                                |\n"



	a='a'
	i=1
	if [[ $(ls ~/.config/soundcloud_downloader/ | grep "playlists.csv") == '' ]] ; then
		printf "   |                                                                |\n"
	else
		while [[ $a != '' ]]; do
			a=$(awk -F',' -v l=$i -v col=1 'NR==l {print $col}' ~/.config/soundcloud_downloader/playlists.csv)
			a=${a%/s-*}
			a=${a%\?*}  
			a=${a##*/}  
			if [[ $a != '' ]]; then
				printf "   |    ${BLUE}%-5s${NC} %-53s |\n" "[$i]" "$a"
			fi
			((i++))
		done
	fi
	
	printf "   |                                                                |\n"
	printf "   | Select one of the options below                                |\n"
	printf "   | Or press P and paste to directly download a playlist/song      |\n"

}




choix_init(){
printf "   |----------------------------------------------------------------|\n"
printf "   |       Download: D    |    Edit playlists: E    |    Quit: Q    |\n"
printf "   |----------------------------------------------------------------|\n"
}
appel_sons
choix_init
read -sn 1 touche

if [[ $touche == 'D' ]] || [[ $touche == 'd' ]]; then
	clear
	appel_sons
	printf "   |----------------------------------------------------------------|\n"
	printf "   |       ${GREEN}Download: D${NC}    |    Edit playlists: E    |    Quit: Q    |\n"
	printf "   |----------------------------------------------------------------|\n"

	PLAYLIST=0
	i=2
	
	while [[ $PLAYLIST != '' ]]; do
	
	mkdir -p "$TARGET_DIR"
	cd "$TARGET_DIR" || exit
	for PLAYLIST in "${PLAYLISTS[@]}"; do
	    PLAYLISTS=$(awk -F',' -v l=$i -v col=1 'NR==l {print $col}' ~/.config/soundcloud_downloader/playlists.csv)
	    if [[ $PLAYLIST == '' ]];then
		    break
	    fi
	    TITRE=${PLAYLIST%/s-*}
	    TITRE=${TITRE%\?*} 
	    TITRE=${TITRE##*/}  
	    echo ""
	    echo ""
	    echo -e " Downloading :\e[32m $TITRE\e[0m"
	    echo ""
	    echo ""
	    echo ""
	    DOSSIER_LISTE=$TARGET_DIR"/"$TITRE
	    mkdir -p "$DOSSIER_LISTE"
	    cd "$DOSSIER_LISTE" || exit
	    $YTMP3 "$PLAYLIST"
	    echo ""
	    echo ""
	    if [ $? -ne 0 ]; then
	        echo "Download of : $PLAYLIST Failed"
	
	    else
	    echo -e " Finished downloading \e[32m $TITRE\e[0m"
	    cd ..
	    fi
	    ((i++))
	done
	
	
	done
	echo ""
	echo ""
	echo "All playlists were downloaded"
	exit

elif [[ $touche == 'E' ]] || [[ $touche == 'e' ]] ; then
	clear
	appel_sons
	printf "   |----------------------------------------------------------------|\n"
	printf "   |       Download: D    |    ${GREEN}Edit playlists: E${NC}    |    Quit: Q    |\n"
	printf "   |----------------------------------------------------------------|\n"


	printf "   |   Add playlists: A   |   Delete playlists: D   | [*]Cancel: C  |\n"
	printf "   |----------------------------------------------------------------|\n"
	read -sn 1 touche2
	if [[ $touche2 == 'A' ]] || [[ $touche2 == 'a' ]] ; then
		clear
		appel_sons
		printf "   |----------------------------------------------------------------|\n"
		printf "   |       Download: D    |    ${GREEN}Edit playlists: E${NC}    |    Quit: Q    |\n"
		printf "   |----------------------------------------------------------------|\n"
		printf "   |   ${GREEN}Add playlists: A${NC}   |   Delete playlists: D   | [*]Cancel: C  |\n"
		printf "   |----------------------------------------------------------------|\n"




	
	
		printf "   |                      Paste playlist here:                      |\n"
		printf "   |----------------------------------------------------------------|\n"
		
		while [[ $TITRE == '' ]];do
			read lien
			if [[ $lien != '' ]] && [[ $(echo $lien | grep "://") != '' ]] && [[ $(echo $lien | grep "soundcloud.com") != '' ]] ;then
				TITRE=${lien%/s-*}  
			    TITRE=${TITRE%\?*} 
				TITRE=${TITRE##*/}
				
				if [[ $(echo "$lien" | grep "/sets/") != '' ]]; then

		    		if [[ $(echo "$lien" | grep "?in=") != '' ]]; then
			

						not_playlist

			    	else 
						echo $lien >> ~/.config/soundcloud_downloader/playlists.csv

		    		fi

				else 
					not_playlist
				fi


			else
				clear
				appel_sons
				printf "   |----------------------------------------------------------------|\n"
				printf "   |       Download: D    |    ${GREEN}Edit playlists: E${NC}    |    Quit: Q    |\n"
				printf "   |----------------------------------------------------------------|\n"
				printf "   |   ${GREEN}Add playlists: A${NC}   |   Delete playlists: D   | [*]Cancel: C  |\n"
				printf "   |----------------------------------------------------------------|\n"

				printf "   |                      Paste playlist here:                      |\n"
				printf "   |                ${RED}Please enter a valid playlist URL           ${NC}    |\n"
				printf "   |----------------------------------------------------------------|\n"

			fi

		done


		TITRE=''


	elif [[ $touche2 == 'D' ]] || [[ $touche2 == 'd' ]] ; then
		clear
		appel_sons
		printf "   |----------------------------------------------------------------|\n"
		printf "   |       Download: D    |    ${GREEN}Edit playlists: E${NC}    |    Quit: Q    |\n"
		printf "   |----------------------------------------------------------------|\n"
		printf "   |   Add playlists: A   |   ${GREEN}Delete playlists: D${NC}   |   Cancel: C   |\n"
		printf "   |----------------------------------------------------------------|\n"
		printf "   |           Please enter which number playlist to delete         |\n"
		printf "   |----------------------------------------------------------------|\n"
		((i--))
		read supp
		if [[ $supp -gt 0 ]] && [[ $supp -lt $i ]];then
			var="$supp""d"
			sed -i $var ~/.config/soundcloud_downloader/playlists.csv
			appel_sons
		fi


	fi


elif [[ $touche == 'F' ]] || [[ $touche == 'f' ]] ; then

	appel_sons
	printf "   |----------------------------------------------------------------|\n"
	printf "   |      Please type new Download path:                            |\n"
	printf "   |                                                                |\n"
	read Path
	change_path $Path



elif [[ $touche == 'P' ]] || [[ $touche == 'p' ]] ; then
	clear
	appel_sons
	choix_init
	printf "   |                      Paste playlist here:                      |\n"
	printf "   |----------------------------------------------------------------|\n"
		
		while [[ $TITRE == '' ]];do
			read lien
			if [[ $lien != '' ]] && [[ $(echo $lien | grep "://") != '' ]] && [[ $(echo $lien | grep "soundcloud.com") != '' ]] ;then
				TITRE=${lien%/s-*}  
			    TITRE=${TITRE%\?*} 
				TITRE=${TITRE##*/}
				
				if [[ $(echo "$lien" | grep "/sets/") != '' ]]; then

		    		if [[ $(echo "$lien" | grep "?in=") != '' ]]; then
						son

			    	else 
						clear
						appel_sons
						choix_init
						printf "   |           ${RED}This URL is a playlist and not a song${NC}                |\n"
						printf "   |----------------------------------------------------------------|\n"
						printf "   |         Download:D            |   Add to download queue: A     |\n"
						printf "   |----------------------------------------------------------------|\n"
						read -sn 1 touche_playlist
						if [[ $touche_playlist == 'D' ]] || [[ $touche_playlist == 'd' ]];then
							clear
							appel_sons
							choix_init
							printf "   |                      Paste playlist here:                      |\n"
							printf "   |----------------------------------------------------------------|\n"
							printf "   |           ${RED}This URL is a playlist and not a song${NC}                |\n"
							printf "   |----------------------------------------------------------------|\n"
							printf "   |         ${GREEN}Download:D${NC}            |   Add to download queue: A     |\n"
							printf "   |----------------------------------------------------------------|\n"
						    DOSSIER_LISTE=$TARGET_DIR"/"$TITRE
	    					mkdir -p "$DOSSIER_LISTE"
							current_dir=$(pwd)
	 					    cd "$DOSSIER_LISTE"
							echo "Downloading $TITRE..."
							sleep 1
	    					$YTMP3 "$lien"
							echo "Download finished"
							cd $current_dir

							exit
						elif [[ $touche_playlist == 'A' ]] || [[ $touche_playlist == 'a' ]];then


							if [[ $(ls ~/.config | grep "soundcloud_downloader") != '' ]];then
								if [[ $(ls ~/.config/soundcloud_downloader | grep playlists.csv) != '' ]];then
									if [[ $(cat ~/.config/soundcloud_downloader/playlists.csv | grep "$lien") == '' ]];then
										echo $lien >> ~/.config/soundcloud_downloader/playlists.csv
										echo "ok"
										exit
									else 
										printf "${RED}this playlist is already queued, not adding it${NC}\n"
										sleep 2
									fi

								else
									echo $lien > ~/.config/soundcloud_downloader/playlists.csv

								fi
							else
								mkdir -p ~/.config/soundcloud_downloader
								echo $lien > ~/.config/soundcloud_downloader/playlists.csv
							fi
							
						fi

						
		    		fi

				else 
					son

				fi


			else
				clear
				appel_sons
				printf "   |----------------------------------------------------------------|\n"
				printf "   |       Download: D    |    ${GREEN}Edit playlists: E${NC}    |    Quit: Q    |\n"
				printf "   |----------------------------------------------------------------|\n"
				printf "   |   ${GREEN}Add playlists: A${NC}   |   Delete playlists: D   | [*]Cancel: C  |\n"
				printf "   |----------------------------------------------------------------|\n"

				printf "   |                      Paste playlist here:                      |\n"
				printf "   |                ${RED}Please enter a valid playlist URL           ${NC}    |\n"
				printf "   |----------------------------------------------------------------|\n"

			fi

		done


		TITRE=''


elif [[ $touche == 'Q' ]] || [[ $touche == 'q' ]] ; then
	appel_sons	
	printf "   |----------------------------------------------------------------|\n"
	printf "   |       Download: D    |    Edit playlists: E    |    ${GREEN}Quit: Q${NC}    |\n"
	printf "   |----------------------------------------------------------------|\n"
	exit

fi
done