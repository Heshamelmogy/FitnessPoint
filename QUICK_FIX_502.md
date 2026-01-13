# Quick Fix for 502 Error

## The Problem
You're getting a 502 error because the frontend server isn't running or hasn't finished compiling.

## Correct Way to Start Servers

### Option 1: Start Both Together (Recommended)
```bash
# From the root directory
npm start
```

This starts both frontend and backend automatically.

### Option 2: Start Separately

**Terminal 1 - Backend:**
```bash
cd server
npm run dev    # NOT "npm start" - that's for production
```

**Terminal 2 - Frontend:**
```bash
cd client
npm start
```

## Important Notes

- **`npm start`** in server/ = runs compiled code (needs `npm run build` first)
- **`npm run dev`** in server/ = runs TypeScript directly (what you want for development)
- **`npm start`** in client/ = starts React dev server (correct)

## Steps to Fix 502 Error

1. **Stop everything** (Ctrl+C in all terminals)

2. **Start from root:**
   ```bash
   npm start
   ```

3. **Wait for these messages:**
   - Backend: `🚀 Server is running on port 5000`
   - Frontend: `Compiled successfully!`

4. **Check Ports tab:**
   - Port 3000 must be **Public** (🌐 not 🔒)
   - Port 5000 must be **Public** (🌐 not 🔒)

5. **Wait 30-60 seconds** after "Compiled successfully!" appears

6. **Refresh your browser**

## If Frontend Still Shows 502

Check the terminal output for:
- ❌ Red error messages
- ❌ "Failed to compile"
- ✅ "Compiled successfully!" (must see this)

If you see errors, share them and we can fix them.
