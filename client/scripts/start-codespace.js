// Custom start script for Codespaces
// This ensures React dev server binds to 0.0.0.0

// Set all required environment variables BEFORE requiring react-scripts
process.env.HOST = process.env.HOST || '0.0.0.0';
process.env.BROWSER = process.env.BROWSER || 'none';
process.env.DANGEROUSLY_DISABLE_HOST_CHECK = process.env.DANGEROUSLY_DISABLE_HOST_CHECK || 'true';
process.env.WDS_SOCKET_HOST = process.env.WDS_SOCKET_HOST || 'localhost';
process.env.WDS_SOCKET_PORT = process.env.WDS_SOCKET_PORT || '3000';

console.log('🔧 Codespace configuration:');
console.log('   HOST:', process.env.HOST);
console.log('   DANGEROUSLY_DISABLE_HOST_CHECK:', process.env.DANGEROUSLY_DISABLE_HOST_CHECK);
console.log('');

// Now start the actual React dev server
require('react-scripts/scripts/start');
