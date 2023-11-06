# NvChad User Configuration Example

A user configuration template for [NvChad](https://github.com/NvChad/NvChad)


## Prereqs

* dotnet
* csharp-ls

* choco install ripgrep
* choco install fzf

``` 
dotnet tool install --global csharp-ls
``` 

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak




```

#### Clone NvChad

```shell
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
git clone https://github.com/NvChad/NvChad $HOME\AppData\Local\nvim --depth 1
```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.


```shell
rm $HOME\AppData\Local\nvim\lua\custom
rm -r ~/.config/nvim/lua/custom
```

#### Clone the repository

```shell
git clone https://github.com/Johanw123/jape_nvchad_config ~/.config/nvim/lua/custom
git clone https://github.com/Johanw123/jape_nvchad_config $HOME\AppData\Local\nvim\lua\custom
```

#### Start Neovim

```shell
nvim
```



### Updating
Choco upgrade neovim
NvChadUpdate
MasonUpdate
TSUpdate
