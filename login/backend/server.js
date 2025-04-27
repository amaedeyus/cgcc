// ABSOLUTELY FIRST THING - Load environment variables
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') }); // Load from project root

// Debug check
console.log('Server startup env check:', {
  PORT: process.env.PORT,
  GOOGLE_CLIENT_ID: process.env.GOOGLE_CLIENT_ID ? 'Loaded' : 'MISSING',
  SESSION_SECRET: process.env.SESSION_SECRET ? 'Loaded' : 'MISSING'
});

// ===== 3. Now load other dependencies =====
const express = require('express');
const passport = require('passport');
const session = require('express-session');

// ===== 4. Initialize app =====
const app = express();

// Serve /Media properly
app.use('/Media', express.static(path.join(__dirname, '../../Media')));

// Serve login.css and front-end.html properly from /login
app.use(express.static(path.join(__dirname, '..')));

// Serve front-end.html on root "/"
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../front-end.html'));
});

// Parse form data
app.use(express.urlencoded({ extended: true }));

// ===== 5. Load auth config AFTER env vars are loaded =====
require('./config/auth');

// ===== Middleware =====
app.use(express.static(path.join(__dirname, '..'))); // Static files
app.use(express.urlencoded({ extended: true })); // Body parser

// Session middleware
app.use(session({
  secret: process.env.SESSION_SECRET || 'keyboard-cat', // Fixed default
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false } // Add for explicit settings
}));

// Passport middleware
app.use(passport.initialize());
app.use(passport.session());

// ===== Routes =====
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '../front-end.html'));
});

app.post('/submit', (req, res) => {
  console.log('Form submitted:', req.body);
  res.send('Login submitted!');
});

// Google OAuth routes
app.get('/auth/google',
  passport.authenticate('google', { 
    scope: ['profile', 'email'],
    prompt: 'select_account' // Optional: forces account selection
  })
);

// ===== Server Start =====
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
  console.log('Google OAuth configured:', !!process.env.GOOGLE_CLIENT_ID);
});