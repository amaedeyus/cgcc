import React, {useState, useRef, useEffect} from 'react';
import {Button, Form, Card, Row, Col, Table} from 'react-bootstrap';
import {FaTrash, FaPlus, FaEdit, FaGripVertical} from 'react-icons/fa';
import {DragDropContext, Droppable, Draggable} from '@hello-pangea/dnd';
import { useParams } from 'react-router-dom';
import './App.css';


const API_BASE_URL = 'http://localhost/cgcc-system/backend/forms';

const QuestionBuilder = () => {
  const { id } = useParams(); // Get form ID from URL
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = () => {
    if (!validateForm()) return ;
  
    // Submit logic here
    console.log("Form is valid, submitting...");
    
  };

  useEffect(() => {
    console.log("Form ID:", id); // Add this above if (!id) return;
    if (!id) return; // Skip if not editing
  
    const loadForm = async () => {
      setIsLoading(true);
      try {
        const response = await fetch(`${API_BASE_URL}/get_form.php?id=${id}`);
        if (!response.ok) throw new Error('Failed to fetch form');
        
        const data = await response.json();
  
        // Set title and description
        setFormInfo({
          title: data.form_name,
          description: data.description,
        });
  
        // Format questions to match our state structure
        const formattedQuestions = data.questions.map((q) => ({
          id: String(q.main_question_index),
          question: q.main_question_text,
          type: q.type_name,
          options: q.options || [],  // keep full choice objects
          rows: q.rows || [],
          required: !!q.is_required,
          isEditing: false,
        }));

        console.log(formattedQuestions);
  
        setQuestions(formattedQuestions);
  
      } catch (error) {
        console.error('Error loading form:', error);
        alert('Could not load form for editing.');
      } finally {
        setIsLoading(false);
      }
    };
  
    loadForm();
  }, [id]);

  const createForm = async () => {
    // Basic validation
    if (!formInfo.title.trim()) {
      alert('Please enter a form title');
      return;
    }
  
    if (questions.length === 0) {
      alert('Please add at least one question');
      return;
    }
  
    // Validate all questions have content
    const emptyQuestions = questions.some(q => !q.question.trim());
    if (emptyQuestions) {
      alert('All questions must have content');
      return;
    }

    // Determine if we are creating or updating
    const method = id ? 'PUT' : 'POST';
    const url = id 
      ? `${API_BASE_URL}/update.php?id=${id}` 
      : `${API_BASE_URL}/create.php`;

  // Prepare the form data for submission
  const formData = {
    title: formInfo.title?.trim() || '',
    description: formInfo.description?.trim() || '',
    questions: questions.map(q => ({
      question: q.question?.trim() || '',
      type: q.type,
      required: q.required, // Ensure the required field is part of the payload
      options: (q.options || [])
      .map(opt => typeof opt === 'string' ? opt.trim() : (opt?.choice_text || '').trim())
      .filter(text => text),
      rows: (q.rows || []).filter(row => row?.trim()).map(row => row?.trim() || '')
    })),
    createdAt: new Date().toISOString(),
  };
    
    handleSubmit();
  
    try {
      const response = await submitFormToBackend(formData, method, url); // ✅ Pass method and URL
      alert(`Form ${id ? 'updated' : 'created'} successfully! ID: ${response.id}`);
    } catch (error) {
      console.error('Error creating form:', error);
      alert('Failed to create form. Please try again.');
    }
  };
  
  // Mock function to simulate API call
  const submitFormToBackend = async (formData, method, url) => {
    const response = await fetch(url, {
      method,
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        title: formData.title,
        description: formData.description,
        questions: formData.questions.map(q => ({
          question: q.question,
          type: q.type,
          required: q.required,
          options: q.options,
          rows: q.rows
        }))
      }),
      credentials: 'omit'
    });
  
    if (!response.ok) {
      throw new Error(`Failed to ${method === 'POST' ? 'create' : 'update'} form`);
    }
  
    return response.json();
  };
  
  const [formInfo, setFormInfo] = useState({
    title: '',
    description: ''
  });

  const [questions, setQuestions] = useState([
    {
      id: '1',
      question: '',
      type: 'short',
      options: [''],
      rows: [''],
      isEditing: false,
      required: false,
    },
  ]);
  const formRef = useRef(null);

  // Close all questions when clicking outside
  useEffect(() => {
  
    const handleClickOutside = (event) => {
      if (formRef.current && !formRef.current.contains(event.target)) {
        setQuestions(questions.map((q) => ({...q, isEditing: false})));
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [questions]);

  const onDragEnd = (result) => {
    if (!result.destination) return;

    const items = Array.from(questions);
    const [reorderedItem] = items.splice(result.source.index, 1);
    items.splice(result.destination.index, 0, reorderedItem);

    setQuestions(items);
  };

  const toggleEdit = (id) => {
    setQuestions(
      questions.map(
        (q) =>
          q.id === id
            ? {...q, isEditing: true} // Only set the clicked question to editing mode
            : {...q, isEditing: false} // All others should be in preview mode
      )
    );
  };
  const toggleRequired = (questionId) => {
    setQuestions((prevQuestions) =>
      prevQuestions.map((q) =>
        q.id === questionId
          ? { ...q, required: !q.required } // Toggle boolean
          : q
      )
    );
  };

  const handleQuestionChange = (id, value) => {
    setQuestions(questions.map((q) => (q.id === id ? {...q, question: value} : q)));
  };

  const handleFormInfoChange = (field, value) => {
    setFormInfo(prev => ({...prev, [field]: value}));
  };


  const handleTypeChange = (id, newType) => {
    setQuestions(
      questions.map((q) => {
        if (q.id !== id) return q;

        const compatibleTypes = ['multiple', 'checkbox', 'dropdown', 'grid'];
        const isCompatibleChange = compatibleTypes.includes(q.type) && compatibleTypes.includes(newType);

        return {
          ...q,
          type: newType,
          // Retain options if switching between compatible types
          options: isCompatibleChange ? q.options : compatibleTypes.includes(newType) ? [''] : [],
          // Only keep rows if new type is grid
          rows: newType === 'grid' ? (q.type === 'grid' ? q.rows : ['']) : [],
        };
      })
    );
  };

  const handleOptionChange = (qid, idx, value) => {
    setQuestions(
      questions.map((q) =>
        q.id === qid
          ? {
              ...q,
              options: q.options.map((opt, i) => (i === idx ? value : opt)),
            }
          : q
      )
    );
  };

  const handleRowChange = (qid, idx, value) => {
    setQuestions(
      questions.map((q) =>
        q.id === qid
          ? {
              ...q,
              rows: q.rows.map((row, i) => (i === idx ? value : row)),
            }
          : q
      )
    );
  };

  const addOption = (qid) => {
    setQuestions(questions.map((q) => (q.id === qid ? {...q, options: [...q.options, '']} : q)));
  };

  const addRow = (qid) => {
    setQuestions(questions.map((q) => (q.id === qid ? {...q, rows: [...q.rows, '']} : q)));
  };

  const removeOption = (qid, idx) => {
    setQuestions(
      questions.map((q) =>
        q.id === qid
          ? {
              ...q,
              options: q.options.filter((_, i) => i !== idx),
            }
          : q
      )
    );
  };

  const removeRow = (qid, idx) => {
    setQuestions(
      questions.map((q) =>
        q.id === qid
          ? {
              ...q,
              rows: q.rows.filter((_, i) => i !== idx),
            }
          : q
      )
    );
  };

  const addQuestion = () => {
    const newId = String(questions.length > 0 ? Math.max(...questions.map((q) => parseInt(q.id))) + 1 : 1);
    setQuestions([
      ...questions,
      {
        id: newId,
        question: '',
        type: 'short',
        options: [''],
        rows: [''],
        isEditing: true,
      },
    ]);
  };

  const deleteQuestion = (id) => {
    setQuestions(questions.filter((q) => q.id !== id));
  };

  const [validationError, setValidationError] = useState('');

  const validateForm = () => {
    for (let i = 0; i < questions.length; i++) {
      const q = questions[i];
      if (!q.question || q.question.trim() === '') {
        setValidationError(`Question ${i + 1} is empty.`);
        return false;
      }
  
      if (['multiple', 'checkbox', 'dropdown'].includes(q.type)) {
        if (
          !q.options ||
          q.options.length === 0 ||
          q.options.some(opt => {
            const text = typeof opt === 'string' ? opt : opt?.choice_text;
            return !text || text.trim() === '';
          })
        ) {
          setValidationError(`Question ${i + 1} has empty choices.`);
          return false;
        }
      }
  
      if (q.type === 'grid') {
        if (
          !q.rows ||
          q.rows.length === 0 ||
          q.rows.some(row => !row || row.trim() === '')
        ) {
          setValidationError(`Question ${i + 1} has empty rows.`);
          return false;
        }
  
        if (
          !q.options ||
          q.options.length === 0 ||
          q.options.some(opt => !opt || (opt.choice_text ?? opt).trim() === '')
        ) {
          setValidationError(`Question ${i + 1} has empty columns.`);
          return false;
        }
      }
    }
  
    return true;
  };
  

  return (
    <Form ref={formRef}>
      <Card className="mb-3">
        <Card.Body>
          <div className="d-flex align-items-start">
            <div style={{flex: 1}}>
              <Form.Group className="mb-3">
                <Form.Label>Form Title</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="Enter form title"
                  value={formInfo.title ?? ''}
                  onChange={(e) => handleFormInfoChange('title', e.target.value)}
                />
              </Form.Group>
              
              <Form.Group className="mb-3">
                <Form.Label>Form Description</Form.Label>
                <Form.Control
                  as="textarea"
                  rows={3}
                  placeholder="Enter form description"
                  value={formInfo.description ?? ''}
                  onChange={(e) => handleFormInfoChange('description', e.target.value)}
                />
              </Form.Group>
            </div>
          </div>
        </Card.Body>
      </Card>
      <DragDropContext onDragEnd={onDragEnd}>
        <Droppable droppableId="questions">
          {(provided) => (
            <div {...provided.droppableProps} ref={provided.innerRef}>
              {questions.map((q, index) => (
                <Draggable key={q.id} draggableId={q.id} index={index}>
                  {(provided) => (
                    <div ref={provided.innerRef} {...provided.draggableProps}>
                      <Card className="mb-3" onClick={() => !q.isEditing && toggleEdit(q.id)}>
                        <Card.Body>
                          <div className="d-flex align-items-start">
                            <div className="me-2 mt-1" style={{cursor: 'grab'}} {...provided.dragHandleProps}>
                              <FaGripVertical />
                            </div>
                            <div style={{flex: 1}}>
                              {q.isEditing ? (
                                <>
                                  <div className="d-flex justify-content-between align-items-center mb-2">
                                    <Form.Label>Question {index + 1}</Form.Label>
                                    <div>
                                      
                                      <Button
                                        variant="outline-danger"
                                        size="sm"
                                        className="me-2"
                                        onClick={(e) => {
                                          e.stopPropagation();
                                          deleteQuestion(q.id);
                                        }}>
                                        Delete
                                      </Button>
                                      <Button
                                        variant="outline-secondary"
                                        size="sm"
                                        onClick={(e) => {
                                          e.stopPropagation();
                                          toggleEdit(q.id);
                                        }}>
                                        Preview
                                      </Button>
                                    </div>
                                  </div>

                                  <Form.Group className="mb-2">
                                    <Form.Control
                                      type="text"
                                      placeholder="Enter your question"
                                      value={q.question ?? ''}
                                      onChange={(e) => handleQuestionChange(q.id, e.target.value)}
                                    />
                                  </Form.Group>

                                  <Form.Group as={Row} className="mb-2">
                                    <Form.Label column sm={2}>
                                      Type
                                    </Form.Label>
                                    <Col sm={10}>
                                      <Form.Select
                                        value={q.type ?? ''}
                                        onChange={(e) => handleTypeChange(q.id, e.target.value)}>
                                        <option value="short">Short Answer</option>
                                        <option value="paragraph">Paragraph</option>
                                        <option value="multiple">Multiple Choice</option>
                                        <option value="checkbox">Checkboxes</option>
                                        <option value="dropdown">Dropdown</option>
                                        <option value="grid">Multiple Choice Grid</option>
                                        <option value="date">Date</option>
                                      </Form.Select>
                                    </Col>
                                  </Form.Group>

                                  {q.type === 'short' && (
                                    <Form.Control type="text" placeholder="Short answer text" disabled />
                                  )}

                                  {q.type === 'paragraph' && (
                                    <Form.Control as="textarea" placeholder="Long answer text" disabled rows={3} />
                                  )}

                                  {(q.type === 'multiple' || q.type === 'checkbox') && (
                                    <>
                                      {q.options.map((opt, idx) => (
                                        <Form.Group key={idx} className="mb-2 d-flex align-items-center">
                                          <Form.Check
                                            type={q.type === 'multiple' ? 'radio' : 'checkbox'}
                                            disabled
                                            className="me-2"
                                          />
                                          <Form.Control
                                            type="text"
                                            placeholder={`Option ${idx + 1}`}
                                            value={opt?.choice_text ?? opt ?? ''}
                                            onChange={(e) => handleOptionChange(q.id, idx, e.target.value)}
                                          />
                                          {q.options.length > 1 && (
                                            <Button
                                              variant="outline-danger"
                                              className="ms-2"
                                              onClick={(e) => {
                                                e.stopPropagation();
                                                removeOption(q.id, idx);
                                              }}>
                                              <FaTrash />
                                            </Button>
                                          )}
                                        </Form.Group>
                                      ))}
                                      <Button
                                        variant="outline-primary"
                                        onClick={(e) => {
                                          e.stopPropagation();
                                          addOption(q.id);
                                        }}
                                        className="mt-2">
                                        <FaPlus className="me-1" />
                                        Add Option
                                      </Button>
                                    </>
                                  )}

                                  {q.type === 'grid' && (
                                    <>
                                      <h6 className="mt-3">Rows</h6>
                                      {q.rows.map((row, idx) => (
                                        <Form.Group key={`row-${idx}`} className="mb-2 d-flex align-items-center">
                                          <Form.Control
                                            type="text"
                                            placeholder={`Question ${idx + 1}`}
                                            value={row ?? ''}
                                            onChange={(e) => handleRowChange(q.id, idx, e.target.value)}
                                          />
                                          {q.rows.length > 1 && (
                                            <Button
                                              variant="outline-danger"
                                              className="ms-2"
                                              onClick={(e) => {
                                                e.stopPropagation();
                                                removeRow(q.id, idx);
                                              }}>
                                              <FaTrash />
                                            </Button>
                                          )}
                                        </Form.Group>
                                      ))}
                                      <Button
                                        variant="outline-primary"
                                        onClick={(e) => {
                                          e.stopPropagation();
                                          addRow(q.id);
                                        }}
                                        className="mt-2 mb-3">
                                        <FaPlus className="me-1" />
                                        Add Question
                                      </Button>

                                      <h6>Columns</h6>
                                      {q.options.map((opt, idx) => (
                                        <Form.Group key={`col-${idx}`} className="mb-2 d-flex align-items-center">
                                          <Form.Control
                                            type="text"
                                            placeholder={`Option ${idx + 1}`}
                                            value={opt?.choice_text ?? opt ?? ''}
                                            onChange={(e) => handleOptionChange(q.id, idx, e.target.value)}
                                          />
                                          {q.options.length > 1 && (
                                            <Button
                                              variant="outline-danger"
                                              className="ms-2"
                                              onClick={(e) => {
                                                e.stopPropagation();
                                                removeOption(q.id, idx);
                                              }}>
                                              <FaTrash />
                                            </Button>
                                          )}
                                        </Form.Group>
                                      ))}
                                      <Button
                                        variant="outline-primary"
                                        onClick={(e) => {
                                          e.stopPropagation();
                                          addOption(q.id);
                                        }}
                                        className="mt-2">
                                        <FaPlus className="me-1" />
                                        Add Option
                                      </Button>
                                    </>
                                  )}

                                  {q.type === 'dropdown' && (
                                    <>
                                      {q.options.map((opt, idx) => (
                                        <Form.Group key={idx} className="mb-2 d-flex align-items-center">
                                          <Form.Control
                                            type="text"
                                            placeholder={`Option ${idx + 1}`}
                                            value={opt?.choice_text ?? opt ?? ''}
                                            onChange={(e) => handleOptionChange(q.id, idx, e.target.value)}
                                          />
                                          {q.options.length > 1 && (
                                            <Button
                                              variant="outline-danger"
                                              className="ms-2"
                                              onClick={(e) => {
                                                e.stopPropagation();
                                                removeOption(q.id, idx);
                                              }}>
                                              <FaTrash />
                                            </Button>
                                          )}
                                        </Form.Group>
                                      ))}
                                      <Button
                                        variant="outline-primary"
                                        onClick={(e) => {
                                          e.stopPropagation();
                                          addOption(q.id);
                                        }}
                                        className="mt-2">
                                        <FaPlus className="me-1" />
                                        Add Option
                                      </Button>
                                    </>
                                  )}
                                  {q.type === 'date' && <Form.Control type="date" disabled />}
                                  <Form.Check
                                    type="switch"
                                    id={`required-switch-${q.id}`}
                                    label="Required"
                                    checked={q.required}                                    onChange={(e) => {
                                      e.stopPropagation();
                                      toggleRequired(q.id); // Call the toggle function
                                    }}
                                    className="mt-3 me-2"
                                  />
                                </>
                              ) : (
                                <>
                                  <div className="d-flex justify-content-between align-items-center mb-2">
                                    <h5>{q.question || 'Untitled Question'}</h5>
                                    <div>
                                      <Button
                                        variant="outline-danger"
                                        size="sm"
                                        className="me-2"
                                        onClick={(e) => {
                                          e.stopPropagation();
                                          deleteQuestion(q.id);
                                        }}>
                                        Delete
                                      </Button>
                                      <Button
                                        variant="outline-secondary"
                                        size="sm"
                                        onClick={(e) => {
                                          e.stopPropagation();
                                          toggleEdit(q.id);
                                        }}>
                                        <FaEdit className="me-1" />
                                        Edit
                                      </Button>
                                    </div>
                                  </div>

                                  {q.type === 'short' && <Form.Control type="text" placeholder="Your answer" />}

                                  {q.type === 'paragraph' && (
                                    <Form.Control as="textarea" placeholder="Your answer" rows={3} />
                                  )}

                                  {(q.type === 'multiple' || q.type === 'checkbox') && (
                                    <Form.Group>
                                      {q.options.map((opt, idx) => (
                                        <Form.Check
                                          key={idx}
                                          type={q.type === 'multiple' ? 'radio' : 'checkbox'}
                                          label={(opt?.choice_text ?? opt) || `Option ${idx + 1}`}
                                          name={`question-${q.id}`}
                                          id={`question-${q.id}-option-${idx}`}
                                          className="mb-2"
                                        />
                                      ))}
                                    </Form.Group>
                                  )}

                                  {q.type === 'grid' && (
                                    <Table bordered>
                                      <thead>
                                        <tr>
                                          <th></th>
                                          {q.options.map((opt, idx) => (
                                            <th key={`col-${idx}`} className="text-center">
                                              {(opt?.choice_text ?? opt) || `Option ${idx + 1}`}
                                            </th>
                                          ))}
                                        </tr>
                                      </thead>
                                      <tbody>
                                        {q.rows.map((row, rowIdx) => (
                                          <tr key={`row-${rowIdx}`}>
                                            <td>{row || `Question ${rowIdx + 1}`}</td>
                                            {q.options.map((_, colIdx) => (
                                              <td key={`cell-${rowIdx}-${colIdx}`} className="text-center">
                                                <Form.Check type="radio" name={`question-${q.id}-row-${rowIdx}`} />
                                              </td>
                                            ))}
                                          </tr>
                                        ))}
                                      </tbody>
                                    </Table>
                                  )}
                                  {q.type === 'dropdown' && (
                                    <Form.Select>
                                      <option value="">Select an option</option>
                                      {q.options.map((opt, idx) => (
                                        <option key={idx} value={opt?.choice_text ?? opt ?? ''}>
                                          {(opt?.choice_text ?? opt) || `Option ${idx + 1}`}
                                        </option>
                                      ))}
                                    </Form.Select>
                                  )}
                                  {q.type === 'date' && <Form.Control type="date" />}
                                </>
                              )}
                            </div>
                          </div>
                        </Card.Body>
                      </Card>
                    </div>
                  )}
                </Draggable>
              ))}
              {provided.placeholder}
            </div>
          )}
        </Droppable>
      </DragDropContext>
      <div className="d-flex justify-content-end gap-2 mt-3">
        <Button variant="success" onClick={addQuestion}>
          Add Question
        </Button>
        <Button variant="primary" onClick={createForm}>
          {id ? 'Save Changes' : 'Create Form'}
        </Button>
      </div>
    </Form>
  );
};

export default QuestionBuilder;
