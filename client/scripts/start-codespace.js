// Custom start script for Codespaces
// This ensures React dev server binds to 0.0.0.0

process.env.HOST = '0.0.0.0';
process.env.BROWSER = 'none';
process.env.DANGEROUSLY_DISABLE_HOST_CHECK = 'true';
process.env.WDS_SOCKET_HOST = 'localhost';
process.env.WDS_SOCKET_PORT = '3000';

// Now start the actual React dev server
require('react-scripts/scripts/start');
