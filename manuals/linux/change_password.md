# Linux Password Management Cheat Sheet

## Table of contents

- [Linux Password Management Cheat Sheet](#linux-password-management-cheat-sheet)
  - [Table of contents](#table-of-contents)
  - [Change User Password](#change-user-password)
  - [Force Password Expiry](#force-password-expiry)
  - [Password Policy Information](#password-policy-information)
  - [Unlock User Account](#unlock-user-account)
  - [Lock User Account](#lock-user-account)
  - [Notes](#notes)

## Change User Password

```bash
passwd
```

or

```bash
sudo passwd <username>
```

- If run without `<username>`, it changes the password for the current user.
- Use `<username>` to change the password for a specific user.

## Force Password Expiry

```bash
sudo chage -d 0 <username>
```

- `<username>`: Replace with the desired username.
- Forces the user to change their password upon the next login.

## Password Policy Information

```bash
sudo chage -l <username>
```

- `<username>`: Replace with the desired username.
- Displays password-related information for the user.

## Unlock User Account

```bash
sudo passwd -u <username>
```

- `<username>`: Replace with the locked username.
- Unlocks a user account.

## Lock User Account

```bash
sudo passwd -l <username>
```

- `<username>`: Replace with the username to be locked.
- Locks a user account.

## Notes

- The `passwd` command alone changes the password for the current user.
- Use `sudo` to change the password for another user.
- `chage` is used to manipulate password expiry information.
- Unlock or lock a user account using `passwd -u` or `passwd -l`.

Remember to replace placeholders with actual values!

Tags: #install, #linux, #workflow
