# Composer Installation Guide

## Table of Contents

- [Composer Installation Guide](#composer-installation-guide)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Installation](#installation)
    - [Install Locally](#install-locally)
    - [Install Globally](#install-globally)

## Overview

[Composer](https://getcomposer.org/) is a tool for dependency management in PHP.

Before you might want install [[php7]] or any another version.

## Installation

### Install Locally

```Bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
```

### Install Globally

> First, perform a local installation and then transfer the files to the designated installation directory. Once completed, execute the following command:

```Bash
sudo mv composer.phar /usr/local/bin/composer
```

Tags: #install, #linux, #ubuntu2004, #php
