# NodeJS
## Contents
- [Abstract](#abstract)
- [Getting Started](#getting-started)
    1. [Node Version Manager (nvm)](#node-version-manager)
        - [Installation](#nvm-installation)
    2. [Node](#node)

## Abstract

This section will illustrate the preferred method for setting up a local development environment for node javascript development. The contained methods rely upon __nvm__ for simplified management of multiple installed Node versions.

## Getting Started

### Node Version Manager

Node version manager (nvm) is a convenient tool for managing multiple node installations. Refer to the [Github Repository](https://github.com/nvm-sh/nvm) for more information.

#### NVM Installation

To install the node version management tool, use the following commands:

```bash
#!/usr/bin/env bash

# due to the likelihood of version changes, check the official repo first!

# A) Download with curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# B) Download with wget
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

```

### Node

To install and make use of node versions, use the following commands:

```bash
#!/usr/bin/env bash

# install the latest long-term support version of node
nvm install --lts

# list available node versions
nvm ls

# use node version
nvm use 18.15.0

# then use npm normally
npm
```

For more information about npm, refer to the project's [Documentation](https://docs.npmjs.com/)