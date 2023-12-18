# Isolated PHP Setup Guide

> This guide is designed to walk you through the process of setting up isolated PHP environments on a system utilizing systemd. Isolating PHP environments is particularly useful when you need to run multiple PHP applications independently, each with its own user, configuration, and directory structure.

## Table of Contents

- [Isolated PHP Setup Guide](#isolated-php-setup-guide)
  - [Table of Contents](#table-of-contents)
  - [Why Isolation Matters](#why-isolation-matters)
  - [Preparation](#preparation)
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
  - [Security Considerations](#security-considerations)
    - [Configure Firewall Rules](#configure-firewall-rules)
    - [Keep Software Updated](#keep-software-updated)
    - [Implement HTTPS](#implement-https)
    - [Secure PHP Configuration](#secure-php-configuration)
    - [Regular Backups](#regular-backups)
    - [Monitor Logs](#monitor-logs)

## Why Isolation Matters

Isolating PHP environments offers several advantages, including enhanced security, resource management, and ease of maintenance. By following this guide, you can ensure that each PHP application operates independently, minimizing interference and potential conflicts between different projects.

Whether you are a developer working on multiple projects or an administrator managing various PHP applications on a server, isolating PHP environments can streamline your workflow and contribute to a more organized and secure system.

Now, let's dive into the step-by-step process of preparing, setting up, and securing isolated PHP environments on your system.

## Preparation

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

## Security Considerations

### Configure Firewall Rules

To enhance security, consider configuring firewall rules to restrict access to your server. Utilize tools like UFW (Uncomplicated Firewall) to define rules that only allow necessary traffic.

```bash
sudo ufw allow ssh
sudo ufw allow 3001  # Adjust port numbers accordingly
sudo ufw allow 3002
sudo ufw enable
```

### Keep Software Updated

Regularly update your server's software, including PHP, Nginx, and other dependencies. This helps patch security vulnerabilities and ensures a more secure environment.

```bash
sudo apt update
sudo apt upgrade
```

### Implement HTTPS

Consider using a valid SSL certificate to enable HTTPS on your Nginx server. This encrypts data in transit, enhancing the security of communications between clients and your server.

### Secure PHP Configuration

Review and adjust PHP configuration settings to enhance security. Disable functions that might pose security risks and set appropriate values for parameters like `open_basedir`.

### Regular Backups

Implement a robust backup strategy to prevent data loss in case of unforeseen events. Regularly back up your website files, databases, and server configurations.

```bash
# Example: Create a daily backup using cron
0 3 * * * tar -czf /path/to/backup_$(date +\%Y\%m\%d).tar.gz /var/www/site1 /var/www/site2
```

### Monitor Logs

Regularly check logs for suspicious activities. Nginx and PHP-FPM logs can provide valuable information about potential security incidents.

```bash
# Example: View Nginx access logs
tail -f /var/log/nginx/access.log
```

Feel free to customize this section according to your specific security needs or let me know if you have any particular requirements!

Tags: #linux, #ubuntu2004, #php
