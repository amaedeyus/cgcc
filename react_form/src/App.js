import React from 'react';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
import QuestionBuilder from './QuestionBuilder';
import './App.css';


function App() {
  return (
    <div className='container mt-5'>
      <Router>
        <nav>
          <ul>
            <li>
              <Link to="/QuestionBuilder">QuestionBuilder</Link>
            </li>
          </ul>
        </nav>

        <Routes>
          <Route path="/QuestionBuilder" element={<QuestionBuilder />} />
          <Route path="/edit-form/:id" element={<QuestionBuilder />} />
        </Routes>
      </Router>
  </div>
    
  );
}

export default App;