@echo off
mklink /D %USERPROFILE%\Docker C:\Temp\Docker 
mklink /D %USERPROFILE%\Tools %USERPROFILE%\Docker\Tools

mklink %USERPROFILE%\.bash_profile %USERPROFILE%\Docker\repo\git\private-notebook\Linux\.bash_aliases
mklink %USERPROFILE%\.bashrc %USERPROFILE%\Docker\repo\git\private-notebook\Linux\.bash_aliases
mklink %USERPROFILE%\.vimrc %USERPROFILE%\Docker\repo\git\private-notebook\Linux\scripts\vim\_vimrc
mklink /D %USERPROFILE%\.vim %USERPROFILE%\Docker\Tools\Vim\vimfiles
mklink %USERPROFILE%\.gitconfig %USERPROFILE%\Docker\repo\git\private-notebook\Linux\.gitconfig
mklink /D %USERPROFILE%\.ssh %USERPROFILE%\Docker\repo\git\private-notebook\Linux\.ssh

echo . ~/.bashrc
