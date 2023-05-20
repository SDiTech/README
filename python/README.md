# Python
## Contents
- [Abstract](#abstract)
- [Getting Started](#getting-started)
    1. [pyenv](#pyenv)
        - [Dependencies](#pyenv-dependencies)
        - [Installation](#pyenv-installation)
            - [Automatic Install](#pyenv-automatic-installation)
            - [Github Install](#pyenv-github-installation)
        - [Shell Configuration](#pyenv-shell-environment)
        - [Python Installation](#pyenv-python-installation)
    2. [pipenv](#pipenv)

## Abstract

This section will illustrate the preferred method for setting up a local development environment for Python. The contained methods rely upon __pyenv__ for simplified management of multiple installed Python versions and __pipenv__ for dependency tracking/graphing which may be subject to limited availablility for specific operating systems.

## Getting Started

### pyenv

Getting started with pyenv is pretty straight-forward. See the [Github Repository](https://github.com/pyenv/pyenv) or the [Project Wiki](https://github.com/pyenv/pyenv/wiki#suggested-build-environment) for more information.


#### pyenv Dependencies

If scripts are not provided for your distribution, refer to the [Project Wiki](https://github.com/pyenv/pyenv/wiki#suggested-build-environment). Otherwise, use the following scriptlets to satisfy pyenv's dependencies:
```bash
#!/usr/bin/env bash

# A) Debian Operating Systems
sudo apt update; sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
# Additionally, add llvm if building PyPy from source or other Python flavors which require CLang
llvm

# B) Fedora
dnf install make gcc patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-devel libnsl2-devel

```

#### pyenv Installation

##### pyenv Automatic Installation

```bash
#!/usr/bin/env bash

# this is technically a no-no if you don't verify the script first!!!
curl https://pyenv.run | bash
```

<p color="red"><b>Note</b>: curl installation required</p>

##### pyenv Github Installation

```bash
#!/usr/bin/env bash

# clone the repository
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# attempt to compile bash extension to speed up pyenv (it's okay if it fails!)
cd ~/.pyenv && src/configure && make -C src
```

#### pyenv Shell Environment

[Source](https://github.com/pyenv/pyenv#set-up-your-shell-environment-for-pyenv)

For __bash__ and __zsh__:
```bash
#!/usr/bin/env bash

# A) bash
# add the following lines to ~/.bashrc, ~/.profile, ~/.bash_profile, ~/.bash_login
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# B) zsh
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

## then restart (shell and/or machine)
exec "$SHELL"
```
#### pyenv Python Installation

Now that pyenv is properly installed and configured, it's time to install Python.

```bash
#!/usr/bin/env bash

# list available python versions; if the latest versions don't display, pyenv may need to be reinstalled (?)
pyenv install -l

# install the latest version (example)
pyenv install 3.11.2

# set the newly installed version to be used globally
pyenv global 3.11.2
```

### pipenv

pipenv is installed via the Python Package Index (PyPI) and the built-in `pip` tool:

```bash
#!/usr/bin/env bash

pip install pipenv
```