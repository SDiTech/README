# Developer Environment Setup

This document contains general information and other helpful pointers related to the creation of general purpose development environments.

### Overview
---

When creating a development environment many unique factors may require additional consideration including, but not limited to: space requirements, hardware limitations, perceived growth, backups, or simple personal preference.

While this guide attempts to standardize or otherwise limit installation instructions for efficiency, it is far from comprehensive. When in doubt, use your best judgment as you are most familiar with your individual needs. Though in many instances, modifying configuration options later may be possible with varying degrees of difficulty.

### Pre Installation
---

1. Download and verify the authenticity of the Operating System installation medium. 

    _note:_ a general purpose development environment may use debian or any other linux/unix distribution, though this guide assumes [debian](https://www.debian.org/).

<!-- Should we elaborate or just let this one go? -->


2. Assuming the utilized hardware meets the minimum requirements, proceed with installation of the required __host machine__ programs:

    ```bash
    # @requires: `root` or `sudo`
    apt-get update && \
        apt-get install virt-manager;

    # add your user to the libvirt user group
    usermod -aG libvirt your_user;
    ```


3. Launch the virt-manager application and create a new virtual machine disk image using the verified installation medium with the following _minimum recommended settings_ &mdash; some of which may be easily re-configured.

    __Minimum Recommended Settings__
    - 1024mb (RAM)
    - 1 core (CPU)
    - 25gb (Virtual Disk Storage)

### System Installation
---

Run the virtual machine and respond to the prompts to assign host name, domain name, root password, user account configuration, timezone, partitioning scheme, and default installation packages.

_note_: While passwords and timezones are left entirely to the user, it is suggested to consider the default configuration in order to minimize the installation size:
- use LVM guided partitioning scheme,
- deselect packages for the debian desktop environment,
- select both options to include openssh server and standard system utilities

_extended note_: In the event that a manual partitioning scheme is preferred, the [Arch Wiki](https://wiki.archlinux.org/title/Installation_guide) suggests the following minimums:
- swap space > 512mb
- boot partition > 300mb (uefi systems only)

### General Package Installations
---

#### __general packages__
- curl
- avahi-daemon
- Source Control Management (SCM):
    - git/git-flow
    - fossil
- Firewalls
    - ufw
    - firewalld
- development packages(?)

#### __docker__

docker is a utility which facilitates the creation, use, and orchestration of microapplication components gathered into logical units called _'containers'_ via `docker` and `docker compose`. See their [Github repository](https://github.com/docker/docker-install) for more information concerning available installation methods.

##### Install

```bash
# download the install script
curl -fsSL https://get.docker.com -o get-docker.sh

# @requires: `root` or `sudo`
sh get-docker.sh
```

#### __nvm__

nvm (node version manager) is a tool for managing multiple node version installations. Always confirm the latest version by checking the [Github repository](https://github.com/nvm-sh/nvm#install--update-script).

##### Install

```bash
# run as local user account
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
```

<!-- ##### Use
```bash
# install node
nvm install --lts
``` -->


#### __dotnet__

dotnet is the official SDK and runtime environment provided by Microsoft for use in developing C# applications.

[Official instructions](https://learn.microsoft.com/en-us/dotnet/core/install/linux-debian)

##### Install

```bash

# download 
wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb

# @requires: `root` or `sudo`
# update package sources
sudo dpkg -i packages-microsoft-prod.deb

# install related package options
sudo apt-get update && \
    sudo apt-get install -y dotnet-sdk-7.0 # dotnet-sdk-6.0
```


#### __pyenv__
    
pyenv is a practical approach to maintaining multiple python installations without vandalizing the System interpreter or related packages.

[Project repository](https://github.com/pyenv/pyenv)

```bash
# run as local user account
curl https://pyenv.run | bash

```

### Post Install

#### Setup SSH

__Host__

Create and transmit the ssh certificate:

```bash
# navigate to the ssh configuration directory on the host
cd ~/.ssh
# create a new ssh certificate key pair; provide answers at each prompt
ssh-keygen
# copy certificate to virtual machine openssh server
ssh-copy-id -i cert_name user_name@ip_address

# you will then be prompted to enter the user's password for the key exchange to occur
```

__Client__

Alter the ssh configuration:

```bash
# /etc/ssh/sshd_config

# search, uncomment, and change this option to value 'no'
PasswordAuthentication no
```

Restart ssh

```bash
systemctl restart sshd
# OR
systemctl reboot
```

#### Docker Configuration

This isn't really necessary, but it makes the resultant container ip addresses convenient:

```bash
# /etc/docker/daemon.json
{
    "data-root": "/data/docker",
    "live-restore": true,
    "bip": "10.10.0.1/16",
    "default-address-pools": [{
        "base": "10.0.0.0/8",
        "size": 16
    }]
}```