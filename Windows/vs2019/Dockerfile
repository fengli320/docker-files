# escape=`

# Use the specific Windows Server Core image with .NET Framework 4.8.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-20200714-windowsservercore-ltsc2019

WORKDIR C:/TEMP

# Install packages
# Due to GitHub connection not stable from mainland
COPY OMC\OpenSSH-Win64_790.zip OpenSSH-Win64.zip
RUN `
    # Install OpenSSH Server
    #curl.exe -fSLo OpenSSH-Win64.zip https://github.com/PowerShell/Win32-OpenSSH/releases/download/v7.9.0.0p1-Beta/OpenSSH-Win64.zip; `
    #Start-Process curl.exe -ArgumentList '-fSLo','OpenSSH-Win64.zip','https://github.com/PowerShell/Win32-OpenSSH/releases/download/v7.9.0.0p1-Beta/OpenSSH-Win64.zip' -Wait; `
    Expand-Archive OpenSSH-Win64.zip -DestinationPath C:\Windows\System32; `
    Remove-Item *.*; `
    C:\Windows\System32\OpenSSH-Win64\install-sshd.ps1

# Process sshd setting files
COPY ssh\* C:\ProgramData\ssh\
RUN C:\Windows\System32\OpenSSH-Win64\FixHostFilePermissions.ps1 -Confirm:$false

# Set default SSH shell as Git Bash
# The Bash path ' C:\TEMP\Docker\Tools\PortableGit-2.14.3-64-bit ' can be changed as needed
RUN New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\TEMP\Docker\Tools\PortableGit-2.28.0-64-bit\bin\bash.exe" -PropertyType String -Force

COPY ssh\administrators_authorized_keys C:\Users\ContainerAdministrator\.ssh\authorized_keys
COPY ssh\sshd_config_not_admin C:\ProgramData\ssh\sshd_config

# The following are OMC build dependencies
ARG LOC_DIR=./OMC
ARG INST_DIR=C:/TEMP/OMC
ENV INS_DIR C:\TEMP\OMC
WORKDIR C:/TEMP

# Get packages
COPY $LOC_DIR/MinGit-2.28.0-busybox-64-bit.zip MinGit.zip
COPY $LOC_DIR/nsis-3.05-setup.exe nsis.exe

# Install packages
RUN Expand-Archive MinGit.zip -DestinationPath $Env:INS_DIR\MinGit; `
Start-Process nsis.exe -ArgumentList '/S' -Wait; `
Remove-Item *.*; `
# Set PATH in one layer to keep image size down.
setx /M PATH $(${Env:PATH} `
    #+ \";${Env:ProgramFiles}\NuGet\" `
    #+ \";${Env:ProgramFiles(x86)}\Microsoft SDKs\ClickOnce\SignTool\")
    + \";${Env:INS_DIR}\MinGit\cmd\")

# Install NSIS Plugins
COPY ["$LOC_DIR/Nsis", "C:/Program Files (x86)/NSIS"]

# The following are for Tester build specifically
COPY ["$LOC_DIR/VS2019", "C:/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/MSBuild/Microsoft/VisualStudio/v16.0"]

# Install VSTO
COPY $LOC_DIR/Tester/vstor_redist.exe vstor_redist.exe
RUN Start-Process vstor_redist.exe -ArgumentList '/q' -Wait; Remove-Item *.*
COPY ["$LOC_DIR/Tester/VSTO", "$INST_DIR/VSTO"]
WORKDIR $INST_DIR/VSTO
RUN Start-Process gacutil.exe -ArgumentList '/il','list.txt' -Wait

# The following are for Web build specifically
# Install Nodejs
WORKDIR C:/TEMP
COPY $LOC_DIR/Web/node-v12.14.1-x64.msi node.msi
RUN Start-Process msiexec.exe -ArgumentList '/i node.msi /qn' -Wait; `
Remove-Item *.*; `
setx /M PATH $(${Env:PATH} `
    + \";${Env:ProgramFiles}\nodejs\"); `
setx /M NODE_OPTIONS --max-old-space-size=2048

# Define the entry point for the docker container.
ENTRYPOINT ["C:/ProgramData/ssh/mklink.bat", "&&", "powershell.exe", "-NoExit", "Start-Job", "{ C:/Windows/System32/OpenSSH-Win64/sshd.exe }"]
