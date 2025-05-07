import React, { useState, useEffect } from 'react';
import { Button, Form, Card, Row, Col } from 'react-bootstrap';
import { Link } from 'react-router-dom';

const Forms = () => {
  const [forms, setForms] = useState([]);

  useEffect(() => {
    fetch('http://localhost/cgcc-system/backend/forms/form.php')
      .then((response) => {
        if (!response.ok) {
          throw new Error('Failed to fetch forms');
        }
        return response.json();
      })
      .then((data) => setForms(data))
      .catch((error) => console.error('Error:', error));
  }, []);

  return (
    <div className="container mt-4">
      <h2>Available Forms</h2>
      <Row>
        {forms.map((form) => (
          <Col key={form.Form_ID} sm={12} md={6} lg={4} className="mb-4">
            <Link
              to={`/edit-form/${form.Form_ID}`}
              style={{ textDecoration: 'none', color: 'inherit' }}
            >
              <Card className="shadow-sm h-100 hover-card">
                <Card.Body>
                  <Card.Title>{form.Form_Name}</Card.Title>
                  <Card.Text>{form.Description}</Card.Text>
                </Card.Body>
              </Card>
            </Link>
          </Col>
        ))}
      </Row>
    </div>
  );
};

export default Forms;