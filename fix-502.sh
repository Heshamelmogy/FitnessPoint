#!/bin/bash

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔧 Fixing 502 Error...${NC}"
echo ""

# Step 1: Create/verify client .env file
echo -e "${YELLOW}Step 1: Creating client .env file...${NC}"
mkdir -p client
cat > client/.env << 'EOF'
HOST=0.0.0.0
DANGEROUSLY_DISABLE_HOST_CHECK=true
WDS_SOCKET_HOST=localhost
WDS_SOCKET_PORT=3000
EOF
echo -e "${GREEN}✅ client/.env file created${NC}"
cat client/.env
echo ""

# Step 2: Kill any existing processes
echo -e "${YELLOW}Step 2: Stopping any running servers...${NC}"
pkill -f "react-scripts" 2>/dev/null
pkill -f "ts-node-dev" 2>/dev/null
sleep 2
echo -e "${GREEN}✅ Processes stopped${NC}"
echo ""

# Step 3: Verify ports are available
echo -e "${YELLOW}Step 3: Checking ports...${NC}"
if lsof -i :3000 2>/dev/null | grep -q LISTEN; then
    echo -e "${RED}⚠️  Port 3000 is still in use${NC}"
    lsof -i :3000
else
    echo -e "${GREEN}✅ Port 3000 is available${NC}"
fi

if lsof -i :5000 2>/dev/null | grep -q LISTEN; then
    echo -e "${RED}⚠️  Port 5000 is still in use${NC}"
    lsof -i :5000
else
    echo -e "${GREEN}✅ Port 5000 is available${NC}"
fi
echo ""

# Step 4: Instructions
echo -e "${BLUE}📋 Next Steps:${NC}"
echo -e "${YELLOW}1. Make sure ports 3000 and 5000 are PUBLIC in the Ports tab${NC}"
echo -e "${YELLOW}2. Run: npm start${NC}"
echo -e "${YELLOW}3. Wait for 'Compiled successfully!' message${NC}"
echo -e "${YELLOW}4. Check terminal - frontend should show: 'On Your Network: http://0.0.0.0:3000'${NC}"
echo -e "${YELLOW}5. Wait 60 seconds, then refresh browser${NC}"
echo ""
echo -e "${BLUE}💡 If still not working, test locally:${NC}"
echo -e "${YELLOW}   curl http://localhost:3000${NC}"
