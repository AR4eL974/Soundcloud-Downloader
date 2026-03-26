#!/bin/bash

BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

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
if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory not found, creating: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

if ! command -v yt-dlp &> /dev/null; then
    echo "Please install yt-dlp before using SoundCloud Downloader"
fi
YTMP3="yt-dlp --download-archive downloaded.txt --no-post-overwrites -ciwx --embed-thumbnail --audio-quality 0 --add-metadata --audio-format mp3 -o %(title)s "


PLAYLISTS=$(awk -F',' -v l=1 -v col=1 'NR==l {print $col}' ~/.config/soundcloud_downloader/tracks.csv)
appel_sons(){
        clear
        echo ""
        echo ""
        printf "   |----------------------------------------------------------------|\n"
        printf "   |                      SoundCloud Downloader                     |\n"
        printf "   |----------------------------------------------------------------|\n"
        printf "   |                                                                |\n"        
        printf "   |      Current Playlists to downloads:                           |\n"
	printf "   |                                                                |\n"

	a='a'
	i=1
	if [[ $(ls ~/.config/soundcloud_downloader/ | grep "tracks.csv") == '' ]] ; then
		printf "   |                                                                |\n"
	else
		while [[ $a != '' ]]; do
			a=$(awk -F',' -v l=$i -v col=1 'NR==l {print $col}' ~/.config/soundcloud_downloader/tracks.csv)
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
	    PLAYLISTS=$(awk -F',' -v l=$i -v col=1 'NR==l {print $col}' ~/.config/soundcloud_downloader/tracks.csv)
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
		echo $lien >> ~/.config/soundcloud_downloader/tracks.csv
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
			sed -i $var ~/.config/soundcloud_downloader/tracks.csv
			appel_sons
		fi


	fi

elif [[ $touche == 'Q' ]] || [[ $touche == 'q' ]] ; then
	appel_sons	
	printf "   |----------------------------------------------------------------|\n"
	printf "   |       Download: D    |    Edit playlists: E    |    ${GREEN}Quit: Q${NC}    |\n"
	printf "   |----------------------------------------------------------------|\n"
	exit

fi
done
