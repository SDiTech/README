# SSH

The SSH, Secure Shell, protocol is useful for remotely (and securely) accessing machines for use and administration activities via terminal sessions.

## Contents
- [Abstract](#abstract)
- [Getting Started](#getting-started)
    - [OpenSSH](#openssh)
        - [Server Requirements](#server-requirements)
        - [Client Requirements](#client-requirements)
    - [Setup](#openssh-setup)
        - [Server Setup](#server-setup)
            - [Configuration](#server-configuration)
        - [Client Setup](#client-setup)
            - [Configuration](#client-configuration)

## Abstract

This section will outline the general requirements and processes necessary to establish a SSH Client/Server interaction. 

## Getting Started

### OpenSSH

OpenSSH is one of the most commonly recognized providers of SSH Server/Client software. Due to its widespread availability there may be variations in the software's behavior and are commonly differences involving configuration file locations.

#### Server Requirements

The "Server", aka the machine to be remotely accessed, will have several requirements minimally including:
- the `openssh-server` (or equivalent) package
- a non-root user account
- access to administrative privileges

Optionally, it may be preferred to:
- configure the openssh-server by editing the file: `/etc/ssh/sshd_config`
    - disallow root SSH login
    - disallow password login
    - enable certificate authentication
    - (?) disallow challenge response authentication
    - (?) limit user session instances
    - (?) additional options
- configure a firewall or similar services (firewalld, ufw, pf, fail2ban, etc...)

#### Client Requirements

The "Client", aka the local client machine used to access other remote machines, will require:
- the `openssh-client` (or equivalent) package

### OpenSSH Setup

#### Server Setup

The server will need to have the `sshd` system service running and/or enabled at startup:

```bash
#!/usr/bin/env bash

# confirm sshd service is running
systemctl status sshd

# if sshd is not active, start and enable for future system startups
systemctl start sshd  && systemctl enable sshd

# IF modifications are made to the configuration file: /etc/ssh/sshd_config
# restart the service
systemctl restart sshd
```

##### Server Configuration

Additional server configuration may be necessary, though before proceeding it is suggested to complete the [Client Setup](#client-setup).

1. Evaluate and apply the following desired updates to the system's /etc/ssh/sshd_config:

    ```bash
    # /etc/ssh/sshd_config

    # ...
    # 1) disallow root login
    PermitRootLogin no

    # 2) disallow password login
    PasswordAuthentication no
    PermitEmptyPasswords no

    # 3) enable certificate authentication
    PubkeyAuthentication yes

    # 4) (?) disallow challenge response authentication
    ChallengeResponseAuthentication no

    # 5) (?) limit user sessions
    # defaults:
    # MaxSessions 10
    # MaxStartups 10:30:100
    MaxSessions 5
    MaxStartups 10:30:60

    # 6) (?) additional options
    # X11Forwarding yes
    # ...

    ```

2. Restart the SSH service:

    ```bash
    #!/usr/bin/env bash

    systemctl restart sshd
    ```

#### Client Setup

Once the server has the SSH service enabled and active, a user with knowledge of valid user login credentials may access it. However, to increase security, it is recommended to configure use with certificate-based authentication.

##### Client Configuration

To create and use a new certificate for SSH logins:

1. Create the Certificate/Key pair:

    ```bash
    #!/usr/bin/env bash

    # follow the prompt to create a new rsa certificate (with default values)
    ssh-keygen

    # for windows use git bash as it has the ssh-keygen utility installed & use ed25519 unless there is a reason to use rsa 4096 or other alternatives
    ssh-keygen -f {private-filename} -t {encryption-algorithm}
    ```

2. Confirm proper directory and file permissions:

    ```bash
    # Permissions:
    #
    # ~ (/home/user)    (drwxr-xr-x)    755
    # .ssh              (drwx------)    700
    # .ssh/public_key   (-rw-r--r--)    644
    # .ssh/private_key  (-rw-------)    600

    # Windows?
    ```

3. Add a new entry to the client SSH configuration file:

    ```bash
    # file:
    # ~/.ssh/config

    Host RemoteServer
        HostName IP-or-FQDN
        Port 22
        User YourUser
        IdentityFile ~/.ssh/private_key
        PubKeyAuthentication no
        IdentitiesOnly no
    ```

4. Transmit the certificate to the remote host:

    ```bash
    #!/usr/bin/env bash

    # the -i flag may be used to specify the certificate (without a corresponding ~/.ssh/config entry)
    ssh-copy-id YourUser@RemoteServer

    # on Windows there is no ssh-copy-id so the following workaround is required using powershell
    type $env:USERPROFILE\.ssh\{private-key}.pub | ssh {IP-OR-FQDN} "cat >> .ssh/authorized_keys"

    # on Windows confirm success with the following
    ssh {IP-OR-FQDN}

    # the remote system WILL PROMPT you for the user's password before transferring the identity file
    ```

5. Update the client SSH configuration file:

    ```bash
    # ~/.ssh/config

    Host RemoteServer
        HostName IP-or-FQDN
        Port 22
        User YourUser
        IdentityFile ~/.ssh/private_key
        PubKeyAuthentication yes
        IdentitiesOnly yes
    ```

6. Proceed with [Server Configuration](#server-configuration)