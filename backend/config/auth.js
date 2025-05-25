const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const pool = require('./dbconnect'); // Adjust path if needed

// Load environment variables
require('dotenv').config();

// Define allowed test emails
const allowedTestEmails = ['amybalion533@gmail.com', 'balionamaya01@gmail.com'];

// Normalize emails once for comparison
const normalizedAllowedEmails = allowedTestEmails.map(email => email.toLowerCase());

passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: '/auth/google/callback'
  },
  async (accessToken, refreshToken, profile, done) => {
    try {
      const email = profile.emails[0]?.value.toLowerCase(); // Normalize email

      // Log what we're processing
      console.log('Google Profile:', { name: profile.displayName, email });

      // Check if email is authorized
      if (!email.endsWith('@dlsl.edu.ph') && !normalizedAllowedEmails.includes(email)) {
        console.log(`Unauthorized email: ${email}`);
        return done(null, false, { message: 'Unauthorized email domain.' });
      }

      // Check if user exists in the database
      const connection = await pool.getConnection();
      const [rows] = await connection.execute(
        'SELECT id, email, type FROM users WHERE LOWER(email) = ?',
        [email]
      );
      connection.release();

      if (rows.length === 0) {
        console.log(`User not found in DB: ${email}`);
        return done(null, false, { message: 'User not found in database.' });
      }

      // Attach user data from db + profile info
      const user = rows[0];
      return done(null, {
        id: user.id,
        email: user.email,
        userType: user.type,
        name: profile.displayName
      });

    } catch (err) {
      console.error('Error during Google auth:', err.message);
      return done(err);
    }
  }
));

// Serialization
passport.serializeUser((user, done) => {
  done(null, user);
});

passport.deserializeUser((user, done) => {
  done(null, user);
});

module.exports = passport;