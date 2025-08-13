#!/bin/bash

# Nomaan Solution - Complete Project Structure Creator
# This script creates the entire project structure idempotently

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}  Nomaan Solution - Project Setup${NC}"
echo -e "${GREEN}============================================${NC}"

# Base directory
BASE_DIR="$HOME/Desktop/NomaanSolution"

# Create base directory
echo -e "${YELLOW}Creating project structure...${NC}"
mkdir -p "$BASE_DIR"
cd "$BASE_DIR"

# Create directory structure
directories=(
    "docs/SOPs"
    "docs/Policies"
    "docs/Sales"
    "docs/Marketing"
    "website/src/assets/logo"
    "website/src/assets/images"
    "website/src/css"
    "website/src/js"
    "website/src/includes"
    "website/dist"
    "automations/lead_intake"
    "automations/email_sequences"
    "scripts"
    "infra"
    "security"
    "backups"
)

for dir in "${directories[@]}"; do
    mkdir -p "$dir"
    echo -e "  ✓ Created: $dir"
done
# Create root files
echo -e "${YELLOW}Creating root configuration files...${NC}"

# Create .env.example
cat > .env.example << 'EOF'
# Nomaan Solution Environment Configuration
DOMAIN=nomaansolution.in
SITE_URL=https://nomaansolution.in
RAZORPAY_KEY_ID=rzp_test_qqnCMhu3F0wjJ8
RAZORPAY_KEY_SECRET=8TikxGpUrKpHCGFTOfOJhOor
SMTP_HOST=smtp.hostinger.com
SMTP_PORT=587
SMTP_USER=hello@nomaansolution.in
SMTP_PASSWORD=N0maan#2021@ai
SSH_HOST=ssh -p 65002 u295218874@93.127.208.254
SSH_USER=u295218874
SSH_PORT=65002
SSH_PATH=/home/your_username/public_html
WHATSAPP_NUMBER=919076069071
BACKUP_PATH=/mnt/hdd/backups
EOF

# Create README.md
cat > README.md << 'EOF'
# Nomaan Solution - Business Infrastructure
## Quick Start
1. Run ./scripts/setup_ubuntu.sh
2. Configure .env file
3. Build website: cd website && ./build.sh
4. Deploy: ./scripts/deploy_hostinger_ssh.sh
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
.env
.env.local
*.key
*.log
node_modules/
website/dist/*
backups/*.tar.gz
EOF

echo -e "${GREEN}✓ Project structure created successfully!${NC}"
echo -e "${YELLOW}Next: Copy .env.example to .env and configure${NC}"
