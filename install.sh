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
        echo ""
        echo ""
        echo "getting the last version of SoundCloud Downloader from github..."
        git clone https://github.com/AR4eL974/Soundcloud-Downloader.git
        echo ""
        echo "repo successfully cloned"
        echo ""
        echo "extracting the executable from the repo directory and deleting the directory"
        cp Soundcloud-Downloader/soundcloud.sh soundcloud.sh
        rm -r Soundcloud-Downloader
        echo ""
        echo ""
        echo "giving execution permissions to the executable"
        chmod +x soundcloud.sh
        echo ""
        echo "installation complete, you may want to delete this installer by running 'rm install.sh' or deleting it via your file explorer"
}
os_detect
if [[ $OS == Arch ]];then
        arch_installation
fi

echo ""
echo "OS Detected: $OS based Linux, proceeding to installation for this OS"
sleep 1


