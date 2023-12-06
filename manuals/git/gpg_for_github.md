# Guide: Creating a GPG Key for GitHub

Using GPG (GNU Privacy Guard) keys with GitHub adds an additional layer of security and trustworthiness to your commits. It allows others to verify that your commits are genuinely from you. This guide provides step-by-step instructions on how to create a GPG key and link it to your GitHub account.

## Prerequisites

- A GitHub account.
- GPG command-line tools. If you haven't installed it yet, refer to the [official GnuPG documentation](https://gnupg.org/download/) for guidance.

## Step-by-Step Instructions

### 1. Generate a GPG Key

```bash
gpg --full-generate-key
```

- Choose the type of key you want (typically "RSA and RSA" for most users).
- Choose the key size (4096 bits is recommended for added security).
- Set an expiration date for the key.
- Provide your name and email. The email should match the one you use for your GitHub account.
- Set a passphrase for your key. This is essential and adds a layer of security.

### 2. List the GPG Keys

List the GPG keys for which you have both a public and private key. Your key should appear in the list.

```bash
gpg --list-secret-keys --keyid-format LONG
```

From the list, identify the GPG key ID you wish to use. It's usually the string after `rsa4096/` and before the date.

### 3. Export the GPG Key

Replace `YOUR_GPG_KEY_ID` with your GPG key ID from the previous step.

```bash
gpg --armor --export YOUR_GPG_KEY_ID
```

This will print your GPG public key. Copy the output (including the `-----BEGIN PGP PUBLIC KEY BLOCK-----` and `-----END PGP PUBLIC KEY BLOCK-----` lines).

### 4. Add the GPG Key to GitHub

- Go to [GitHub settings](https://github.com/settings/keys).
- Click on `New GPG key`.
- Paste your GPG key into the text box and click `Add GPG key`.
- Enter your GitHub password if prompted.

### 5. Configure Git to Sign Commits

Replace `YOUR_GPG_KEY_ID` with your GPG key ID.

```bash
git config --global user.signingkey YOUR_GPG_KEY_ID
```

Optional: If you want to sign all commits by default in any local repository on your computer, run:

```bash
git config --global commit.gpgsign true
```

### 6. Commit with Signed-off

When you make a commit, use the `-S` option:

```bash
git commit -S -m "Your commit message here"
```

This will sign your commit with your GPG key.

### 7. Verifying Your Signed Commit on GitHub

After pushing your signed commit to GitHub, you should see a "Verified" label next to your commit, indicating that it was signed with a valid GPG key.

## Conclusion

Setting up a GPG key with GitHub may seem complex at first, but it's a one-time setup that provides an additional layer of trustworthiness to your commits. Ensure to keep your private key secure and remember the passphrase you set for it.

Tags: #git, #github, #gpg
