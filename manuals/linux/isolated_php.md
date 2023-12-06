# Isolated PHP Sites

> Work only with systemd

## Table of Contents

- [Isolated PHP Sites](#isolated-php-sites)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Prerequisites](#prerequisites)
    - [Install PHP](#install-php)
  - [Setup](#setup)
    - [Remove Default PHP Site](#remove-default-php-site)
    - [Create Users](#create-users)
    - [Setup Directories](#setup-directories)
    - [Setup Pools](#setup-pools)
    - [Nginx](#nginx)
      - [Nginx Config](#nginx-config)
      - [Nginx Enable](#nginx-enable)
    - [Restart Services](#restart-services)

## Overview

The "Isolated PHP Sites" guide is a step-by-step resource aimed at web developers and system administrators who wish to create isolated PHP sites on an Nginx server, utilizing the systemd init system for process management. This guide provides detailed instructions and configurations to set up multiple isolated PHP environments, ensuring enhanced security, resource isolation, and optimal performance.

## Prerequisites

### Install PHP

> Used php version: 7.4

Detailed PHP installation guides: [[php7]], [[composer]];

```bash
sudo add-apt-repository ppa:ondrej/php
```

Install php 7.4+ nginx 1.14+

```bash
sudo apt install php7.4 php7.4-fpm php7.4-curl php7.4-gd php7.4-mbstring php7.4-xml php7.4-zip mariadb-server nginx
```

## Setup

### Remove Default PHP Site

```bash
sudo rm /etc/nginx/sites-enabled/default
```

### Create Users

```bash
sudo useradd site1
sudo useradd site2
usermod -a -G site1 www-data
usermod -a -G site2 www-data
```

### Setup Directories

```bash
sudo mkdir /var/www/site1
sudo chown -R site1:site1 /var/www/site1
sudo chmod 770 /var/www/site1
sudo mkdir /var/www/site2
sudo chown -R site2:site2 /var/www/site2
sudo chmod 770 /var/www/site2
```

### Setup Pools

> If your default pool work correctly, than use in for default root. Optional, rename to site1.conf
>
> Otherwise, use default pool config, provided below.

**File:** `/etc/php/7.4/fpm/pool.d/site1.conf`

```bash
[site1]
user = site1
group = site1
listen = /run/php/php7.4-fpm-site1.sock
listen.owner = site1
listen.group = site1
listen.mode = 0660
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
chdir = /
```

**File:** `/etc/php/7.4/fpm/pool.d/site2.conf`

```bash
[site2]
user = site2
group = site2
listen = /run/php/php7.4-fpm-site2.sock
listen.owner = site2
listen.group = site2
listen.mode = 0660
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
chdir = /var/www/site2
php_admin_value[open_basedir] = /var/www/site2
php_admin_value[disable_functions] = dl,exec,passthru,shell_exec,system,proc_open,popen,curl_exec,curl_multi_exec,parse_ini_file,show_source
```

### Nginx

#### Nginx Config

> Make sure ports are different or different sub-domains

**File:** `/etc/nginx/sites-available/site1`

```nginx
server {
    listen 3001;
    server_name _;
    root /var/www/site1;

    index index.php;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_pass unix:/run/php/php7.4-fpm-site1.sock;
    }
}
```

**File:** `/etc/nginx/sites-available/site2`

```nginx
server {
    listen 3002;
    server_name _;
    root /var/www/site2;

    index index.php;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_pass unix:/run/php/php7.4-fpm-site2.sock;
    }
}
```

#### Nginx Enable

```bash
sudo ln -s /etc/nginx/sites-available/site1 /etc/nginx/sites-enabled/site1
sudo ln -s /etc/nginx/sites-available/site2 /etc/nginx/sites-enabled/site2
```

### Restart Services

```bash
sudo systemctl restart nginx
sudo systemctl restart php7.4-fpm.service
```

Tags: #php, #systemd, #nginx, #linux
