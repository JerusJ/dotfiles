$ErrorActionPreference = "Stop"

function Install-Chocolatey {
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

function Install-Chocolatey-Apps {
    choco install -y `
        7zip `
        discord `
        dotnetfx `
        doublecmd `
        dropbox `
        f.lux `
        git `
        git-lfs `
        googlechrome `
        hyper `
        listary `
        neovim `
        nodepadplusplus `
        paint.net `
        python `
        qbittorrent `
        steam `
        vlc
}

function Install-Byond {
    $InstallerUrl = "http://www.byond.com/download/build/513/513.1532_byond.zip"
    $InstallerPath = "$env:TEMP\byond.zip"
    $DestinationPath = "$env:HOMEPATH\byond"

    Write-Host "--> Downloading Byond to: $InstallerPath..."
    (New-Object Net.WebClient).DownloadFile($InstallerUrl, $InstallerPath)

    If (-NOT (Test-Path "$DestinationPath/byond")) {
        Write-Host "--> Extracting Byond to: $DestinationPath..."
        Expand-Archive -Path $InstallerPath -Destinationpath $DestinationPath

        Write-Host "--> Installing DotNet 3.5..."
        dism /online /enable-feature /featurename:NetFX3 /all /Source:d:sourcessxs

        Write-Host "--> Installing DirectX..."
        Start-Process "$DestinationPath/byond/directx/DXSETUP.exe" -ArgumentList "/silent" -Wait
    }

    Write-Host "--> Setting Desktop Shortcuts..."
    New-Item -ItemType SymbolicLink -Force -Path "$env:HOMEPATH\Desktop" -Name "byond.lnk" -Value "$DestinationPath\byond\bin\byond.exe"
}

# Taken from: https://gist.github.com/joshschmelzle/5e88dabc71014d7427ff01bca3fed33d
function Set-Keybindings {
    $hexified = "00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00".Split(',') | % { "0x$_" };
    $kbLayout = 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout';
    New-ItemProperty -Path $kbLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$hexified);
}

function Set-UAC {
    Set-ItemProperty `
        -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System `
        -Name ConsentPromptBehaviorAdmin `
        -Value 0
}

Install-Chocolatey
Install-Chocolatey-Apps
Install-Byond
Install-Fonts
Set-Keybindings
Set-UAC
