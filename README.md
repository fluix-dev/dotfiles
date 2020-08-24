<p align=center>
    <img alt="Screenshot of various applications" src="https://raw.githubusercontent.com/TheAvidDev/dotfiles/master/img/banner.png">
    <h3 align=center>Configurations and colorschemes for Sway, et al.</h3>
</p>
<p align=center>
    <a href="#programs">Programs</a> | <a href="#installation">Installation</a> | <a href="#screenshots">Screenshots</a>
</p>

# Programs
This repository contains configuration files for many programs that I regularly use on a day to day basis. I've also given brief descriptions of what each program does so you don't have to wonder what something is -- and because you might like something and want try it out. If you'd like me to style an application that isn't listed here, submit an issue and I'll try my best.
 - [`aerc`](https://aerc-mail.org/) is a simple terminal mail client with a variety of useful features for development.
 - [`alacritty`](https://github.com/alacritty/alacritty) is a cross-platform terminal emulator.
 - [`cava`](https://github.com/karlstav/cava) is a console-based audio visualizer for ALSA.
 - [`Lightcord`](https://github.com/Lightcord/Lightcord) is a customizable Discord client which comes with BetterDiscord.
 - [`mako`](https://github.com/emersion/mako) is a lightweight notification daemon for Wayland.
 - [`mpd`](https://www.musicpd.org/) is a flexible, powerful, server-side application for playing music.
 - [`neofetch`](https://github.com/dylanaraps/neofetch) is a very popular command line information tool.
 - [`nvim`](https://neovim.io/) is a fork of vim that has been rewritten for usability and extensibility.
 - [`sway`](https://swaywm.org) is a tiling Wayland compositor which serves as a drop-in replacement of i3. Use with [#5639](https://github.com/swaywm/sway/pull/5639).
 - [`wal`](https://github.com/dylanaraps/pywal) is a color scheme generator and manager.
 - [`waybar`](https://github.com/Alexays/Waybar) is a highly customizable Wayland bar for Sway and Wlroots based compositors.
 - [`wofi`](https://hg.sr.ht/~scoopta/wofi) a Wayland version of the popular Rofi launcher/menu.
 - [`zsh`](https://www.zsh.org/) is an interactive shell with a powerful scripting language.

# Installation
The simplest method is to clone the repo and pick and choose what you want, moving it to `~/.config`. If you want to receive updates, you can either clone the repo directly to `~/.config` or symlink the repo or internal folders to `~/.config`. There are some files that are expected to be outside of `~/.config` so symlink them as follows:
 - `.zsrc` --> `~/.zshrc`
 - `scripts/system-sleep-led-strip.sh` --> `/usr/lib/systemd/system-sleep/system-sleep-led-strip.sh`

Then, you will have to modify the [Sway](https://github.com/TheAvidDev/dotfiles/blob/master/sway/config) and [Waybar](https://github.com/TheAvidDev/dotfiles/blob/master/waybar/config) output config files to use the appropriate outputs.

Finally, run [pywal](https://github.com/dylanaraps/pywal) to change your colorscheme for terminal applications:
```sh
wal --theme nord
```

### Distro
I personally use Arch Linux, but there's nothing specific to these config files that shouldn't work on other distributions. Be aware, however, that installation procedures for the individual packages will certainly be different and that the _locations_ of config files _may_ be different. If you would like to install Arch Linux follow the directions on the [Arch Wiki](https://wiki.archlinux.org/index.php/Installation_guide). I personally used [Anarchy Installer](https://anarchyinstaller.org/) to install Arch and some important packages, but it is neither necessary, nor entirely recommended.

### Fonts
All the applications have been setup to use the [Cozette](https://github.com/slavfox/Cozette) font, so follow the instructions on its Github for installation.

### Applications
The official [Arch repos](https://www.archlinux.org/packages/) or the [Arch User Repository (AUR)](https://aur.archlinux.org/) contain all of the applications I use, sometimes under a different name than the folder.

For [Sway](https://swaywm.org), make sure to use [#5639](https://github.com/swaywm/sway/pull/5639) by applying it as a [patch](https://patch-diff.githubusercontent.com/raw/swaywm/sway/pull/5639.patch) and [compiling from source](https://github.com/swaywm/sway#compiling-from-source) for the curved borders with drop shadows. Keep in mind that the config syntax may change and that not all functions work. Refer to the inline `TODO` comments and discussion threads to watch the progress.

### Scripts
I have some scripts in `scripts/` that I use which may contain some documentation within them. You may not have a use for them, or you may have to edit them to work on your install.

# Screenshots
|![Htop, neovim, bonsai.sh, pipes.sh, cava, neofetch, waybar][banner]|![Weechat and Discord][comms]|
|---|---|
|From top-left to bottom-right: `htop`, `nvim`, `bonsai.sh`, `pipes.sh`, `cava`, `neofetch`, `waybar`|Weechat and Discord (Lightcord)|

<!-- Links -->
[banner]: https://raw.githubusercontent.com/TheAvidDev/dotfiles/master/img/banner.png
[comms]: https://raw.githubusercontent.com/TheAvidDev/dotfiles/master/img/comms.png
