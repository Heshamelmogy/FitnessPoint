# Troubleshooting 502 Error in Codespaces

## What is a 502 Error?

A 502 Bad Gateway error means the frontend server (React dev server on port 3000) isn't running or isn't accessible.

## Quick Fixes

### 1. Check if Servers are Running

In your Codespace terminal, check if the servers are running:

```bash
# Check if processes are running
ps aux | grep node
```

You should see processes for:
- `react-scripts start` (frontend)
- `ts-node-dev` (backend)

### 2. Restart the Servers

If servers aren't running, restart them:

```bash
# Stop any running processes (Ctrl+C if needed)
# Then start again:
npm start
```

### 3. Check Port Forwarding

1. Go to the **Ports** tab in Codespace
2. Verify port **3000** is:
   - ✅ Forwarded (shows as active)
   - ✅ **Public** (not Private)
   - ✅ Shows the correct URL

### 4. Check Server Logs

Look at your terminal output for:
- ✅ "Compiled successfully!" (frontend)
- ✅ "Server is running on port 5000" (backend)
- ❌ Any error messages

### 5. Verify Ports are Accessible

Test if the ports are responding:

```bash
# Test backend
curl http://localhost:5000/api/health

# Test frontend (should return HTML)
curl http://localhost:3000
```

## Common Causes

1. **Servers stopped**: The `npm start` process was interrupted
2. **Port not forwarded**: Port 3000 isn't forwarded in Codespace
3. **Port is Private**: Port visibility is set to Private instead of Public
4. **Build failed**: Frontend compilation failed
5. **Out of memory**: Codespace ran out of resources

## Step-by-Step Recovery

1. **Stop everything**:
   ```bash
   # Press Ctrl+C in the terminal where npm start is running
   # Or kill processes:
   pkill -f "react-scripts"
   pkill -f "ts-node-dev"
   ```

2. **Check ports**:
   - Go to Ports tab
   - Make sure 3000 and 5000 are Public

3. **Restart**:
   ```bash
   npm start
   ```

4. **Wait for compilation**:
   - Frontend should show "Compiled successfully!"
   - Backend should show "Server is running on port 5000"

5. **Refresh browser**:
   - Wait 30-60 seconds after "Compiled successfully!"
   - Then refresh the page

## If Still Not Working

1. **Check Codespace resources**:
   - Codespace might be out of memory
   - Try stopping and restarting the Codespace

2. **Check for errors in terminal**:
   - Look for red error messages
   - Check if dependencies are installed

3. **Try manual start**:
   ```bash
   # Terminal 1 - Backend
   cd server
   npm run dev
   
   # Terminal 2 - Frontend  
   cd client
   npm start
   ```

4. **Check browser console**:
   - Open DevTools (F12)
   - Check Console tab for errors
   - Check Network tab for failed requests
