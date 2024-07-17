import restart from 'vite-plugin-restart';
import glsl from 'vite-plugin-glsl';

const isCodeSandbox = !(
  'SANDBOX_URL' in process.env || 'CODESANDBOX_HOST' in process.env
);

export default {
  root: 'src/',
  publicDir: '../static/',

  server: {
    host: true, // Open to local network and display URL
    open: isCodeSandbox, // Open if it's not a CodeSandbox
  },

  build: {
    outDir: '../dist',
    emptyOutDir: true,
    sourcemap: true,
  },

  plugins: [
    // Restart server on static file change
    restart({ restart: ['../static/**'] }),
    glsl(), // Handle shader files
  ],
};
