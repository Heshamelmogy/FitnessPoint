# First Time Codespace Setup (After Creating New Codespace)

## ⚠️ IMPORTANT: If you just created a new Codespace

When you create a new Codespace, you need to do these steps ONCE:

### Step 1: Pull Latest Code
```bash
git pull origin main
```

### Step 2: Install Dependencies
```bash
npm run install-all
```

### Step 3: Create Client .env File
```bash
cat > client/.env << 'EOF'
HOST=0.0.0.0
DANGEROUSLY_DISABLE_HOST_CHECK=true
WDS_SOCKET_HOST=localhost
WDS_SOCKET_PORT=3000
BROWSER=none
EOF
```

### Step 4: Check Ports Tab
1. Open the **Ports** tab (bottom panel)
2. Find ports **3000** and **5000**
3. **Right-click each port** → **Port Visibility** → **Public**
4. Make sure both show 🌐 (not 🔒)

### Step 5: Start Servers
```bash
npm start
```

### Step 6: Wait and Verify
- Wait for "Compiled successfully!" message
- Check terminal shows: `On Your Network: http://0.0.0.0:3000`
- Wait 60 seconds
- Refresh browser

## Why This Happens

When you create a NEW Codespace:
- Ports default to **Private** (need to make them Public)
- The `.env` file might not exist yet
- Dependencies need to be installed

The `.devcontainer/devcontainer.json` should handle this automatically, but sometimes you need to do it manually the first time.

## Quick One-Liner Setup

```bash
git pull origin main && npm run install-all && echo "HOST=0.0.0.0" > client/.env && echo "DANGEROUSLY_DISABLE_HOST_CHECK=true" >> client/.env && echo "WDS_SOCKET_HOST=localhost" >> client/.env && echo "WDS_SOCKET_PORT=3000" >> client/.env && echo "BROWSER=none" >> client/.env && echo "✅ Setup complete! Now run: npm start"
```
