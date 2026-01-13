// Centralized API URL configuration
// In Codespaces, this will automatically use the forwarded port URL
// For local development, it defaults to localhost:5000

const getApiUrl = (): string => {
  // If REACT_APP_API_URL is explicitly set, use it
  if (process.env.REACT_APP_API_URL) {
    return process.env.REACT_APP_API_URL;
  }
  
  // Check if we're in Codespaces by looking at the hostname
  if (typeof window !== 'undefined') {
    const hostname = window.location.hostname;
    const protocol = window.location.protocol;
    const port = window.location.port;
    
    // If we're in Codespaces (github.dev or preview.app.github.dev)
    if (hostname.includes('github.dev') || hostname.includes('preview.app.github.dev')) {
      // In Codespaces, the backend runs on port 5000
      // Use the same hostname but with port 5000
      // Remove any existing port from hostname
      const baseHost = hostname.split(':')[0];
      return `${protocol}//${baseHost}:5000/api`;
    }
    
    // If accessing via a specific port (like in Codespaces port forwarding)
    // Try to detect if we're on port 3000 (React default) and backend is on 5000
    if (port === '3000' || port === '') {
      // We're likely in a development environment
      // Check if we can access the backend on the same host
      return `${protocol}//${hostname}:5000/api`;
    }
  }
  
  // Default to localhost for local development
  return 'http://localhost:5000/api';
};

export const API_URL = getApiUrl();

// Log the API URL in development for debugging
if (process.env.NODE_ENV === 'development') {
  console.log('🌐 API URL:', API_URL);
  console.log('📍 Current location:', typeof window !== 'undefined' ? window.location.href : 'server-side');
}
