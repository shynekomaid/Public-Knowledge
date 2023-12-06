# RTL-SDR for Linux Quick Start Guide

## Table of Content

- [RTL-SDR for Linux Quick Start Guide](#rtl-sdr-for-linux-quick-start-guide)
  - [Table of Content](#table-of-content)
  - [Overview](#overview)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Setup the RTL-SDR Driver](#setup-the-rtl-sdr-driver)
  - [Config Dongle](#config-dongle)
  - [Reboot the System](#reboot-the-system)
  - [Test RTL-SDR](#test-rtl-sdr)
  - [Start RTL TCP Server](#start-rtl-tcp-server)
  - [Connecting to the RTL TCP Server](#connecting-to-the-rtl-tcp-server)
  - [Useful Links](#useful-links)

## Overview

This guide provides step-by-step instructions to set up RTL-SDR on a NanoPi Neo running Armbian 22 Jammy. RTL-SDR is a popular software-defined radio receiver that allows you to listen to a wide range of radio frequencies.

## Prerequisites

Before starting, ensure that your RTL-SDR dongle is properly connected. You can use the `lsusb` command to check if the device is detected. If not, try plugging and unplugging the device or using a different USB port.

## Installation

Update the package list and install necessary dependencies:

```bash
sudo apt update
sudo apt upgrade
sudo apt install git cmake build-essential libusb-1.0-0-dev pkg-config
```

## Setup the RTL-SDR Driver

**WARNING**: If you encounter the error "fatal error: libusb.h: No such file or directory" during the `make` process, follow these steps:

1. Open the file `~/rtl-sdr/src/librtlsdr.c`.
2. Change `#include <libusb.h>` to `#include </usr/include/libusb-1.0/libusb.h>`.
3. Retry the `make` command.

Proceed with the RTL-SDR driver installation:

```bash
cd
git clone git://git.osmocom.org/rtl-sdr.git
cd rtl-sdr/
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON # Important flag
make
sudo make install
sudo ldconfig
sudo cp ../rtl-sdr.rules /etc/udev/rules.d/
```

## Config Dongle

Add the standard TV-dongle driver to the denylist to prevent conflicts:

```bash
echo "blacklist dvb_usb_rtl28xxu" | sudo tee -a /etc/modprobe.d/blacklist-rtl.conf
```

## Reboot the System

Reboot the system to unload the `dvb_usb_rtl28xxu` module:

```bash
sudo reboot now
```

## Test RTL-SDR

After the reboot, test your RTL-SDR setup using the `rtl_test` command:

```bash
rtl_test -s 2400000
```

## Start RTL TCP Server

To use RTL-SDR over a network, start the RTL TCP server:

```bash
sudo rtl_tcp -a 192.168.1.188 -p 1234
```

## Connecting to the RTL TCP Server

To connect to the RTL TCP server in Windows, follow these steps:

1. Download and install HDSDR from [https://www.hdsdr.de/index.html](https://www.hdsdr.de/index.html).
2. Download the `ExtIO_RTLTCP_improved2.dll` from [https://sourceforge.net/projects/extio-rtltcp-improved/](https://sourceforge.net/projects/extio-rtltcp-improved/).
3. Copy the `ExtIO_RTLTCP_improved2.dll` to `C:\Program Files (x86)\HDSDR`.
4. Launch HDSDR and press `F8` to open the address settings menu.
5. Set the IP address and port of the RTL TCP server.
6. Press `F2` to start listening.

## Useful Links

- [Быстрый старт с RTL-SDR в Linux](https://blog.radiotech.kz/radio/bystryj-start-s-rtl-sdr-v-linux/)
- [RTL-SDR Blog GitHub Repository](https://github.com/rtlsdrblog/rtl-sdr-blog)
- [osmocom RTL-SDR GitHub Repository](https://github.com/osmocom/rtl-sdr)
- [RTL-SDR at Osmocom](https://osmocom.org/projects/rtl-sdr/wiki)
- [Raspberry Pi RTL-SDR Setup Guide](https://www.linuxwolfpack.com/raspberrypi-rtlsdr.php)
- [Quick Start Guide (PDF)](https://ranous.files.wordpress.com/2020/05/rtl-sdr4linux_quickstartguidev20.pdf)

Please refer to the provided links for additional information and resources related to RTL-SDR. Happy listening!

Tags: #linux, #windows, #hardware, #radio
