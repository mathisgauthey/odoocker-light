#!/bin/bash

# Check if the symbolic link for odoo exists, if not create it
if [[ ! -L /workspace/odoo/odoo ]]; then
    ln -s /usr/lib/python3/dist-packages/odoo /workspace/odoo/odoo
fi

# Check if the symbolic link for design-themes exists, if not create it
if [[ ! -L /workspace/odoo/design-themes ]]; then
    ln -s /usr/lib/python3/dist-packages/odoo/design-themes /workspace/odoo/design-themes
fi