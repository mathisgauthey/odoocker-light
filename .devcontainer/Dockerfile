FROM odoo:17

# Set build variables
ARG PROJECT_NAME
ARG ENTERPRISE_ADDONS
ARG DESIGN_THEMES_ADDONS

# Switch to root user
USER root

RUN mkdir -p ${ENTERPRISE_ADDONS}
COPY --chown=odoo:odoo ./odoo/odoo-enterprise ${ENTERPRISE_ADDONS}
RUN  mkdir -p ${DESIGN_THEMES_ADDONS}
COPY --chown=odoo:odoo ./odoo/odoo-design-themes ${DESIGN_THEMES_ADDONS}

# Copy & Install dev requirements
COPY --chown=odoo:odoo ./odoo/dev_requirements.txt /tmp/dev_requirements.txt
RUN python3 -m pip install -r /tmp/dev_requirements.txt && \
    rm /tmp/dev_requirements.txt

# Copy & Install extra addons requirements
COPY --chown=odoo:odoo ./odoo/requirements.txt /tmp/requirements.txt
RUN python3 -m pip install -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt

# Copy environment script to generate odoo.conf
COPY --chown=odoo:odoo ./.devcontainer/.env /
COPY --chown=odoo:odoo ./odoo/odoo.conf /
COPY --chown=odoo:odoo ./odoo/odoorc.sh /
# Ensure odoorc.sh is executable and generate odoo.conf
RUN chmod +x /odoorc.sh && /odoorc.sh && chown odoo:odoo ${ODOO_RC}

# Switch back to odoo user
USER odoo
