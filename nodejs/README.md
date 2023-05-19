# NodeJS
## Contents
- [Abstract](#abstract)
- [Getting Started](#getting-started)
    1. [Node Version Manager (nvm)](#node-version-manager)
        - [Installation](#nvm-installation)

## Abstract

This section will illustrate the preferred method for setting up a local development environment for node javascript development. The contained methods rely upon __nvm__ for simplified management of multiple installed Node versions.

## Getting Started

### Node Version Manager

Node version manager (nvm) is a convenient tool for managing multiple node installations. Refer to the [Github Repository](https://github.com/nvm-sh/nvm) for more information.

#### NVM Installation

```bash
#!/usr/bin/env bash

# due to the likelihood of version changes, check the official repo first!

# A) Download with curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# B) Download with wget
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

```