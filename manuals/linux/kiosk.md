# Setup Kiosk Guide

Welcome to the Setup Kiosk Guide! This step-by-step guide is designed to help you effortlessly configure your device into a kiosk system using Armbian. Whether you're setting up a public information display or a dedicated browsing station, this guide will walk you through the process, ensuring a smooth and efficient setup.

Please follow the outlined steps carefully to create a secure and streamlined kiosk environment. From downloading the necessary software to post-installation customization and handy tips, this guide covers it all. Let's dive in and transform your device into a powerful kiosk system!

## Table of Contents

- [Setup Kiosk Guide](#setup-kiosk-guide)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
    - [Download](#download)
    - [Burn Image to SD Card](#burn-image-to-sd-card)
  - [Setup Armbian](#setup-armbian)
  - [Post-Installation Steps](#post-installation-steps)
    - [Remove Unnecessary Packages](#remove-unnecessary-packages)
    - [Remove Snapd](#remove-snapd)
    - [Update Packages](#update-packages)
    - [Create Autostart for firefox-esr](#create-autostart-for-firefox-esr)
    - [Set Auto Login](#set-auto-login)
    - [Change Background Image](#change-background-image)
    - [XFCE4 actions](#xfce4-actions)
    - [Overlayroot](#overlayroot)
      - [First Launch](#first-launch)
      - [Another Launches](#another-launches)
      - [Turn Off](#turn-off)
  - [Tips \& Tricks](#tips--tricks)
    - [Open Terminal After Kiosk Started](#open-terminal-after-kiosk-started)

## Prerequisites

### Download

Download desktop armbian image from [here](https://www.armbian.com/download/)

In this example, used image for Orange Pi PC+ [direct link](https://redirect.armbian.com/orangepipcplus/Jammy_current_xfce)

### Burn Image to SD Card

Flash image to SD card using [Etcher](https://www.balena.io/etcher/)

## Setup Armbian

1. Turn off the device and insert SD card.
2. Boot the device and wait for the first boot.
3. Create root password. (default password: `pass`).
4. Select bash as default shell (1).
5. Create user (stand:pass) with default real name (Stand).
6. If prompt "Connect via wireless network" connect to your WiFi network.

    > ⚠️ **Warning**: If there are two network interfaces displayed, select the network with the **highest** interface number (wlan1).
    >
    > Steps 7-10 provided as examples.

7. Select "N" when prompt "Set user language based on your location".
8. Select EN-GB - English (United Kingdom) in locale settings (47).
9. Next select "Europe" (7) and "Ukraine" (49) and "Ukraine (most areas)" (2).
10. Confirm timezone (Europe/Kiev) (1).
11. After booted, launch terminal and run:

    ```bash
    sudo armbian-install
    ```

12. Select (2) - "Boot from eMMC - system on eMMC".
13. Erase eMMC if prompted.
14. Use ext4 filesystem (1).
15. After done, turn off the device and wait for it to power off completely.
16. After done, remove the SD card and restart the device.

## Post-Installation Steps

> ℹ️ To perform any actions, you need to log in to the device's desktop environment using the display.

### Remove Unnecessary Packages

```bash
sudo apt purge geany libreoffice* telegram* thunderbird pidgin transmission-gtk build-essential code remmina gimp gnome-builder
sudo apt autoremove
```

### Remove Snapd

> I'm not sure why, but snapd is installed by default, even though it's not necessary.
>
> However, the default removal option is broken because a dummy chromium-browser package (135kb) is marked as a dependency of snapd.

```bash
sudo rm -rf /var/cache/snapd/
sudo apt autoremove --purge snapd
sudo rm -rf ~/snap
sudo apt-mark hold snapd
```

### Update Packages

```bash
sudo apt update
sudo apt upgrade
```

> If somewhen asks about "/etc/issue", select "Y" to install the package maintainer's version.
>
> Afterwards, the used space on eMMC will be 4.3GB (with 2.4GB free, which should be sufficient for a kiosk).

### Create Autostart for firefox-esr

> I'm not sure why Chromium browser always crashes (displaying the "Oh, snap!" error message), despite having 2.4GB of free memory and 300MB+ of free RAM. As a result, I have switched to using Firefox ESR instead.

- Open "Startup Applications" (Menu -> Settings -> Startup Applications).
- Add new application with name "Kiosk" and command:

`firefox-esr --kiosk "%site%"`

> Replace `%site%` to you own.

- Make sure that trigger set to "on login"

### Set Auto Login

> Based on [Arch wiki][^1]

```bash
sudo nano /etc/lightdm/lightdm.conf
```

- Add the following lines:

```bash
[Seat:*]
autologin-user=stand
```

- Add user to auto login group (it's necessary for auto login to work).

```bash
sudo groupadd -r autologin
sudo gpasswd -a stand autologin
```

### Change Background Image

### XFCE4 actions

- Set image from previous step as desktop background:
  - Right click on desktop -> Settings -> Desktop
  - Set Image.
  - Set "Style" to "Centered"

- Turn off desktop icons:
  - Right click on desktop -> Desktop Settings -> Icons
  - Set "Icon type" to None.
  - Unpick all checkboxes in "Desktop Icons" section.

- Turn off power management:
  - Open "Power Management" (Menu -> Settings -> Power Management)
  - Go to "Display" tab and turn off switch.

- Turn off system notifications:
  - Open "Notifications" (Menu -> Settings -> Notifications)
  - Turn on "Do not disturb" switch.

- Turn on panel auto hide:
  - Right click on panel -> Panel Preferences -> Display
  - In "Autohide" section, turn on "Always" switch.

### Overlayroot

> Overlayroot is a tool that allows you to mount a writable overlay filesystem on top of a read-only root filesystem. This allows you to make changes to the root filesystem without having to remount it as read-write. This is useful for embedded devices that have a small amount of flash memory, and where the root filesystem is stored on a read-only partition.

#### First Launch

> Skip this step if you already turned on overlayroot before.

- Open terminal and run:

```bash
sudo armbian-config
```

- Open "System" (1) -> "Overlayroot" (2) -> "Enable" (1).

#### Another Launches

> 💡 Tip: you can easy scroll down in Nano editor using `Ctrl+V`.

- Open config file:

```bash
sudo nano /etc/overlayroot.conf
```

- Scroll down to the end of the file and change the following line:

> `overlayroot=""` to `overlayroot="tmpfs"`

- Save and close the file.
- Reboot the device.

```bash
sudo reboot
```

#### Turn Off

> To modify system files, you need to turn off overlayroot.

- Go to _real_ root:

```bash
sudo overlayroot-chroot
```

- Open config file:

```bash
nano /etc/overlayroot.conf
```

- Scroll down to the end of the file and change the following line:

> `overlayroot="tmpfs"` to `overlayroot=""`

- Save and close the file.

- Exit from _real_ root `ctrl+D` or type `exit`:

```bash
exit
```

- Reboot the device.

```bash
sudo reboot
```

## Tips & Tricks

### Open Terminal After Kiosk Started

- **Quick Summary:** Switch seamlessly between your kiosk and terminal using workspace shortcuts.

  - **How to:**
    - Use `Ctrl+Alt+Right` to switch to the second workspace and open the terminal.
    - Switch back to the kiosk with `Ctrl+Alt+Left`.

[^1]: <https://wiki.archlinux.org/title/LightDM_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)#:~:text=%D0%BC%D0%BE%D0%B6%D0%B5%D1%82%20%D0%B1%D1%8B%D1%82%D1%8C%20%D1%83%D0%B4%D0%B0%D0%BB%D1%91%D0%BD.-,%D0%92%D0%BA%D0%BB%D1%8E%D1%87%D0%B5%D0%BD%D0%B8%D0%B5%20%D0%B0%D0%B2%D1%82%D0%BE%D0%B2%D1%85%D0%BE%D0%B4%D0%B0,-%D0%9E%D1%82%D1%80%D0%B5%D0%B4%D0%B0%D0%BA%D1%82%D0%B8%D1%80%D1%83%D0%B9%D1%82%D0%B5%20%D1%84%D0%B0%D0%B9%D0%BB%20%D0%BD%D0%B0%D1%81%D1%82%D1%80%D0%BE%D0%B5%D0%BA>

Tags: #install, #linux, #ubuntu2004
