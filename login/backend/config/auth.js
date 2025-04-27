// Debug check at top
console.log('Auth config env check:', {
    GOOGLE_CLIENT_ID: process.env.GOOGLE_CLIENT_ID ? 'Loaded' : 'MISSING',
    GOOGLE_CLIENT_SECRET: process.env.GOOGLE_CLIENT_SECRET ? 'Loaded' : 'MISSING'
  });

console.log('Google Client ID:', process.env.GOOGLE_CLIENT_ID);  // Debug line



const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;

// Google Strategy
passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: '/auth/google/callback'
  },
  function(accessToken, refreshToken, profile, done) {
    console.log('Google profile:', profile);
    return done(null, profile);
  }
));

// Google OAuth callback
app.get('/auth/google/callback', 
    passport.authenticate('google', { failureRedirect: '/login' }),
    (req, res) => {
      // Successful authentication, redirect to main.html
      res.redirect('/main.html');  // Redirect user to main.html
    }
  );

passport.serializeUser((user, done) => {
  done(null, user);
});

passport.deserializeUser((obj, done) => {
  done(null, obj);
});
