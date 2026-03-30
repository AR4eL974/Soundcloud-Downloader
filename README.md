Soundcloud Downloader is a lightweight tool built around yt-dlp to download SoundCloud playlists and keep track of them.


* [INSTALLATION](#installation)

    * [Automated install script](#automated-install-script)
    * [Manual installation](#manual-installation)
        * [Dependencies](#dependencies)
* [USAGE AND OPTIONS](#usage-and-options)

* [NO AI IN THIS CODE](#no-ai-in-this-code)



# INSTALLATION
For now there are two ways you can install SoundCloud-Downloader, using a [script](#automated-install-script), or manually installing the [dependencies](#dependencies) and downloading [SoundCloud Downloader](https://github.com/AR4eL974/Soundcloud-Downloader/blob/main/soundcloud.sh) yourself 


<!-- MANPAGE: BEGIN EXCLUDED SECTION -->
# AUTOMATED INSTALL SCRIPT

#### Recommended if you just want to install SoundCloud Downloader and use it without checking how it works

(Note: This method requires having curl installed)
```
cd
curl -o install.sh https://raw.githubusercontent.com/AR4eL974/Soundcloud-Downloader/refs/heads/main/install.sh
chmod +x install.sh
./install.sh
```

# MANUAL INSTALLATION


## DEPENDENCIES
To run SoundCloud Downloader, you will need some essentials:

## [yt-dlp](https://github.com/yt-dlp/yt-dlp)

* This is the package that lets you download a lot of media from the internet, go check them out.

    You can install yt-dlp by visiting their [git page](https://github.com/yt-dlp/yt-dlp) or simply:


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

    You can install ffmpeg by visiting their [website](https://github.com/yt-dlp/yt-dlp) or simply:


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



<!-- Auto generated -->
## General Options:
    -h                Displays this help menu      

    -d <Directory>    Changes the download path to <Directory> then runs the app
    

# NO AI IN THIS CODE
This code has been made without the use of any generative AI because the author is deeply concerned by the effect AI has on our society and our planet, any modifications by contributors who use generative AI will NOT be accepted.