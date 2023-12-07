# PHP Installation Guide

> This guide is written for ubuntu 20.04

## Table of Contents

- [PHP Installation Guide](#php-installation-guide)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Installation](#installation)

## Overview

PHP 7 is a major release of the PHP programming language, offering significant improvements in performance, new features, and enhanced syntax. This guide note provides a step-by-step PHP 7 **Ubuntu** installation.

## Installation

First by all need add repository:

```Bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
```

Install PHP and useful libs (in example 7.4 version):

```Bash
sudo apt install php7.4
sudo apt-get install -y php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath
```

Optional you can install [[composer]].

Tags: #install, #linux, #ubuntu2004, #php
