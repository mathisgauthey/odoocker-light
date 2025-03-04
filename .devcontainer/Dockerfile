FROM odoo:17

# ---------------------------------------------------------------------------- #
#                       Setting Up The Build Environment                       #
# ---------------------------------------------------------------------------- #

# Set build variables
ARG ENTERPRISE_ADDONS_PATH
ARG DESIGN_THEMES_ADDONS_PATH

# Switch to root user
USER root

# Install git and create directories for addons
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p ${ENTERPRISE_ADDONS_PATH} ${DESIGN_THEMES_ADDONS_PATH}

# ---------------------------------------------------------------------------- #
#              Installing Odoo Enterprise And Design Themes Addons             #
# ---------------------------------------------------------------------------- #

# Install enterprise addons
COPY --chown=odoo:odoo ./odoo/enterprise ${ENTERPRISE_ADDONS_PATH}

# Install design themes addons
RUN git clone https://github.com/odoo/design-themes.git ${DESIGN_THEMES_ADDONS_PATH}

# ---------------------------------------------------------------------------- #
#                         Instaling Python Dependencies                        #
# ---------------------------------------------------------------------------- #

# Copy & Install dev requirements
COPY --chown=odoo:odoo ./odoo/dev_requirements.txt /tmp/dev_requirements.txt
RUN python3 -m pip install -r /tmp/dev_requirements.txt && \
    rm /tmp/dev_requirements.txt

# Copy & Install extra addons requirements
COPY --chown=odoo:odoo ./odoo/requirements.txt /tmp/requirements.txt
RUN python3 -m pip install -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt

# ---------------------------------------------------------------------------- #
#                      Generating Odoo Configuration File                      #
# ---------------------------------------------------------------------------- #

# Copy environment script to generate odoo.conf
COPY --chown=odoo:odoo ./.devcontainer/.env /
COPY --chown=odoo:odoo ./odoo/odoo.conf /
COPY --chown=odoo:odoo ./odoo/odoorc.sh /

# Ensure odoorc.sh is executable and generate odoo.conf
RUN chmod +x /odoorc.sh && /odoorc.sh && chown odoo:odoo ${ODOO_RC}

# ---------------------------------------------------------------------------- #
#                             Cleaning Things Up...                            #
# ---------------------------------------------------------------------------- #

# Switch back to odoo user
USER odoo
