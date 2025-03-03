# odoocker-light

## Introduction

This repository aims to be a simplier *local* alternative to the [odoocker project](https://github.com/odoocker/odoocker).

It allows you to quickly set up a local dev environment for Odoo using Docker Compose. You have two options:

1. **[Attach mode]** Run using docker compose and then attach to the Odoo instance debug server on port 8888.
2. **[DevContainer mode]** Open the folder in a dev container and run the Odoo server from there.

## Overview

```text
.
├── .devcontainers/
│   ├── .env.example                        # Environment variables template file for docker-compose and odoo.conf variables
│   ├── Dockerfile                          # Dev container Dockerfile
│   ├── devcontainer.json                   # Dev container configuration
│   ├── docker-compose.extends.yaml         # Project specific docker-compose configuration (volume mounts for odoo modules...)
│   ├── docker-compose.devcontainer.yaml    # Devcontainer specific docker-compose configuration (volume mount for workspace folder)
│   └── docker-compose.yaml                 # Main docker-compose configuration
├── .vscode/
│   └── launch.json                         # VSCode launch configuration
├── extra-addons/                           # Odoo custom modules
│   ├── custom-addon-repo/
│   │   └── custom_addon/
│   │       ├── controllers/
│   │       ├── models/
│   │       ├── ...
│   │       ├── __init__.py
│   │       ├── __manifest__.py
│   │       └── README.md
│   └── another-custom-addon/
│       └── another_custom_addon/
│           └── ...
├── odoo/
│   ├── odoo/                               # Symlink to Odoo source code (when in dev container)
│   ├── odoo-design-themes/                 # Odoo design themes source code
│   ├── odoo-enterprise/                    # Odoo Enterprise source code
│   ├── odoo.conf                           # Odoo configuration file template
│   ├── odoorc.sh                           # Env variables to odoo.conf script
│   └── requirements.txt                    # Odoo dependencies
├── .gitignore
├── LICENSE
└── README.md
```

## How to use

### Configuration

1. Clone this repository and navigate to the root folder.
2. Clone `odoo-design-themes` and `odoo-enterprise` repositories in the `odoo` folder.
3. Add your Odoo modules repo to the `extra-addons` folder and create the `odoo/requirements.txt` file with the dependencies of your modules.
4. Create a `docker-compose.extends.yaml` file in the `.devcontainers` folder to extend the main `docker-compose.yaml` file. This file could contain the volume mounts for your Odoo modules for example.

    ```yaml
    services:
    odoo-web:
        volumes:
        - ../extra-addons/odoo-api-rest/odoo_api_rest:/mnt/extra-addons/odoo_api_rest
    ```

    Make sure to only have the python modules inside the extra-addons folder so that they are detected as [addons paths](https://www.odoo.com/documentation/18.0/developer/reference/cli.html?highlight=addons%20path#cmdoption-odoo-bin-addons-path).

5. Create a `.env` file in the `.devcontainers` folder. You can use `.env.example` as a template.
   - Used for docker-compose [variable interpolation](https://docs.docker.com/compose/how-tos/environment-variables/variable-interpolation/#interpolation-syntax)
   - Used as [`.env` file for the Odoo container](https://docs.docker.com/reference/compose-file/services/#env_file)
   - Used to create the [`odoo.conf` file](https://www.odoo.com/documentation/18.0/developer/reference/cli.html#reference-cmdline-config-file)

### Docker compose attach setup

Launch the Odoo server and its database using :

```bash
bash startup.sh
```

You can now access the Odoo instance at [http://localhost:8069](http://localhost:8069).

In order to debug your custom addons, you can attach to the Odoo instance debug server on port 8888. You can do this by using the `[Attach mode] Attach to Odoo` launch configuration in VSCode.

Make sure to adjust the `pathMappings` to match the extra addons volume mount you created in the `docker-compose.extends.yaml` file.

For instance :

```yaml
services:
  odoo-web:
    volumes:
      - ../extra-addons/odoo-api-rest/odoo_api_rest:/mnt/extra-addons/odoo_api_rest
```

Would forces you to set the `pathMappings` as follows :

```json
"pathMappings": [
                    {
                        "localRoot": "${workspaceFolder}/extra-addons/odoo-api-rest/odoo_api_rest",
                        "remoteRoot": "/mnt/extra-addons/odoo_api_rest"
                    }
                ],
```

### Dev container setup

Just use `F1` and select `Dev Containers: Reopen in Container` in VSCode.

Then press `F5` to start the Odoo server in debug mode using `[DevContainer mode] Odoo Debug` launch config, add breakpoint and start debugging.
