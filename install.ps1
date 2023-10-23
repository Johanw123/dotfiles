# clone my Dotfiles repo
$dotFilesRoot = Join-Path $HOME "dotfiles2"

if (!(Test-Path $dotFilesRoot -PathType Container)) {
    git clone git@github.com:Johanw123/dotfiles.git $dotFilesRoot
    #echo "awdawd"
}