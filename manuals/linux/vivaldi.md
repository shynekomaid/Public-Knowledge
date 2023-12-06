# Vivaldi Linux Install Guide

> This guide is written for ubuntu 20.04

## Table of Content

- [Vivaldi Linux Install Guide](#vivaldi-linux-install-guide)
  - [Table of Content](#table-of-content)
  - [Overview](#overview)
    - [Description](#description)
  - [Installation](#installation)

## Overview

Vivaldi Browser is a feature-rich, user-friendly web browser developed by Vivaldi Technologies. It was first released in 2016 and has since gained popularity for its customization options and power-user features. The browser is designed to cater to users who seek a highly configurable and personalized browsing experience.

### Description

Key features of Vivaldi Browser include:

**Customization:** Vivaldi offers extensive customization options, allowing users to modify the browser's appearance, layout, and functionality to suit their preferences.

**Tab Management:** Vivaldi excels in tab management, enabling users to stack, tile, and group tabs for improved organization and productivity.

**User Interface:** The browser has a sleek and modern interface with a sidebar that houses various tools, such as bookmarks, downloads, and notes, for easy access.

**Built-in Tools:** Vivaldi includes several built-in tools, like a screenshot tool, note-taking feature, and a powerful bookmark manager, enhancing the overall browsing experience.

**Speed Dial:** Vivaldi's Speed Dial feature allows users to create custom start pages with bookmarks and shortcuts to frequently visited websites.

**Mouse Gestures:** The browser supports mouse gestures, enabling users to execute commands with simple mouse movements, making navigation more intuitive.

**Privacy & Security:** Vivaldi prioritizes user privacy and offers various security features, such as tracking protection and a built-in ad blocker.

**Cross-Platform Support:** Vivaldi is available for Windows, macOS, Linux, and Android devices, allowing users to sync their settings and data across multiple platforms.

In summary, Vivaldi Browser stands out as a versatile and highly customizable web browser, appealing to users who want a powerful, personalized, and privacy-conscious browsing experience.

## Installation

> For Ubuntu, Debian, Mint, etc...

Import public key:

```Bash
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor | sudo dd of=/usr/share/keyrings/vivaldi-browser.gpg
```

Add the repository:

```Bash
echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" | sudo dd of=/etc/apt/sources.list.d/vivaldi-archive.list
```

Install:

```Bash
sudo apt update && sudo apt install vivaldi-stable
```

Tags: #install, #linux, #vivaldi-browser, #ubuntu2004
