#!/bin/bash

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}🔍 Checking server status...${NC}"
echo ""

# Check if frontend is running
if pgrep -f "react-scripts start" > /dev/null; then
    echo -e "${GREEN}✅ Frontend server (React) is running${NC}"
else
    echo -e "${RED}❌ Frontend server (React) is NOT running${NC}"
fi

# Check if backend is running
if pgrep -f "ts-node-dev" > /dev/null; then
    echo -e "${GREEN}✅ Backend server (Node.js) is running${NC}"
else
    echo -e "${RED}❌ Backend server (Node.js) is NOT running${NC}"
fi

echo ""
echo -e "${YELLOW}📡 Testing ports...${NC}"

# Test backend port
if curl -s http://localhost:5000/api/health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Port 5000 (Backend) is responding${NC}"
else
    echo -e "${RED}❌ Port 5000 (Backend) is NOT responding${NC}"
fi

# Test frontend port
if curl -s http://localhost:3000 > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Port 3000 (Frontend) is responding${NC}"
else
    echo -e "${RED}❌ Port 3000 (Frontend) is NOT responding${NC}"
fi

echo ""
echo -e "${YELLOW}💡 If servers are not running, execute: npm start${NC}"
