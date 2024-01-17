# Linux User Management Cheat Sheet

## Table of contents

- [Linux User Management Cheat Sheet](#linux-user-management-cheat-sheet)
  - [Table of contents](#table-of-contents)
  - [Add User (Modern and Recommended)](#add-user-modern-and-recommended)
  - [Add User (Traditional)](#add-user-traditional)
    - [Set Password](#set-password)
    - [Add to sudo Group](#add-to-sudo-group)
    - [Modify User Information](#modify-user-information)
  - [Delete User](#delete-user)
  - [Notes](#notes)

## Add User (Modern and Recommended)

```bash
sudo adduser <username>
```

## Add User (Traditional)

```bash
sudo useradd <username>
```

### Set Password

```bash
sudo passwd <username>
```

### Add to sudo Group

```bash
sudo usermod -aG sudo <username>
```

### Modify User Information

```bash
sudo usermod -c "Full Name" <username>
```

## Delete User

```bash
sudo userdel -r <username>
```

__\<username\>__: Replace with the desired username.

## Notes

- Use adduser for a more user-friendly and interactive way to create users.
- Adding to the sudo group grants administrative privileges.
- Modify user information using usermod -c.
- Delete a user with their home directory using userdel -r.
- Replace placeholders with actual values!

Tags: #install, #linux, #workflow
