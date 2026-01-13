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
    
    // If we're in Codespaces (app.github.dev or preview.app.github.dev)
    // Each port gets its own subdomain: -3000.app.github.dev, -5000.app.github.dev
    if (hostname.includes('.app.github.dev') || hostname.includes('preview.app.github.dev')) {
      // Extract the base part before the port number
      // Example: expert-space-train-4jj76wxj97jxh57qq-3000.app.github.dev
      // Should become: expert-space-train-4jj76wxj97jxh57qq-5000.app.github.dev
      const baseMatch = hostname.match(/^(.+?)-(\d+)\.(.+)$/);
      if (baseMatch) {
        const [, baseName, , domain] = baseMatch;
        // Replace the port number with 5000 for the backend
        const backendHost = `${baseName}-5000.${domain}`;
        return `${protocol}//${backendHost}/api`;
      }
      
      // Fallback: try to replace -3000 with -5000
      if (hostname.includes('-3000')) {
        const backendHost = hostname.replace('-3000', '-5000');
        return `${protocol}//${backendHost}/api`;
      }
    }
    
    // If we're on localhost or regular domain, use port 5000
    if (hostname === 'localhost' || hostname === '127.0.0.1') {
      return 'http://localhost:5000/api';
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
