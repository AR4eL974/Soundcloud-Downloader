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
        sleep 1
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
        cp Soundcloud-Downloader/soundcloud.sh soundcloud.sh
        rm -rf Soundcloud-Downloader
        sleep 1
        echo ""
        echo ""
        echo "giving execution permissions to the executable"
        chmod +x soundcloud.sh
        sleep 1
        echo ""
        echo "installation complete, you may want to delete this installer by running 'rm install.sh' or deleting it via your file explorer"
        sleep 1
}
os_detect

echo ""
echo "OS Detected: $OS based Linux, proceeding to installation for this OS"
sleep 1

if [[ $OS == "Arch" ]];then
        arch_installation
fi




