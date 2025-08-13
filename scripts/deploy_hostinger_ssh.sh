#!/bin/bash

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

# Check required variables
if [ -z "$SSH_HOST" ] || [ -z "$SSH_USER" ]; then
    echo "Error: SSH configuration missing in .env file"
    echo "Please edit .env file and add:"
    echo "  SSH_HOST=your_server_ip"
    echo "  SSH_USER=your_username"
    exit 1
fi

SSH_PORT=${SSH_PORT:-65002}
SOURCE_DIR="website/src/"
DEST_PATH="$SSH_USER@$SSH_HOST:/home/$SSH_USER/"

echo "============================================"
echo "  Deploying to Hostinger"
echo "============================================"
echo "Source: $SOURCE_DIR"
echo "Destination: $DEST_PATH"
echo ""

# Test SSH connection first
echo "Testing SSH connection..."
ssh -p $SSH_PORT $SSH_USER@$SSH_HOST "echo 'SSH connection successful!'"

if [ $? -ne 0 ]; then
    echo "Error: Cannot connect via SSH"
    echo "Please check your SSH credentials in .env file"
    exit 1
fi

# Deploy files using rsync
echo "Uploading files..."
rsync -avz --delete \
    -e "ssh -p $SSH_PORT" \
    $SOURCE_DIR* \
    $DEST_PATH/public_html/

if [ $? -eq 0 ]; then
    echo ""
    echo "============================================"
    echo "  Deployment Complete!"
    echo "============================================"
    echo "Visit: https://nomaansolution.in"
else
    echo "Error: Deployment failed"
    exit 1
fi
