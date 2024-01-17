# Linux User and sudo Management Cheat Sheet

## Add User to sudo Group

```bash
sudo usermod -aG sudo <username>
```

- `<username>`: Replace with the desired username.

## Verify sudo Access

```bash
sudo -lU <username>
```

- `<username>`: Replace with the username to check.

## Edit sudoers File

```bash
sudo visudo
```

- Opens the sudoers file in the default text editor, ensuring syntax checks.

### Add User to sudoers File

Add the following line:

```plaintext
<username>  ALL=(ALL:ALL) ALL
```

- `<username>`: Replace with the desired username.

### Grant Specific Commands

For more granular control, use:

```plaintext
<username>  ALL=(ALL:ALL) /path/to/command, /another/path/to/command
```

- Replace `<username>` with the username.
- Adjust `/path/to/command` and `/another/path/to/command` with the specific commands.

**Notes:**

- `usermod` adds a user to the sudo group, while editing the sudoers file provides more granular control.
- `sudo visudo` is the recommended way to edit the sudoers file, ensuring syntax checks.
- Always be cautious when editing the sudoers file to avoid syntax errors that could lock you out.
- Grant specific command access for additional security.

Remember to replace placeholders with actual values!

Tags: #install, #linux, #workflow
