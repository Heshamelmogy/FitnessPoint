#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🚀 Starting FitnessPoint...${NC}"

# Check if node_modules exist, if not install dependencies
if [ ! -d "node_modules" ] || [ ! -d "server/node_modules" ] || [ ! -d "client/node_modules" ]; then
    echo -e "${YELLOW}📦 Installing dependencies...${NC}"
    npm run install-all
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Failed to install dependencies${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ Dependencies installed!${NC}"
else
    echo -e "${GREEN}✅ Dependencies already installed${NC}"
fi

# Create .env file if it doesn't exist
if [ ! -f "server/.env" ]; then
    echo -e "${YELLOW}📝 Creating .env file...${NC}"
    echo "PORT=5000" > server/.env
    echo "JWT_SECRET=$(openssl rand -base64 32 2>/dev/null || echo 'your-secret-key-change-in-production')" >> server/.env
    echo -e "${GREEN}✅ .env file created!${NC}"
fi

# Create client .env file for Codespaces - CRITICAL for port forwarding
echo -e "${YELLOW}📝 Ensuring client .env is configured...${NC}"
mkdir -p client
cat > client/.env << 'ENVEOF'
HOST=0.0.0.0
DANGEROUSLY_DISABLE_HOST_CHECK=true
WDS_SOCKET_HOST=localhost
WDS_SOCKET_PORT=3000
BROWSER=none
ENVEOF
echo -e "${GREEN}✅ Client .env configured!${NC}"

# Check if we're in Codespaces
if [ -n "$CODESPACE_NAME" ]; then
    echo -e "${BLUE}🔗 Codespace detected: $CODESPACE_NAME${NC}"
    echo -e "${YELLOW}📌 CRITICAL: Make sure ports 3000 and 5000 are PUBLIC in Ports tab${NC}"
    echo -e "${YELLOW}   Right-click each port → Port Visibility → Public${NC}"
    echo ""
fi

# Start the development servers
echo -e "${GREEN}🎉 Starting development servers...${NC}"
echo -e "${YELLOW}   Backend: http://localhost:5000${NC}"
echo -e "${YELLOW}   Frontend: http://localhost:3000${NC}"
echo ""

# Export environment variables for React (Codespaces needs this)
export HOST=0.0.0.0
export DANGEROUSLY_DISABLE_HOST_CHECK=true
export BROWSER=none
export WDS_SOCKET_HOST=localhost
export WDS_SOCKET_PORT=3000

# Start servers
npm run dev
