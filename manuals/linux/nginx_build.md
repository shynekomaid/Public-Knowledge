# Installation Steps for NGINX on Ubuntu 24

> A comprehensive guide with step-by-step instructions. Huge thanks to [fizikdn](https://github.com/fizikdn).

## Prerequisites

> Recommend use Ubuntu 22 (but it work on 20 or 18) for using this guide.

Ensure your Ubuntu system is up-to-date:

```bash
sudo apt update
sudo apt upgrade
```

Install essential build tools and dependencies:

```bash
sudo apt install -y bash-completion build-essential libpcre++-dev libssl-dev wget gnupg2 ca-certificates lsb-release ubuntu-keyring software-properties-common perl git libperl-dev libgd3 libgd-dev libgeoip1 libgeoip-dev geoip-bin libxml2 libxml2-dev libxslt1.1 libxslt1-dev
```

## Downloading Sources

> Recommend use tools and nginx version as it described below, but you are free to experiment!

0. Create temporary build directory:

    ```bash
    cd ~
    mkdir nginx_build
    cd nginx_build
    ```

1. Download Nginx:

    ```bash
    wget https://nginx.org/download/nginx-1.24.0.tar.gz
    ```

2. Download zlib:

    ```bash
    wget https://www.zlib.net/zlib-1.3.tar.gz
    ```

3. Download pcre2:

    ```bash
    wget https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.40/pcre2-10.40.tar.gz
    ```

4. Download OpenSSL:

    ```bash
    wget https://www.openssl.org/source/openssl-3.1.2.tar.gz
    ```

5. Download NGINX RTMP Module:

    ```bash
    git clone https://github.com/arut/nginx-rtmp-module.git
    ```

### Building and Installing NGINX

1. Extract downloaded archives:

    ```bash
    tar zxvf nginx-1.24.0.tar.gz
    tar xzvf zlib-1.3.tar.gz
    tar xzvf pcre2-10.40.tar.gz
    tar xzvf openssl-3.1.2.tar.gz
    ```

2. Create a dedicated user and group for NGINX:

    ```bash
    sudo adduser --system --home /nonexistent --shell /bin/false --no-create-home --disabled-login --disabled-password --gecos "nginx user" --group nginx
    ```

3. Verify user and group creation:

    ```bash
    sudo tail -n 1 /etc/passwd /etc/group /etc/shadow
    ```

4. Navigate to the NGINX source directory:

    ```bash
    cd nginx-1.24.0
    ```

5. Configure NGINX with the specified parameters:

    > Note: if you not want using RTMP, comment `--add-module=../nginx-rtmp-module \` in next bash snippet.

    ```bash
    ./configure --prefix=/etc/nginx \
            --sbin-path=/usr/sbin/nginx \
            --modules-path=/usr/lib/nginx/modules \
            --conf-path=/etc/nginx/nginx.conf \
            --error-log-path=/var/log/nginx/error.log \
            --pid-path=/var/run/nginx.pid \
            --lock-path=/var/run/nginx.lock \
            --add-module=../nginx-rtmp-module \
            --user=nginx \
            --group=nginx \
            --build=Ubuntu \
            --builddir=nginx-1.24.0 \
            --with-select_module \
            --with-poll_module \
            --with-threads \
            --with-file-aio \
            --with-http_ssl_module \
            --with-http_v2_module \
            --with-http_realip_module \
            --with-http_addition_module \
            --with-http_xslt_module=dynamic \
            --with-http_image_filter_module=dynamic \
            --with-http_geoip_module=dynamic \
            --with-http_sub_module \
            --with-http_dav_module \
            --with-http_flv_module \
            --with-http_mp4_module \
            --with-http_gunzip_module \
            --with-http_gzip_static_module \
            --with-http_auth_request_module \
            --with-http_random_index_module \
            --with-http_secure_link_module \
            --with-http_degradation_module \
            --with-http_slice_module \
            --with-http_stub_status_module \
            --with-http_perl_module=dynamic \
            --with-perl_modules_path=/usr/share/perl/5.26.1 \
            --with-perl=/usr/bin/perl \
            --http-log-path=/var/log/nginx/access.log \
            --http-client-body-temp-path=/var/cache/nginx/client_temp \
            --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
            --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
            --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
            --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
            --with-mail=dynamic \
            --with-mail_ssl_module \
            --with-stream=dynamic \
            --with-stream_ssl_module \
            --with-stream_realip_module \
            --with-stream_geoip_module=dynamic \
            --with-stream_ssl_preread_module \
            --with-compat \
            --with-pcre=../pcre2-10.40 \
            --with-pcre-jit \
            --with-zlib=../zlib-1.3 \
            --with-openssl=../openssl-3.1.2 \
            --with-debug \
            --with-cc-opt="-Wimplicit-fallthrough=0"
    ```

6. Build Nginx:

    ```bash
    make -j4
    sudo make install
    ```

### Post Build Actions

#### Optional: Removing Temp Dir

```Bash
cd ~
rm -rf nginx_build
```

#### Check Config

0. Check defaut nginx config existing:

    ```bash
    sudo nginx -t
    ```

    This command may throw this error on fresh setup:

    `nginx: [emerg] mkdir() "/var/cache/nginx/client_temp" failed (2: No such file or directory)`

    To fix it, continue reading this guide.
    If no error persist - nginx is installed:

    *Have fun using the Nginx!*

1. Create NGINX cache directories and set proper permissions:

    ```bash
    sudo mkdir -p /var/cache/nginx/client_temp /var/cache/nginx/fastcgi_temp /var/cache/nginx/proxy_temp /var/cache/nginx/scgi_temp /var/cache/nginx/uwsgi_temp
    sudo chmod 700 /var/cache/nginx/*
    sudo chown nginx:root /var/cache/nginx/*
    ```

2. Re-check syntax and potential errors.

    ```bash
    sudo nginx -t
    ```

#### Create systemd service

1. Create configuration:

    Using you favorite text editor, create service file:

    ```bash
    sudo nano /etc/systemd/system/nginx.service
    ```

    And put inside configuration:

    ```nginx
    [Unit]
    Description=nginx - high performance web server
    Documentation=https://nginx.org/en/docs/
    After=network-online.target remote-fs.target nss-lookup.target
    Wants=network-online.target

    [Service]
    Type=forking
    PIDFile=/var/run/nginx.pid
    ExecStartPre=/usr/sbin/nginx -t -c /etc/nginx/nginx.conf
    ExecStart=/usr/sbin/nginx -c /etc/nginx/nginx.conf
    ExecReload=/bin/kill -s HUP $MAINPID
    ExecStop=/bin/kill -s TERM $MAINPID
    ```

2. Enable Nginx service:

    - Reload systemd configuration:

        ```bash
        sudo systemctl daemon-reload
        ```

    - Enable Nginx:

        ```bash
        sudo systemctl enable nginx.service
        sudo systemctl start nginx.service
        sudo systemctl is-enabled nginx.service
        ```

*Have fun using the Nginx!*
