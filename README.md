Soundcloud Downloader is a lightweight tool built around yt-dlp to download SoundCloud playlists and keep track of them.

If you can see this now,support for other platforms should be added soon.

* [INSTALLATION](#installation)

    * [Automated install script](#automated-install-script)
    * [Dependencies](#dependencies)
* [USAGE AND OPTIONS](#usage-and-options)



# INSTALLATION
For now there are two ways you can install SoundCloud-Downloader, using a [script](#automated-install-script), or manually installing the dependencies and downloading SoundCloud Downloader yourself 


<!-- MANPAGE: BEGIN EXCLUDED SECTION -->
## AUTOMATED INSTALL SCRIPT

#### Recommended if you just want to install SoundCloud Downloader and use it without checking how it works

(Note: This method requires having curl installed)
```
cd
curl -o install.sh https://raw.githubusercontent.com/AR4eL974/Soundcloud-Downloader/refs/heads/main/install.sh
chmod +x install.sh
./install.sh
```


## DEPENDENCIES
To run SoundCloud Downloader, you will need some essentials:

## [yt-dlp](https://github.com/yt-dlp/yt-dlp)

* This is the package that lets you download a lot of media from the internet, go check them out.

    You can install yt-dlp by visiting their git page or simply:


    ## Arch-Based distros:
    ```
    sudo pacman -S yt-dlp
    ```
    ## Redhat-Based distros (Fedora/CentOS/OpenSUSE):
    ```
    sudo dnf install yt-dlp
    ```
    ## Debian-Based distros (Ubuntu/Mint):
    ```
    sudo apt install yt-dlp
    ```


## [ffmpeg](https://ffmpeg.org/download.html)

* This is the package that handles almost any type of media and is capable of converting between them, Soundcloud Downloader uses ffmpeg to add thumbnails to your songs and such things.

    You can install ffmpeg by visiting their website or simply:


    ## Arch-Based distros:
    ```
    sudo pacman -S ffmpeg
    ```
    ## Redhat-Based distros (Fedora/CentOS/OpenSUSE):
    ```
    sudo dnf install ffmpeg
    ```
    ## Debian-Based distros (Ubuntu/Mint):
    ```
    sudo apt install ffmpeg
    ```



# USAGE AND OPTIONS

    ./soundcloud.sh [OPTIONS]

Tip: Use `CTRL`+`F` (or `Command`+`F`)  to search by keywords


<!-- Auto generated -->
## General Options:
    -h            Displays this help menu                    
    
