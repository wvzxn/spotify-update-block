# spotify-update-block

Simple script that will help you block Spotify updates.  
It acts as both installer and uninstaller.

## Usage

- Download and run [spotify-update-block.cmd](https://github.com/wvzxn/spotify-update-block/releases/latest/download/spotify-update-block.cmd)

### OR

- Open Powershell `Win` + `R`
- Paste the command:
```
[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12;$l="https://github.com/wvzxn/spotify-update-block/releases/latest/download/spotify-update-block.cmd";$d="$env:tmp\sub.cmd";iwr "$l" -outFile "$d";start "$d" -verb runAs -wait;ri "$d" -force
```

## Manual uninstallation

- Press `Win` + `R`
- Type `%localappdata%\Spotify`
- `Update` --> `Properties` --> `Security` --> `Advanced`
- Remove users with `Deny` permission type
- Press `Apply` and `OK`

<img src="https://user-images.githubusercontent.com/87862400/185769102-54d800a6-0ca9-483e-a424-4c75561b8442.jpg" width="720">
