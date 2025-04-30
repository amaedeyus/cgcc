// ===== 1. Load environment variables FIRST =====
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, 'backend/.env') });

// Debug check
console.log('Server startup env check:', {
  PORT: process.env.PORT || 3000,
  GOOGLE_CLIENT_ID: process.env.GOOGLE_CLIENT_ID ? 'Loaded' : 'MISSING',
  GOOGLE_CLIENT_SECRET: process.env.GOOGLE_CLIENT_SECRET ? 'Loaded' : 'MISSING',
  SESSION_SECRET: process.env.SESSION_SECRET ? 'Loaded' : 'MISSING',
  NODE_ENV: process.env.NODE_ENV || 'development'
});


// ===== 2. Load dependencies =====
const express = require('express');
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const session = require('express-session');
const morgan = require('morgan');
const flash = require('connect-flash'); // For flash messages
const pool = require('./backend/config/dbconnect'); // This should export the `pool`

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

const allowedTestEmails = ['amybalion533@gmail.com', 'balionamaya01@gmail.com'];

passport.serializeUser((user, done) => {
  done(null, user);
});

passport.deserializeUser((obj, done) => {
  done(null, obj);
});

passport.use(new GoogleStrategy({
  clientID: process.env.GOOGLE_CLIENT_ID,
  clientSecret: process.env.GOOGLE_CLIENT_SECRET,
  callbackURL: "/auth/google/callback"
}, async (accessToken, refreshToken, profile, done) => {
  try {
    const email = profile.emails[0].value;

    if (!email.endsWith('@dlsl.edu.ph') && !allowedTestEmails.includes(email)) {
      return done(null, false, { message: 'Unauthorized email domain.' });
    }

    const connection = await pool.getConnection();
    const [rows] = await connection.execute(
      'SELECT id, email, type FROM users WHERE email = ?',
      [email]
    );
    connection.release();

    if (rows.length === 0) {
      return done(null, false, { message: 'User not found in database.' });
    }

    const user = rows[0];
    return done(null, {
      id: user.id,
      email: user.email,
      type: user.type,
      name: profile.displayName
    });
  } catch (err) {
    console.error('Error during Google auth:', err);
    return done(err);
  }
}));

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
  passport.authenticate('google', { 
    failureRedirect: '/login',
    successRedirect: '/dashboard',
    failureFlash: true
  })
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