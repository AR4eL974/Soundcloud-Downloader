#!/bin/bash

language_choice(){
        choisi=0
        while [[ $choisi == 0 ]];do
                clear
                echo "choose a language to install SoundCloud-Downloader: "
                echo "French: F "
                echo "English: E"
                read -sn 1 touche
                if [[ $touche == 'E' ]] || [[ $touche == 'e' ]];then
                        language="en"
                        choisi=1
                        clear
                        echo "English"
                elif [[ $touche == 'F' ]] || [[ $touche == 'f' ]]; then
                        language="fr"
                        choisi=1
                        clear
                        echo "Français"
                fi
        done
}
os_detect(){
        
        if [[ $(which pacman) != '' ]]; then
                OS="Arch"
        elif [[ $(which apt) != '' ]]; then
                OS="Debian"
        elif [[ $(which dnf) != '' ]]; then
                OS="Redhat"
        fi
}


arch_installation(){
        echo "installing yt-dlp and ffmpeg with pacman, please enter your password:"
        sleep 1
        sudo pacman -S yt-dlp ffmpeg
        echo ""
        echo ""
        echo "Dependencies properly installed"
}

redhat_installation(){
        echo "installing yt-dlp and ffmpeg with dnf, please enter your password:"
        sleep 1
        sudo dnf install yt-dlp ffmpeg
        echo ""
        echo ""
        echo "Dependencies properly installed"
        sleep 1

}

debian_installation(){
        echo "installing yt-dlp and ffmpeg with apt, please enter your password:"
        sleep 1
        sudo apt install yt-dlp ffmpeg
        echo ""
        echo ""
        echo "Dependencies properly installed"
        sleep 1
}


distro_installation (){
       if [[ $OS == "Arch" ]];then
             arch_installation
        elif [[ $OS == "Redhat" ]]; then
                redhat_installation
        elif [[ $OS == "Debian" ]]; then
                debian_installation

	fi
 
}

installation(){
        if [[ $language == "fr" ]];then
                fichier="soundcloud_fr.sh"
        elif [[ $language == "en" ]];then
                fichier="soundcloud.sh"
        fi
        echo ""
        echo ""
        echo "getting the last version of SoundCloud Downloader from github..."
        sleep 1
        git clone https://github.com/AR4eL974/Soundcloud-Downloader.git
        echo ""
        echo "repo successfully cloned"
        sleep 1
        echo ""
        echo "extracting the executable from the repo directory and deleting the directory"
        cp Soundcloud-Downloader/$fichier $fichier
        rm -rf Soundcloud-Downloader
        sleep 1
        echo ""
        echo ""
        echo "giving execution permissions to the executable"
        chmod +x $fichier
        sleep 1
        echo ""
        echo "installation complete, the installer will now remove itself"
        sleep 1
        rm install.sh
}

language_choice
os_detect
echo ""
echo "OS Detected: $OS based Linux, proceeding to installation for this OS"
sleep 1
distro_installation
installation






