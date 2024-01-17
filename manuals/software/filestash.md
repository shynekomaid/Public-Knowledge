# Filestash Usage Guide

[Official site](https://www.filestash.app), [Github](https://github.com/mickael-kerjean/filestash)

> Filestash is a self-hosted client for managing your data remotely.

## Table of Contents

- [Filestash Usage Guide](#filestash-usage-guide)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Prerequisites](#prerequisites)
    - [Installing Requirements](#installing-requirements)
      - [Installing Docker](#installing-docker)
      - [Installing Docker Compose](#installing-docker-compose)
  - [Installing Filestash](#installing-filestash)
  - [Upgrade Filestash](#upgrade-filestash)
  - [Post-Install Steps](#post-install-steps)
    - [Configuration](#configuration)
    - [Nginx Forward](#nginx-forward)
      - [Nginx Forward Prerequisites](#nginx-forward-prerequisites)
      - [Nginx Forward Steps](#nginx-forward-steps)
        - [Step 1: Install Nginx](#step-1-install-nginx)
        - [Step 2: Configure Nginx for Filestash](#step-2-configure-nginx-for-filestash)
        - [Step 3: Enable Nginx Configuration](#step-3-enable-nginx-configuration)
        - [Step 4: Install Let's Encrypt Certbot](#step-4-install-lets-encrypt-certbot)
        - [Step 5: Obtain SSL Certificate](#step-5-obtain-ssl-certificate)
        - [Step 6: Automatic Certificate Renewal](#step-6-automatic-certificate-renewal)

## Description

Filestash is designed to manage remote storages by creating user accounts rather than displaying local files.

## Prerequisites

Before installing **Filestash**, ensure **docker**, **docker-compose**, and **curl** are installed.

### Installing Requirements

>*"Lasciate ogne speranza, voi ch’entrate."*
>
>— Dante Alighieri, Divine Comedy

#### Installing Docker

> Author's note: While Docker is a commonly used tool, it's important to be mindful of potential challenges that may arise. Some users have experienced issues, and it's recommended to consider alternative solutions based on your specific requirements and environment. Always conduct thorough research and testing before implementing any technology in your setup.

To install Docker on Ubuntu:

1. Update the apt package index:

   ```bash
   sudo apt update
   ```

2. Install required packages:

   ```bash
   sudo apt install apt-transport-https ca-certificates curl software-properties-common
   ```

3. Add Docker's official GPG key:

   ```bash
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
   ```

4. Set up the stable Docker repository:

   ```bash
   echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```

   Note: If an error occurs during the next step, use this command instead:

   ```bash
   echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```

    If an error persists, consider manually replacing 'focal' with your system codename or the previous LTS codename.

    This is especially relevant for non-LTS Ubuntu releases or when using a non-Ubuntu-flavor system, such as Ubuntu-based Linux Mint.

5. Install Docker:

   ```bash
   sudo apt update
   sudo apt install docker-ce docker-ce-cli containerd.io
   ```

#### Installing Docker Compose

To install Docker Compose:

1. Download the latest stable release:

   ```bash
   sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   ```

2. Apply executable permissions:

   ```bash
   sudo chmod +x /usr/local/bin/docker-compose
   ```

3. Verify the installation:

   ```bash
   docker-compose --version
   ```

Now Docker and Docker Compose are installed.

## Installing Filestash

```bash
mkdir filestash && cd filestash
curl -O https://downloads.filestash.app/latest/docker-compose.yml
sudo docker-compose up -d
```

> Note: Commands may take time and download around 2GB of data from slow server.

## Upgrade Filestash

```bash
cd filestash
curl -O https://downloads.filestash.app/latest/docker-compose.yml
sudo docker-compose pull
sudo docker-compose up -d
```

## Post-Install Steps

### Configuration

After installation, visit [http://your_domain:8334](http://your_domain:8334) or [http://0.0.0.0:8334/admin/setup](http://0.0.0.0:8334/admin/setup) to set up your admin password.

Refer to the [official notes](https://www.filestash.app/docs/install-and-upgrade/#setup) for post-installation guidance.

### Nginx Forward

#### Nginx Forward Prerequisites

- Nginx installed
- Domain name pointing to your server's IP
- Certbot installed (for Let's Encrypt)

#### Nginx Forward Steps

##### Step 1: Install Nginx

```bash
sudo apt update
sudo apt install nginx
```

##### Step 2: Configure Nginx for Filestash

Create a new Nginx server block configuration:

```bash
sudo nano /etc/nginx/sites-available/filestash
```

Add the following, replacing `sub.domain.com` with your subdomain:

```nginx
server {
    listen 80;
    server_name sub.domain.com;

    location / {
        proxy_pass http://localhost:8334;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location ~ /.well-known/acme-challenge {
        allow all;
        root /var/www/html;
    }

    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }
}
```

##### Step 3: Enable Nginx Configuration

```bash
sudo ln -s /etc/nginx/sites-available/filestash /etc/nginx/sites-enabled
sudo nginx -t
sudo systemctl restart nginx
```

##### Step 4: Install Let's Encrypt Certbot

```bash
sudo apt install certbot python3-certbot-nginx
```

##### Step 5: Obtain SSL Certificate

```bash
sudo certbot --nginx -d sub.domain.com
```

##### Step 6: Automatic Certificate Renewal

Certbot will set up a cron job for certificate renewal. Test it:

```bash
sudo certbot renew --dry-run
```

Now, access your Filestash instance at `https://sub.domain.com`.

Adjust configurations based on your setup.
