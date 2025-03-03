#!/bin/bash

# Initialize docker-compose command
DOCKER_COMPOSE_CMD="docker compose -p odoocker-light_attach_mode -f .devcontainer/docker-compose.yaml"

# Check if docker-compose.extends.yaml exists
if [ -f ".devcontainer/docker-compose.extends.yaml" ]; then
    DOCKER_COMPOSE_CMD="$DOCKER_COMPOSE_CMD -f .devcontainer/docker-compose.extends.yaml"
fi

# Check if .env file exists
if [ -f ".devcontainer/.env" ]; then
    DOCKER_COMPOSE_CMD="$DOCKER_COMPOSE_CMD --env-file .devcontainer/.env"
fi

# Run the docker-compose command
$DOCKER_COMPOSE_CMD up