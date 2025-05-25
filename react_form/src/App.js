import React from 'react';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
import QuestionBuilder from './QuestionBuilder';
<<<<<<< HEAD
=======
import Forms from './Forms';
>>>>>>> f957798264a8c19d14914c8f115e3792b6539854
import './App.css';


function App() {
  return (
    <div className='container mt-5'>
      <Router>
        <nav>
          <ul>
            <li>
<<<<<<< HEAD
=======
              <Link to="/">Forms</Link>
            </li>
            <li>
>>>>>>> f957798264a8c19d14914c8f115e3792b6539854
              <Link to="/QuestionBuilder">QuestionBuilder</Link>
            </li>
          </ul>
        </nav>

        <Routes>
<<<<<<< HEAD
=======
          <Route path="/" element={<Forms />} />
>>>>>>> f957798264a8c19d14914c8f115e3792b6539854
          <Route path="/QuestionBuilder" element={<QuestionBuilder />} />
          <Route path="/edit-form/:id" element={<QuestionBuilder />} />
        </Routes>
      </Router>
  </div>
    
  );
}

<<<<<<< HEAD
export default App;
=======
export default App;
>>>>>>> f957798264a8c19d14914c8f115e3792b6539854
