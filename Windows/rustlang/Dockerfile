# escape=`

# Use the specific Windows Server Core image with .NET Framework 4.8.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-20200714-windowsservercore-ltsc2019

RUN setx /M __VSCMD_ARG_NO_LOGO "1"

# Install Rustup and Rust toolchains for x86 and x64
ADD https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe rustup-init.exe
RUN Start-Process rustup-init.exe -ArgumentList '-y -v --default-toolchain stable --default-host x86_64-pc-windows-msvc' -Wait; `
Remove-Item rustup-init.exe

RUN Start-Process rustup -ArgumentList 'toolchain install stable-i686-pc-windows-msvc' -Wait; `
    Start-Process rustup -ArgumentList '+stable-x86_64-pc-windows-msvc -V' -Wait; `
    Start-Process cargo -ArgumentList '+stable-x86_64-pc-windows-msvc -V' -Wait; `
    Start-Process rustc -ArgumentList '+stable-x86_64-pc-windows-msvc -V' -Wait; `
    Start-Process rustup -ArgumentList '+stable-i686-pc-windows-msvc -V' -Wait; `
    Start-Process cargo -ArgumentList '+stable-i686-pc-windows-msvc -V' -Wait; `
    Start-Process rustc -ArgumentList '+stable-i686-pc-windows-msvc -V' -Wait
