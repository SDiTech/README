# Setup

This section documents prerequisites to using pass for borg repository access.

## GPG Key Generation

In a terminal session run `gpg --full-generate-key` and follow the prompt to generate a new key

Display the key information and directory location using `gpg --list-secret-keys --keyid-format=long`

The corresponding output should appear as follows:

```bash
/path/to/.gnupg/pubring.kbx
-----------------------------
sec   ed25519/short-key YYYY-mm-dd [SC]
      [long-key]
uid                 [ultimate] user-name <user@example.com>
ssb   cv25519/[other-short-key] YYYY-mm-dd [E]
```

## Pass Key Generation

Create the pass storage repo using the gpg key: `pass init [long-key]`

Insert storage pass key where the dialog will prompt for the desired password: `pass insert local/resource`

Confirm the password was properly stored: `pass local/resource`