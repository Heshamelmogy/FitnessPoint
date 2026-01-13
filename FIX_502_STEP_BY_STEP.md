# Step-by-Step Fix for Persistent 502 Error

## If you're still getting 502 after ports are public:

### Step 1: Pull Latest Changes
```bash
git pull origin main
```

### Step 2: Stop Everything
Press `Ctrl+C` to stop all running servers

### Step 3: Create Client .env File
```bash
echo "HOST=0.0.0.0" > client/.env
echo "DANGEROUSLY_DISABLE_HOST_CHECK=true" >> client/.env
```

### Step 4: Restart Servers
```bash
npm start
```

### Step 5: Wait and Watch Terminal
Look for these messages:
- ✅ Backend: `🚀 Server is running on port 5000`
- ✅ Frontend: `Compiled successfully!`
- ✅ Frontend should show: `On Your Network: http://0.0.0.0:3000` (not just localhost)

### Step 6: Verify Port Forwarding
1. Go to **Ports** tab
2. Find port **3000**
3. **Right-click** → **Stop Forwarding**
4. **Right-click** → **Forward Port** → Enter `3000`
5. Make sure it's set to **Public** (🌐)
6. Click the port URL to open it

### Step 7: Test Direct Access
In a new terminal, test if the server is accessible:
```bash
curl http://localhost:3000
```
This should return HTML (not an error).

### Step 8: Check Browser
- Wait 60 seconds after "Compiled successfully!"
- Try hard refresh: `Ctrl+Shift+R` (or `Cmd+Shift+R` on Mac)
- Or try incognito/private window

## Alternative: Try Different Port

If port 3000 still doesn't work, try using a different port:

1. Stop servers (Ctrl+C)
2. Set a different port:
   ```bash
   echo "PORT=3001" > client/.env
   echo "HOST=0.0.0.0" >> client/.env
   echo "DANGEROUSLY_DISABLE_HOST_CHECK=true" >> client/.env
   ```
3. Start servers:
   ```bash
   PORT=3001 npm start
   ```
4. Forward port 3001 in Ports tab (make it Public)

## Still Not Working?

Check these:

1. **Codespace Resources**: Your Codespace might be out of memory
   - Try stopping and restarting the Codespace

2. **Check Terminal Output**: Look for any red error messages

3. **Test Backend**: 
   ```bash
   curl http://localhost:5000/api/health
   ```
   Should return JSON with status "ok"

4. **Check Process**:
   ```bash
   ps aux | grep "react-scripts"
   ```
   Should show the React process running

5. **Check Port Binding**:
   ```bash
   netstat -tuln | grep 3000
   ```
   Should show port 3000 listening on 0.0.0.0:3000 (not just 127.0.0.1:3000)
