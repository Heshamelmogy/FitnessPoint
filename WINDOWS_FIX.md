# Windows Compatibility Fix

## Issue
The `HOST=0.0.0.0` syntax doesn't work in Windows PowerShell. This is a Linux/Mac syntax.

## Solution for Windows

### Option 1: Use the .env file (Recommended)

Create `client/.env` file:
```powershell
echo HOST=0.0.0.0 > client\.env
echo DANGEROUSLY_DISABLE_HOST_CHECK=true >> client\.env
```

Then just run:
```powershell
npm start
```

### Option 2: Use PowerShell environment variable syntax

For Windows PowerShell:
```powershell
$env:HOST="0.0.0.0"
cd client
npm start
```

### Option 3: Use Git Bash or WSL

If you have Git Bash or WSL, the Linux syntax will work there.

## For Codespaces (Linux)

In Codespaces, the start.sh script will automatically set HOST=0.0.0.0, so you don't need to do anything special - just run `npm start`.
