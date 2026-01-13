#!/bin/bash

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔍 Diagnosing 502 Error...${NC}"
echo ""

# Check if processes are running
echo -e "${YELLOW}1. Checking running processes...${NC}"
if pgrep -f "react-scripts" > /dev/null; then
    echo -e "${GREEN}   ✅ React dev server process found${NC}"
    ps aux | grep "react-scripts" | grep -v grep | head -1
else
    echo -e "${RED}   ❌ React dev server process NOT found${NC}"
fi

if pgrep -f "ts-node-dev" > /dev/null; then
    echo -e "${GREEN}   ✅ Backend server process found${NC}"
    ps aux | grep "ts-node-dev" | grep -v grep | head -1
else
    echo -e "${RED}   ❌ Backend server process NOT found${NC}"
fi

echo ""

# Check if ports are listening
echo -e "${YELLOW}2. Checking if ports are listening...${NC}"
if netstat -tuln 2>/dev/null | grep -q ":3000"; then
    echo -e "${GREEN}   ✅ Port 3000 is listening${NC}"
    netstat -tuln 2>/dev/null | grep ":3000"
else
    echo -e "${RED}   ❌ Port 3000 is NOT listening${NC}"
fi

if netstat -tuln 2>/dev/null | grep -q ":5000"; then
    echo -e "${GREEN}   ✅ Port 5000 is listening${NC}"
    netstat -tuln 2>/dev/null | grep ":5000"
else
    echo -e "${RED}   ❌ Port 5000 is NOT listening${NC}"
fi

echo ""

# Test local connections
echo -e "${YELLOW}3. Testing local connections...${NC}"
if curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 | grep -q "200\|301\|302"; then
    echo -e "${GREEN}   ✅ Frontend (port 3000) is responding locally${NC}"
else
    echo -e "${RED}   ❌ Frontend (port 3000) is NOT responding locally${NC}"
    echo -e "${YELLOW}   Trying to connect...${NC}"
    curl -v http://localhost:3000 2>&1 | head -10
fi

if curl -s -o /dev/null -w "%{http_code}" http://localhost:5000/api/health | grep -q "200"; then
    echo -e "${GREEN}   ✅ Backend (port 5000) is responding locally${NC}"
else
    echo -e "${RED}   ❌ Backend (port 5000) is NOT responding locally${NC}"
fi

echo ""

# Check Codespace environment
echo -e "${YELLOW}4. Checking Codespace environment...${NC}"
if [ -n "$CODESPACE_NAME" ]; then
    echo -e "${GREEN}   ✅ Running in Codespace: $CODESPACE_NAME${NC}"
else
    echo -e "${YELLOW}   ⚠️  Not detected as Codespace${NC}"
fi

echo ""
echo -e "${YELLOW}5. Recommendations:${NC}"
echo -e "   • Check the Ports tab - make sure port 3000 is PUBLIC"
echo -e "   • Look at terminal output for compilation errors"
echo -e "   • Wait for 'Compiled successfully!' message"
echo -e "   • Try accessing: http://localhost:3000 directly in Codespace"
