import React, { useState, useRef, useEffect } from 'react';
import { Button, Form, Card, Row, Col, Table } from 'react-bootstrap';
import { FaTrash, FaPlus, FaEdit, FaGripVertical } from 'react-icons/fa';
import { DragDropContext, Droppable, Draggable } from '@hello-pangea/dnd';
import { useParams } from 'react-router-dom';
import './App.css';

const API_BASE_URL = 'http://localhost/cgcc-system/backend/forms';

const QuestionBuilder = () => {
  const { id } = useParams();
  const [isLoading, setIsLoading] = useState(false);
  const formRef = useRef(null);

  const [formInfo, setFormInfo] = useState({
    title: '',
    description: ''
  });

  const [sections, setSections] = useState([
    {
      id: '1',
      title: 'Untitled Section',
      description: '',
      questions: [
        {
          id: '1',
          question: '',
          type: 'short',
          options: [''],
          rows: [''],
          isEditing: true,
          required: false,
        }
      ]
    }
  ]);

  // Load form data when editing
  useEffect(() => {
    console.log("Form ID:", id);
    if (!id) return;

    const loadForm = async () => {
      setIsLoading(true);
      try {
        const response = await fetch(`${API_BASE_URL}/get_form.php?id=${id}`);
        if (!response.ok) throw new Error('Failed to fetch form');
        
        const data = await response.json();
        console.log("API Response:", data);

        setFormInfo({
          title: data.form_name,
          description: data.description,
        });

       const formattedSections = data.sections.map(section => ({
        id: String(section.section_index),
        title: section.title, // or section.section_title if your PHP still returns that
        description: section.description, // or section.section_description
        questions: section.questions.map(q => ({
          id: String(q.id), // or q.main_question_index
          question: q.question,
          type: q.type,
          options: q.options || [],
          rows: q.rows || [],
          required: !!q.required,
          isEditing: false,
        }))
      }));


        console.log("Formatted Sections:", formattedSections);
        setSections(formattedSections);

      } catch (error) {
        console.error('Error loading form:', error);
        alert('Could not load form for editing.');
      } finally {
        setIsLoading(false);
      }
    };

    loadForm();
  }, [id]);

  // Close all questions when clicking outside
  useEffect(() => {
    const handleClickOutside = (event) => {
    if (formRef.current && !formRef.current.contains(event.target)) {
      setSections(sections.map(section => ({
        ...section,
        questions: section.questions.map(q => ({
          ...q,
          isEditing: false
        }))
      })));
    }
  };

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [sections]);

  // Handle drag and drop for questions within sections
  const onDragEnd = (result) => {
    if (!result.destination) return;

    const { source, destination } = result;
    const sourceSectionIndex = sections.findIndex(s => s.id === source.droppableId);
    const destSectionIndex = sections.findIndex(s => s.id === destination.droppableId);

    if (sourceSectionIndex === -1 || destSectionIndex === -1) return;

    const sourceSection = sections[sourceSectionIndex];
    const destSection = sections[destSectionIndex];

    // Moving within the same section
    if (source.droppableId === destination.droppableId) {
      const newQuestions = Array.from(sourceSection.questions);
      const [movedQuestion] = newQuestions.splice(source.index, 1);
      newQuestions.splice(destination.index, 0, movedQuestion);

      const newSections = [...sections];
      newSections[sourceSectionIndex] = {
        ...sourceSection,
        questions: newQuestions
      };

      setSections(newSections);
    } 
    // Moving between sections
    else {
      const sourceQuestions = Array.from(sourceSection.questions);
      const destQuestions = Array.from(destSection.questions);
      const [movedQuestion] = sourceQuestions.splice(source.index, 1);
      destQuestions.splice(destination.index, 0, movedQuestion);

      const newSections = [...sections];
      newSections[sourceSectionIndex] = {
        ...sourceSection,
        questions: sourceQuestions
      };
      newSections[destSectionIndex] = {
        ...destSection,
        questions: destQuestions
      };

      setSections(newSections);
    }
  };

  // Section management functions
  const addSection = () => {
    const newId = String(Math.max(0, ...sections.map(s => parseInt(s.id))) + 1);
    setSections([
      ...sections,
      {
        id: newId,
        title: 'New Section',
        description: '',
        questions: []
      }
    ]);
  };

  const deleteSection = (sectionId) => {
    if (sections.length <= 1) {
      alert('You must have at least one section');
      return;
    }
    setSections(sections.filter(s => s.id !== sectionId));
  };

  const updateSection = (sectionId, field, value) => {
    setSections(sections.map(section => 
      section.id === sectionId ? { ...section, [field]: value } : section
    ));
  };

  // Question management functions
  const addQuestionToSection = (sectionId) => {
    const newId = String(Date.now());
    setSections(sections.map(section => {
      if (section.id !== sectionId) return section;
      
      return {
        ...section,
        questions: [
          ...section.questions,
          {
            id: newId,
            question: '',
            type: 'short',
            options: [''],
            rows: [''],
            isEditing: true,
            required: false
          }
        ]
      };
    }));
  };

  const deleteQuestion = (sectionId, questionId) => {
    setSections(sections.map(section => {
      if (section.id !== sectionId) return section;
      
      return {
        ...section,
        questions: section.questions.filter(q => q.id !== questionId)
      };
    }));
  };

  const toggleEdit = (sectionId, questionId) => {
    setSections(sections.map(section => {
      if (section.id !== sectionId) return section;
      
      return {
        ...section,
        questions: section.questions.map(q => 
          q.id === questionId 
            ? { ...q, isEditing: true }
            : { ...q, isEditing: false }
        )
      };
    }));
  };

  const toggleRequired = (sectionId, questionId) => {
    setSections(sections.map(section => {
      if (section.id !== sectionId) return section;
      
      return {
        ...section,
        questions: section.questions.map(q => 
          q.id === questionId 
            ? { ...q, required: !q.required }
            : q
        )
      };
    }));
  };

  const handleQuestionChange = (sectionId, questionId, value) => {
    setSections(sections.map(section => {
      if (section.id !== sectionId) return section;
      
      return {
        ...section,
        questions: section.questions.map(q => 
          q.id === questionId ? { ...q, question: value } : q
        )
      };
    }));
  };

  const handleTypeChange = (sectionId, questionId, newType) => {
    setSections(sections.map(section => {
      if (section.id !== sectionId) return section;
      
      return {
        ...section,
        questions: section.questions.map(q => {
          if (q.id !== questionId) return q;

          const compatibleTypes = ['multiple', 'checkbox', 'dropdown', 'grid'];
          const isCompatibleChange = compatibleTypes.includes(q.type) && compatibleTypes.includes(newType);

          return {
            ...q,
            type: newType,
            options: isCompatibleChange ? q.options : compatibleTypes.includes(newType) ? [''] : [],
            rows: newType === 'grid' ? (q.type === 'grid' ? q.rows : ['']) : [],
          };
        })
      };
    }));
  };

  const handleOptionChange = (sectionId, questionId, idx, value) => {
    setSections(sections.map(section => {
      if (section.id !== sectionId) return section;
      
      return {
        ...section,
        questions: section.questions.map(q => {
          if (q.id !== questionId) return q;
          
          return {
            ...q,
            options: q.options.map((opt, i) => 
              i === idx ? value : opt
            )
          };
        })
      };
    }));
  };

  const handleRowChange = (sectionId, questionId, idx, value) => {
    setSections(sections.map(section => {
      if (section.id !== sectionId) return section;
      
      return {
        ...section,
        questions: section.questions.map(q => {
          if (q.id !== questionId) return q;
          
          return {
            ...q,
            rows: q.rows.map((row, i) => 
              i === idx ? value : row
            )
          };
        })
      };
    }));
  };

  const addOption = (sectionId, questionId) => {
    setSections(sections.map(section => {
      if (section.id !== sectionId) return section;
      
      return {
        ...section,
        questions: section.questions.map(q => {
          if (q.id !== questionId) return q;
          
          return {
            ...q,
            options: [...q.options, '']
          };
        })
      };
    }));
  };

  const addRow = (sectionId, questionId) => {
    setSections(sections.map(section => {
      if (section.id !== sectionId) return section;
      
      return {
        ...section,
        questions: section.questions.map(q => {
          if (q.id !== questionId) return q;
          
          return {
            ...q,
            rows: [...q.rows, '']
          };
        })
      };
    }));
  };

  const removeOption = (sectionId, questionId, idx) => {
    setSections(sections.map(section => {
      if (section.id !== sectionId) return section;
      
      return {
        ...section,
        questions: section.questions.map(q => {
          if (q.id !== questionId) return q;
          
          return {
            ...q,
            options: q.options.filter((_, i) => i !== idx)
          };
        })
      };
    }));
  };

  const removeRow = (sectionId, questionId, idx) => {
    setSections(sections.map(section => {
      if (section.id !== sectionId) return section;
      
      return {
        ...section,
        questions: section.questions.map(q => {
          if (q.id !== questionId) return q;
          
          return {
            ...q,
            rows: q.rows.filter((_, i) => i !== idx)
          };
        })
      };
    }));
  };

  // Form validation
  const validateForm = () => {
    if (!formInfo.title.trim()) {
      alert('Please enter a form title');
      return false;
    }

    let hasQuestions = false;
    
    for (const section of sections) {
      if (section.questions.length > 0) {
        hasQuestions = true;
        break;
      }
    }

    if (!hasQuestions) {
      alert('Please add at least one question');
      return false;
    }

    for (const section of sections) {
      for (const [i, q] of section.questions.entries()) {
        if (!q.question.trim()) {
          alert(`Question ${i + 1} in section "${section.title}" is empty`);
          return false;
        }

        if (['multiple', 'checkbox', 'dropdown'].includes(q.type)) {
          if (!q.options || q.options.length === 0 || q.options.some(opt => {
            const text = typeof opt === 'string' ? opt : opt?.choice_text;
            return !text || text.trim() === '';
          })) {
            alert(`Question ${i + 1} in section "${section.title}" has empty choices`);
            return false;
          }
        }

        if (q.type === 'grid') {
          if (!q.rows || q.rows.length === 0 || q.rows.some(row => !row || row.trim() === '')) {
            alert(`Question ${i + 1} in section "${section.title}" has empty rows`);
            return false;
          }

          if (!q.options || q.options.length === 0 || q.options.some(opt => !opt || (opt.choice_text ?? opt).trim() === '')) {
            alert(`Question ${i + 1} in section "${section.title}" has empty columns`);
            return false;
          }
        }
      }
    }

    return true;
  };

  // Form submission
  const createForm = async () => {
    if (!validateForm()) return;

    const method = id ? 'PUT' : 'POST';
    const url = id 
      ? `${API_BASE_URL}/update.php?id=${id}` 
      : `${API_BASE_URL}/create.php`;

    const formData = {
      title: formInfo.title.trim(),
      description: formInfo.description.trim(),
      sections: sections.map(section => ({
        title: section.title.trim(),
        description: section.description.trim(),
        questions: section.questions.map(q => ({
          question: q.question.trim(),
          type: q.type,
          required: q.required,
          options: (q.options || [])
            .map(opt => typeof opt === 'string' ? opt.trim() : (opt?.choice_text || '').trim())
            .filter(text => text),
          rows: (q.rows || []).filter(row => row?.trim()).map(row => row.trim())
        }))
      })),
      createdAt: new Date().toISOString(),
    };

    try {
      const response = await fetch(url, {
        method,
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
        credentials: 'omit'
      });

      if (!response.ok) {
        throw new Error(`Failed to ${method === 'POST' ? 'create' : 'update'} form`);
      }

      const result = await response.json();
      alert(`Form ${id ? 'updated' : 'created'} successfully! ID: ${result.id}`);
    } catch (error) {
      console.error('Error saving form:', error);
      alert('Failed to save form. Please try again.');
    }
  };

  if (isLoading) {
    return (
      <div className="d-flex justify-content-center align-items-center" style={{ height: '300px' }}>
        <div className="spinner-border text-primary" role="status">
          <span className="visually-hidden">Loading...</span>
        </div>
        <span className="ms-3">Loading form data...</span>
      </div>
    );
  }

  return (
    <Form ref={formRef}>
      <Card className="mb-3">
        <Card.Body>
          <div className="d-flex align-items-start">
            <div style={{ flex: 1 }}>
              <Form.Group className="mb-3">
                <Form.Label>Form Title</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="Enter form title"
                  value={formInfo.title}
                  onChange={(e) => setFormInfo({...formInfo, title: e.target.value})}
                />
              </Form.Group>
              
              <Form.Group className="mb-3">
                <Form.Label>Form Description</Form.Label>
                <Form.Control
                  as="textarea"
                  rows={3}
                  placeholder="Enter form description"
                  value={formInfo.description}
                  onChange={(e) => setFormInfo({...formInfo, description: e.target.value})}
                />
              </Form.Group>
            </div>
          </div>
        </Card.Body>
      </Card>

      <DragDropContext onDragEnd={onDragEnd}>
        {sections.map((section, sectionIndex) => (
          <Card key={section.id} className="mb-4">
            <Card.Header>
              <div className="d-flex justify-content-between align-items-center">
                <Form.Control
                  type="text"
                  value={section.title}
                  onChange={(e) => updateSection(section.id, 'title', e.target.value)}
                  placeholder="Section title"
                  className="border-0 fs-4 fw-bold bg-transparent p-0"
                />
                <Button
                  variant="outline-danger"
                  size="sm"
                  onClick={() => deleteSection(section.id)}
                >
                  Delete Section
                </Button>
              </div>
              <Form.Control
                as="textarea"
                value={section.description}
                onChange={(e) => updateSection(section.id, 'description', e.target.value)}
                placeholder="Section description (optional)"
                className="border-0 bg-transparent p-0 mt-2"
                rows={1}
              />
            </Card.Header>
            <Card.Body>
              <Droppable droppableId={section.id}>
                {(provided) => (
                  <div {...provided.droppableProps} ref={provided.innerRef}>
                    {section.questions.map((q, questionIndex) => (
                      <Draggable key={q.id} draggableId={q.id} index={questionIndex}>
                        {(provided) => (
                          <div ref={provided.innerRef} {...provided.draggableProps}>
                            <Card className="mb-3" onClick={() => !q.isEditing && toggleEdit(section.id, q.id)}>
                              <Card.Body>
                                <div className="d-flex align-items-start">
                                  <div className="me-2 mt-1" style={{ cursor: 'grab' }} {...provided.dragHandleProps}>
                                    <FaGripVertical />
                                  </div>
                                  <div style={{ flex: 1 }}>
                                    {q.isEditing ? (
                                      <>
                                        <div className="d-flex justify-content-between align-items-center mb-2">
                                          <Form.Label>Question {questionIndex + 1}</Form.Label>
                                          <div>
                                            <Button
                                              variant="outline-danger"
                                              size="sm"
                                              className="me-2"
                                              onClick={(e) => {
                                                e.stopPropagation();
                                                deleteQuestion(section.id, q.id);
                                              }}>
                                              Delete
                                            </Button>
                                            <Button
                                              variant="outline-secondary"
                                              size="sm"
                                              onClick={(e) => {
                                                e.stopPropagation();
                                                toggleEdit(section.id, q.id);
                                              }}>
                                              Preview
                                            </Button>
                                          </div>
                                        </div>

                                        <Form.Group className="mb-2">
                                          <Form.Control
                                            type="text"
                                            placeholder="Enter your question"
                                            value={q.question}
                                            onChange={(e) => handleQuestionChange(section.id, q.id, e.target.value)}
                                          />
                                        </Form.Group>

                                        <Form.Group as={Row} className="mb-2">
                                          <Form.Label column sm={2}>
                                            Type
                                          </Form.Label>
                                          <Col sm={10}>
                                            <Form.Select
                                              value={q.type}
                                              onChange={(e) => handleTypeChange(section.id, q.id, e.target.value)}>
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
                                                  value={typeof opt === 'string' ? opt : opt?.choice_text || ''}
                                                  onChange={(e) => handleOptionChange(section.id, q.id, idx, e.target.value)}
                                                />
                                                {q.options.length > 1 && (
                                                  <Button
                                                    variant="outline-danger"
                                                    className="ms-2"
                                                    onClick={(e) => {
                                                      e.stopPropagation();
                                                      removeOption(section.id, q.id, idx);
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
                                                addOption(section.id, q.id);
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
                                                  value={row}
                                                  onChange={(e) => handleRowChange(section.id, q.id, idx, e.target.value)}
                                                />
                                                {q.rows.length > 1 && (
                                                  <Button
                                                    variant="outline-danger"
                                                    className="ms-2"
                                                    onClick={(e) => {
                                                      e.stopPropagation();
                                                      removeRow(section.id, q.id, idx);
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
                                                addRow(section.id, q.id);
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
                                                  value={typeof opt === 'string' ? opt : opt?.choice_text || ''}
                                                  onChange={(e) => handleOptionChange(section.id, q.id, idx, e.target.value)}
                                                />
                                                {q.options.length > 1 && (
                                                  <Button
                                                    variant="outline-danger"
                                                    className="ms-2"
                                                    onClick={(e) => {
                                                      e.stopPropagation();
                                                      removeOption(section.id, q.id, idx);
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
                                                addOption(section.id, q.id);
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
                                                  value={typeof opt === 'string' ? opt : opt?.choice_text || ''}
                                                  onChange={(e) => handleOptionChange(section.id, q.id, idx, e.target.value)}
                                                />
                                                {q.options.length > 1 && (
                                                  <Button
                                                    variant="outline-danger"
                                                    className="ms-2"
                                                    onClick={(e) => {
                                                      e.stopPropagation();
                                                      removeOption(section.id, q.id, idx);
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
                                                addOption(section.id, q.id);
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
                                          checked={q.required}
                                          onChange={(e) => {
                                            e.stopPropagation();
                                            toggleRequired(section.id, q.id);
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
                                                deleteQuestion(section.id, q.id);
                                              }}>
                                              Delete
                                            </Button>
                                            <Button
                                              variant="outline-secondary"
                                              size="sm"
                                              onClick={(e) => {
                                                e.stopPropagation();
                                                toggleEdit(section.id, q.id);
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
                                                label={typeof opt === 'string' ? opt : opt?.choice_text || `Option ${idx + 1}`}
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
                                                    {typeof opt === 'string' ? opt : opt?.choice_text || `Option ${idx + 1}`}
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
                                              <option key={idx} value={typeof opt === 'string' ? opt : opt?.choice_text || ''}>
                                                {typeof opt === 'string' ? opt : opt?.choice_text || `Option ${idx + 1}`}
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
              <Button
                variant="outline-primary"
                onClick={() => addQuestionToSection(section.id)}
                className="mt-3">
                <FaPlus className="me-1" />
                Add Question
              </Button>
            </Card.Body>
          </Card>
        ))}
      </DragDropContext>

      <div className="d-flex justify-content-between mt-3">
        <Button variant="secondary" onClick={addSection}>
          <FaPlus className="me-1" />
          Add Section
        </Button>
        <Button variant="primary" onClick={createForm}>
          {id ? 'Save Changes' : 'Create Form'}
        </Button>
      </div>
    </Form>
  );
};

export default QuestionBuilder;