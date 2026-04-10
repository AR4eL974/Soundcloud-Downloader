#!/bin/bash
#v1.2

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
	echo "Téléchargement de $TITRE..."
	sleep 1
	$YTMP3 "$lien"
	echo "Téléchargement fini"
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
	printf "   |    Télécharger: T  | ${GREEN}Modifier les playlists: M${NC} | Quitter: Q    |\n"
	printf "   |----------------------------------------------------------------|\n"
	printf "   |   ${GREEN}Ajouter: A${NC}   |  Supprimer des playlists: S | [*]Annuler: C   |\n"
	printf "   |----------------------------------------------------------------|\n"
	printf "   |                      Copier les playlists ici:                 |\n"
	printf "   |            ${RED}Ce lien semble ne pas être une playlist${NC}             |\n"
	printf "   |            ${RED}Voulez vous quand même le télécharger? ${NC}             |\n"
	printf "   |----------------------------------------------------------------|\n"
	printf "   |    Oui, Télécharger: O |    Non: N    |  Ajouter quand même: A |\n"
	printf "   |----------------------------------------------------------------|\n"
	read -sn 1 touche_son
	if [[ $touche_son == 'O' ]] || [[ $touche_son == 'o' ]];then


			clear
		appel_sons
	printf "   |----------------------------------------------------------------|\n"
	printf "   |    Télécharger: T  | ${GREEN}Modifier les playlists: M${NC} | Quitter: Q    |\n"
	printf "   |----------------------------------------------------------------|\n"
	printf "   |   ${GREEN}Ajouter: A${NC}   |  Supprimer des playlists: S | [*]Annuler: C   |\n"
	printf "   |----------------------------------------------------------------|\n"
	printf "   |                      Copier les playlists ici:                 |\n"
	printf "   |            ${RED}Ce lien semble ne pas être une playlist${NC}             |\n"
	printf "   |            ${RED}Voulez vous quand même le télécharger? ${NC}             |\n"
	printf "   |----------------------------------------------------------------|\n"
	printf "   |    ${GREEN}Oui, Télécharger: O${NC} |    Non: N    |  Ajouter quand même: A |\n"
	printf "   |----------------------------------------------------------------|\n"
		downloaded_exists=0
		echo "Téléchargement de $TITRE..."
		sleep 1
		current_dir=$(pwd)
		cd $TARGET_DIR
		if [[ $(ls | grep "downloaded.txt") != '' ]];then
			downloaded_exists=1
		fi
		$YTMP3 "$lien"
		echo "Téléchargement fini"
		if [[ $downloaded_exists == 0 ]];then
			rm downloaded.txt
		fi
		sleep 1
		cd $current_dir
	
	elif [[ $touche_son == 'a' ]] || [[ $touche_son == 'A' ]];then
		echo $lien >> ~/.config/soundcloud_downloader/playlists.csv

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
    echo "Dossier cible non trouvé, création de: $TARGET_DIR"
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
	echo "dossier de configuration non trouvé, création en cours" 
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
    echo "veuillez installer yt-dlp avant d'utiliser SoundCloud Downloader"
fi
YTMP3="yt-dlp --download-archive downloaded.txt --trim-filenames 100 --no-post-overwrites -ciwx --embed-thumbnail --audio-quality 0 --add-metadata --audio-format mp3 -o %(title)s "


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
		printf "   |  Dossier de Téléchargement: %-34s |\n" "$TARGET_DIR"


		printf "   |  (Appuyez sur F pour changer)                                  |\n"
		printf "   |                                                                |\n"
        printf "   |  Playlists à télécharger:                                      |\n"
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
	printf "   | Choisissez une option ci-dessous                               |\n"
	printf "   | Ou appuyez sur C pour coller un lien et télécharger directement|\n"

}




choix_init(){
printf "   |----------------------------------------------------------------|\n"
printf "   |      Télécharger: T   |     Modifier: M    |     Quitter: Q    |\n"
printf "   |----------------------------------------------------------------|\n"
}
appel_sons
choix_init
read -sn 1 touche

if [[ $touche == 'T' ]] || [[ $touche == 't' ]]; then
	clear
	appel_sons
	printf "   |----------------------------------------------------------------|\n"
	printf "   |      ${GREEN}Télécharger: T${NC}   |     Modifier: M    |     Quitter: Q    |\n"
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
	    echo -e " Téléchargement de :\e[32m $TITRE\e[0m"
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
	        echo "Téléchargement de : $PLAYLIST échoué"
	
	    else
	    echo -e " Téléchargement de \e[32m $TITRE\e[0m fini"
	    cd ..
	    fi
	    ((i++))
	done
	
	
	done
	echo ""
	echo ""
	echo "Tous les téléchargements sont finis"
	exit

elif [[ $touche == 'M' ]] || [[ $touche == 'm' ]] ; then
	clear
	appel_sons
	printf "   |----------------------------------------------------------------|\n"
	printf "   |      Télécharger: T   |     ${GREEN}Modifier: M${NC}    |     Quitter: Q    |\n"
	printf "   |----------------------------------------------------------------|\n"
	printf "   |   Ajouter: A   |  Supprimer des playlists: S | [*]Annuler: C   |\n"
	printf "   |----------------------------------------------------------------|\n"
	read -sn 1 touche2
	if [[ $touche2 == 'A' ]] || [[ $touche2 == 'a' ]] ; then
		clear
		appel_sons
	printf "   |----------------------------------------------------------------|\n"
	printf "   |      Télécharger: T   |     ${GREEN}Modifier: M${NC}    |     Quitter: Q    |\n"
	printf "   |----------------------------------------------------------------|\n"
	printf "   |   ${GREEN}Ajouter: A${NC}   |  Supprimer des playlists: S | [*]Annuler: C   |\n"
	printf "   |----------------------------------------------------------------|\n"
	printf "   |                      Copier les playlists ici:                 |\n"
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
				printf "   |      Télécharger: T   |     ${GREEN}Modifier: M${NC}    |     Quitter: Q    |\n"
				printf "   |----------------------------------------------------------------|\n"
				printf "   |   ${GREEN}Ajouter: A${NC}   |  Supprimer des playlists: S | [*]Annuler: C   |\n"
				printf "   |----------------------------------------------------------------|\n"
				printf "   |                      Copier les playlists ici:                 |\n"
				printf "   |                ${RED}Veuillez rentrer un lien valide               ${NC}  |\n"
				printf "   |----------------------------------------------------------------|\n"

			fi

		done


		TITRE=''


	elif [[ $touche2 == 'S' ]] || [[ $touche2 == 's' ]] ; then
		clear
		appel_sons
		printf "   |----------------------------------------------------------------|\n"
		printf "   |      Télécharger: T   |     ${GREEN}Modifier: M${NC}    |     Quitter: Q    |\n"
		printf "   |----------------------------------------------------------------|\n"
		printf "   |   Ajouter: A   |  ${GREEN}Supprimer des playlists: S${NC} | [*]Annuler: C   |\n"
		printf "   |----------------------------------------------------------------|\n"
		printf "   |     Veuillez séléctionner un numéro de playlist à supprimer    |\n"
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
	printf "   |      Entrez le nouveau dossier de téléchargement:              |\n"
	printf "   |                                                                |\n"
	read Path
	change_path $Path



elif [[ $touche == 'C' ]] || [[ $touche == 'c' ]] ; then
	clear
	appel_sons
	choix_init
	printf "   |                Copiez le lien ci-dessous:                      |\n"
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
						printf "   |         ${RED}Ce lien est une playlist et pas une musique${NC}            |\n"
						printf "   |----------------------------------------------------------------|\n"
						printf "   |         Télécharger:T         |    Ajouter à la liste: A       |\n"
						printf "   |----------------------------------------------------------------|\n"
						read -sn 1 touche_playlist
						if [[ $touche_playlist == 'T' ]] || [[ $touche_playlist == 't' ]];then
							clear
							appel_sons
							choix_init
							printf "   |                Copiez le lien ci-dessous:                      |\n"
							printf "   |----------------------------------------------------------------|\n"
							printf "   |           ${RED}This URL is a playlist and not a song${NC}                |\n"
							printf "   |----------------------------------------------------------------|\n"
							printf "   |         ${GREEN}Télécharger:T${NC}         |    Ajouter à la liste: A       |\n"
							printf "   |----------------------------------------------------------------|\n"
						    DOSSIER_LISTE=$TARGET_DIR"/"$TITRE
	    					mkdir -p "$DOSSIER_LISTE"
							current_dir=$(pwd)
	 					    cd "$DOSSIER_LISTE"
							echo "Téléchargement de $TITRE..."
							sleep 1
	    					$YTMP3 "$lien"
							echo "Téléchargement fini"
							cd $current_dir

							exit
						elif [[ $touche_playlist == 'A' ]] || [[ $touche_playlist == 'a' ]];then


							if [[ $(ls ~/.config | grep "soundcloud_downloader") != '' ]];then
								if [[ $(ls ~/.config/soundcloud_downloader | grep playlists.csv) != '' ]];then
									if [[ $(cat ~/.config/soundcloud_downloader/playlists.csv | grep "$lien") == '' ]];then
										echo $lien >> ~/.config/soundcloud_downloader/playlists.csv
										
									else 
										printf "${RED}Cette playlist est déjà dans la liste, elle ne sera pas ajoutée${NC}\n"
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
				printf "   |      Télécharger: T   |     ${GREEN}Modifier: M${NC}    |     Quitter: Q    |\n"
				printf "   |----------------------------------------------------------------|\n"
				printf "   |   ${GREEN}Ajouter: A${NC}   |  Supprimer des playlists: S | [*]Annuler: C   |\n"
				printf "   |----------------------------------------------------------------|\n"
				printf "   |                      Copier les playlists ici:                 |\n"
				printf "   |                ${RED}Veuillez rentrer un lien valide               ${NC}  |\n"
				printf "   |----------------------------------------------------------------|\n"

			fi

		done


		TITRE=''


elif [[ $touche == 'Q' ]] || [[ $touche == 'q' ]] ; then
	appel_sons	
	printf "   |----------------------------------------------------------------|\n"
	printf "   |    Télécharger: T  | Modifier les playlists: M | ${GREEN}Quitter: Q${NC}    |\n"
	printf "   |----------------------------------------------------------------|\n"
	exit

fi
done