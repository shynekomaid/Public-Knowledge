# Downloading Sponsored Videos

## Table of Contents

- [Downloading Sponsored Videos](#downloading-sponsored-videos)
  - [Table of Contents](#table-of-contents)
  - [Preparation](#preparation)
    - [Become a Sponsor](#become-a-sponsor)
    - [Creating a List of Sponsored Videos](#creating-a-list-of-sponsored-videos)
    - [Tips for Windows 10/11 Users](#tips-for-windows-1011-users)
    - [Tips for Linux Users](#tips-for-linux-users)
  - [Downloading](#downloading)
    - [Downloading on Windows](#downloading-on-windows)
    - [Downloading on Linux](#downloading-on-linux)
  - [Conclusion](#conclusion)

## Preparation

### Become a Sponsor

To access and download sponsored videos, you'll need an active sponsored subscription for the channel you're interested in.

**Please note that piracy is not an acceptable method for obtaining these videos.**

### Creating a List of Sponsored Videos

Regrettably, there is no automated way to retrieve a list of all sponsored videos from a channel. You'll need to manually compile a list by recording the URLs of the videos.

We recommend creating a separate text file to record all the URLs with spaces in between. You can then copy and paste these URLs into the command for downloading (see below).

### Tips for Windows 10/11 Users

If you're using Windows 10 or 11 and encounter issues related to Chrome's exclusive cookie access, you can address this problem by opening a Chrome or Chromium-based browser with administrator privileges using the following commands:

```PowerShell
cd "C:\Program Files\Google\Chrome\Application"
.\chrome.exe -disable-features=LockProfileCookieDatabase
```

This should resolve any cookie access problems.

### Tips for Linux Users

Linux users can resolve cookie access issues by opening a terminal and running the following command to open a Chromium-based browser with the LockProfileCookieDatabase feature disabled:

```bash
chromium-browser --disable-features=LockProfileCookieDatabase
```

This command will help ensure proper cookie access on Linux systems.

## Downloading

### Downloading on Windows

To download sponsored videos on Windows, you can use the following command as an example:

```PowerShell
"C:\Users\user\Downloads\yt-dlp.exe" -S "res:1080" -o "D:\downloads\%(upload_date)s\%(title)s [%(id)s].%(ext)s" --cookies-from-browser chrome {urls}
```

Be sure to replace `{urls}` with the actual URLs of the sponsored videos you wish to download.

### Downloading on Linux

For Linux users, you can use a similar command to download sponsored videos. Replace `"C:\Users\user\Downloads\yt-dlp.exe"` with the appropriate command to run yt-dlp on your Linux distribution:

```bash
yt-dlp -S "res:1080" -o "/path/to/your/downloads/directory/%(upload_date)s/%(title)s [%(id)s].%(ext)s" --cookies-from-browser chrome {urls}
```

Again, make sure to replace `{urls}` with the actual URLs of the sponsored videos you want to download.

## Conclusion

Downloading sponsored videos can be a straightforward process once you have become a sponsor, manually compiled a list of the videos you want to download, and addressed any cookie access issues based on your operating system. Always respect content creators' terms and conditions and avoid any unauthorized use or distribution of their content.

Tags: #yt-dlp, #video, #youtube
