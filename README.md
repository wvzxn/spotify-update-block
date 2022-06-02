# spotify-update-block
This script simply changes `~\AppData\Local\Spotify\Update` folder permissions
___
### Usage
Run [SpotifyUpdateBlock.bat](https://github.com/wvzxn/spotify-update-block/releases/download/initial/SpotifyUpdateBlock.bat) to install (or uninstall)
___
### Manual uninstallation
1) Press [Win] + [R]
2) Input `%localappdata%\Spotify`
3) Update Folder --> Properties --> Security --> Advanced
4) Remove users with `Deny` permission type
5) Press `Apply` and `OK`
6) Delete `.update_block` file in `~\AppData\Local\Spotify\`
___
![This is an image](/img.jpg)
