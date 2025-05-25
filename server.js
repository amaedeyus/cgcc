// ===== 1. Load environment variables FIRST =====
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, 'backend/.env') });

// Debug check
console.log('Server startup env check:', {
  PORT: process.env.PORT || 3002,
  GOOGLE_CLIENT_ID: process.env.GOOGLE_CLIENT_ID ? 'Loaded' : 'MISSING',
  GOOGLE_CLIENT_SECRET: process.env.GOOGLE_CLIENT_SECRET ? 'Loaded' : 'MISSING',
  SESSION_SECRET: process.env.SESSION_SECRET ? 'Loaded' : 'MISSING',
  NODE_ENV: process.env.NODE_ENV || 'development'
});

// ===== 2. Load dependencies =====
const express = require('express');
const passport = require('passport');
const session = require('express-session');
const morgan = require('morgan');
const flash = require('connect-flash'); // For flash messages

// ===== 3. Initialize app =====
const app = express();

// ===== 4. Middleware Setup =====
// Logging
app.use(morgan('dev'));

// Static files
app.use('/Media', express.static(path.join(__dirname, 'Media')));
app.use(express.static(path.join(__dirname, 'public')));

// Body parsing
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Session configuration
app.use(session({
  secret: process.env.SESSION_SECRET || 'keyboard-cat',
  resave: false,
  saveUninitialized: false,
  cookie: { 
    secure: process.env.NODE_ENV === 'production',
    httpOnly: true,
    maxAge: 24 * 60 * 60 * 1000
  }
}));

// Flash messages (must come after session)
app.use(flash());

// Passport initialization
app.use(passport.initialize());
app.use(passport.session());

// ===== 5. Load auth config =====
require('./backend/config/auth');

// ===== 6. Routes =====
// Main route
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public/front-end.html'));
});

// Login route
app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, 'public/front-end.html'));
});

// Dashboard route (protected)
app.get('/dashboard', (req, res) => {
  if (!req.isAuthenticated()) {
    return res.redirect('/login');
  }
  res.sendFile(path.join(__dirname, 'public/main.html'));
});

// Dashboard route (protected)
app.get('/admin', (req, res) => {
  if (!req.isAuthenticated()) {
    return res.redirect('/login');
  }
  res.sendFile(path.join(__dirname, 'public/admin.html'));
});


// Form submission
app.post('/submit', (req, res) => {
  console.log('Form submitted:', req.body);
  res.json({ message: 'Login submitted!', data: req.body });
});

// Google OAuth routes
app.get('/auth/google',
  passport.authenticate('google', { 
    scope: ['profile', 'email'],
    prompt: 'select_account'
  })
);

// Google OAuth callback
app.get('/auth/google/callback',
  passport.authenticate('google', { failureRedirect: '/login', failureFlash: true }),
  (req, res) => {
    console.log('✅ Authenticated User:', req.user); // <== Add this

    if (!req.user || !req.user.userType) {
      console.warn('⚠️ No userType found on authenticated user.');
      return res.redirect('/login');
    }

    if (req.user.userType === 'admin') {
      return res.redirect('/admin');
    } else {
      return res.redirect('/dashboard');
    }
  }
);



// ===== 7. Error Handling =====
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});

// ===== 8. Server Start =====
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running in ${process.env.NODE_ENV || 'development'} mode`);
  console.log(`Listening on http://localhost:${PORT}`);
  console.log('Google OAuth configured:', !!process.env.GOOGLE_CLIENT_ID);
});