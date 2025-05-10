import React, { useState, useEffect } from 'react';
import { Container, Row, Col, Button, Card } from 'react-bootstrap';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import { LocalizationProvider, DateCalendar } from '@mui/x-date-pickers';
import dayjs from 'dayjs';
import './AppointmentScheduler.css';

const AppointmentScheduler = () => {
  const [calendarDate, setCalendarDate] = useState(dayjs());
  const [selectedDate, setSelectedDate] = useState(null);
  const [formData, setFormData] = useState({ title: '', description: '' });
  const [weekSlots, setWeekSlots] = useState([]);
  const [visibleDays, setVisibleDays] = useState(getDaysToShow(window.innerWidth));

  // Helper to get available times
  const getAvailableTimeSlots = (date) => {
    const slots = [];
    for (let hour = 8; hour <= 17; hour++) {
      for (let minute = 0; minute < 60; minute += 30) {
        slots.push(dayjs(date).set('hour', hour).set('minute', minute));
      }
    }
    return slots;
  };

  // Determine how many days to show based on screen width
  function getDaysToShow(width) {
    if (width >= 1400) return 7; // max 7 days
    if (width >= 1200) return 6;
    if (width >= 992) return 5;
    if (width >= 768) return 4;
    if (width >= 576) return 3;
    return 2;
  }
  

  const generateWeekSlots = (startDate) => {
    const days = [];
    for (let i = 0; i < visibleDays; i++) {
      const date = startDate.add(i, 'day');
      days.push({
        date,
        slots: getAvailableTimeSlots(date),
      });
    }
    setWeekSlots(days);
  };

  // Handle window resize
  useEffect(() => {
    const handleResize = () => {
      const newCount = getDaysToShow(window.innerWidth);
      setVisibleDays(newCount);
    };

    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  // Update slots when date or visibleDays change
  useEffect(() => {
    generateWeekSlots(calendarDate.startOf('day'));
  }, [calendarDate, visibleDays]);

  const handleAdd = () => {
    if (!selectedDate) return alert('Please select a time slot.');
    console.log({
      summary: formData.title,
      description: formData.description,
      start: selectedDate.toISOString(),
      end: selectedDate.add(1, 'hour').toISOString(),
    });
    setFormData({ title: '', description: '' });
  };

  return (
    <Container fluid className="mt-3 px-2">
      <Row className="gx-0">
      <h2>Schedule an Appointment</h2>
        <Col md={3}>
          <LocalizationProvider dateAdapter={AdapterDayjs}>
            <div style={{ transform: 'scale(0.85)', transformOrigin: 'top left' }}>
              <DateCalendar
                value={calendarDate}
                onChange={(newDate) => setCalendarDate(newDate)}
              />
            </div>
          </LocalizationProvider>
        </Col>

        <Col md={9}>
          <div className="d-flex flex-nowrap overflow-auto">
            {weekSlots.map(({ date, slots }, idx) => (
              <div className="day-col me-3" key={idx}>
                <Card>
                  <Card.Body>
                    <div className="day-title d-flex justify-content-between align-items-center">
                      {idx === 0 && (
                        <Button
                          variant="link"
                          className="week-nav-arrow"
                          onClick={() => setCalendarDate((prev) => prev.subtract(visibleDays, 'day'))}
                        >
                          &lt;
                        </Button>
                      )}
                      <div className="text-center flex-grow-1">
                        <div className="day-title-large">{date.format('MMM D')}</div>
                        <div className="day-title-small">{date.format('ddd')}</div>
                      </div>
                      {idx === weekSlots.length - 1 && (
                        <Button
                          variant="link"
                          className="week-nav-arrow"
                          onClick={() => setCalendarDate((prev) => prev.add(visibleDays, 'day'))}
                        >
                          &gt;
                        </Button>
                      )}
                    </div>

                    <div className="d-flex flex-column gap-1">
                      {slots.map((slot, i) => (
                        <Button
                          key={i}
                          variant="outline-primary"
                          className={`time-slot-btn ${selectedDate && selectedDate.isSame(slot) ? 'selected-slot' : ''}`}
                          onClick={() => setSelectedDate(slot)}
                        >
                          {slot.format('h:mm A')}
                        </Button>
                      ))}
                    </div>
                  </Card.Body>
                </Card>
              </div>
            ))}
          </div>

          <Button variant="primary" className="mt-3" onClick={handleAdd}>
            Schedule
          </Button>
        </Col>
      </Row>
    </Container>
  );
};

export default AppointmentScheduler;
