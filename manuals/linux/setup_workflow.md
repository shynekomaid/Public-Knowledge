# Setup Linux Workflow

## Table of Contents

- [Setup Linux Workflow](#setup-linux-workflow)
  - [Table of Contents](#table-of-contents)
  - [Related Article](#related-article)
  - [Software](#software)
    - [Zsh the Unix Shell](#zsh-the-unix-shell)
      - [Install Zsh in Ubuntu](#install-zsh-in-ubuntu)
      - [Update Zsh](#update-zsh)
    - [KiTTY the Terminal Emulator](#kitty-the-terminal-emulator)
      - [Install Latest KiTTY Version](#install-latest-kitty-version)
      - [KiTTY Desktop Integration on Linux](#kitty-desktop-integration-on-linux)
      - [KiTTY Config](#kitty-config)
    - [Ranger the File Manager](#ranger-the-file-manager)
  - [Utilities](#utilities)
    - [Python](#python)
      - [Install Python On Ubuntu](#install-python-on-ubuntu)
      - [Install pip \& pipx](#install-pip--pipx)
    - [Bun the Node.js Replacement](#bun-the-nodejs-replacement)
    - [tldr pages](#tldr-pages)

## Related Article

Also read how to: [[create_user|create user]], [[change_password|change user password]], or [[add_user_to_sudo|add to sudo]].

## Software

<!-- nmap, htop, ncmpcpp -->

### Zsh the Unix Shell

[Arch wiki](https://wiki.archlinux.org/title/zsh), [Oh My Zsh Github](https://github.com/ohmyzsh/ohmyzsh)

#### Install Zsh in Ubuntu

1. Install using apt:
    > For another installation methods, please, read this [article](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH).

    ```bash
    sudo apt install zsh
    ```

2. Make it default shell:

    ```bash
    chsh -s $(which zsh)
    ```

3. Install Oh My Zsh

    ```bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```

#### Update Zsh

```bash
omz update
```

### KiTTY the Terminal Emulator

[Website](https://sw.kovidgoyal.net/kitty/), [GitHub](https://github.com/kovidgoyal/kitty)
> Cross-platform, fast, feature-rich, GPU based terminal.

#### Install Latest KiTTY Version

```Bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

> You also can perform this command for upgrade.

#### KiTTY Desktop Integration on Linux

```Bash
# Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in
# your system-wide PATH)
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
# If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
# Update the paths to the kitty and its icon in the kitty.desktop file(s)
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
```

#### KiTTY Config

[Github](https://github.com/ttys3/my-kitty-config)

> The kitty config for tmux users.

Install:

1. Backup old config.

    ```Bash
    mv ~/.config/kitty  ~/.config/kitty.bak
    ```

2. Clone single file.

    ```Bash
    git clone https://github.com/ttys3/my-kitty-config.git ~/.config/kitty
    ```

3. Reload KiTTY.

### Ranger the File Manager

[Github](https://github.com/ranger/ranger)

> A VIM-inspired filemanager for the console.
>
> Install [python](#install-python-on-ubuntu) and [pipx](#install-pip--pipx) before.

Install Ranger:

```bash
pip install ranger-fm
```

<!-- ### fzf the Fuzzy Finder -->

<!-- ### lsd the ls Replacement -->

<!-- ### chezmoi the Dot File Manager -->

## Utilities

### Python

[Website](https://www.python.org)

#### Install Python On Ubuntu

[Python](https://www.python.org), [pip Github](https://github.com/pypa/pip?tab=coc-ov-file), [pipx Github](https://github.com/pypa/pipx)

```bash
sudo apt update
sudo apt install python3
```

#### Install pip & pipx

```bash
sudo apt install pip
sudo apt install pipx # optional but recommended
```

### Bun the Node.js Replacement

[Website](https://bun.sh), [Github](https://github.com/oven-sh/bun)

> Develop, test, run, and bundle JavaScript & TypeScript projects—all with Bun. Bun is an all-in-one JavaScript runtime & toolkit designed for speed, complete with a bundler, test runner, and Node.js-compatible package manager.

Install:

```bash
sudo apt install nodejs # optional
curl -fsSL https://bun.sh/install | bash
```

Reload shell after:
`source ~/.zshrc` or `source ~/.bashrc` or just restart TTY or terminal emulator.

### tldr pages

[Website](https://tldr.sh), [Github](https://github.com/tldr-pages/tldr)

> Simplified and community-driven man pages.
>
> Install nodejs or [bun](#bun-the-nodejs-replacement) before.

Install (for bun):

```bash
bun install -g tldr
```

Launch:

```bash
tldr
```

Update (for bun):

```bash
bun update -g tldr
```

<!-- ## Misc -->

<!-- ### Fonts -->

<!-- Cascadia, Nerd font, Monaspace and it terminal and vscode integration -->

Tags: #install, #linux, #workflow
