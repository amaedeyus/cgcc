<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Check Required Forms</title>
  <link rel="stylesheet" href="css/base.css">
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: #f5f5f5;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 800px;
      margin: 50px auto;
      background: #fff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    h1 {
      color: #2c3e50;
    }

    ul.form-list {
      list-style: none;
      padding: 0;
      margin: 20px 0;
    }

    ul.form-list li {
      background: #f9f9f9;
      padding: 15px;
      border-radius: 8px;
      margin-bottom: 10px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .form-title {
      font-weight: 500;
      color: #2c3e50;
      text-decoration: none;
    }

    .status-badge {
      padding: 5px 10px;
      border-radius: 15px;
      font-size: 0.9em;
    }

    .status-completed {
      background-color: #4CAF50;
      color: white;
    }

    .status-pending {
      background-color: #ff9800;
      color: white;
    }

    .alert {
      margin-top: 20px;
      padding: 15px;
      border-radius: 8px;
    }

    .alert-success {
      background-color: #e8f5e9;
      color: #2e7d32;
      border: 1px solid #a5d6a7;
    }

    .alert-warning {
      background-color: #fff3e0;
      color: #ef6c00;
      border: 1px solid #ffcc80;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>Required Forms</h1>
    <div id="forms-container">
      <p>Loading forms...</p>
    </div>
  </div>

  <script>
    async function fetchForms() {
      try {
        const response = await fetch('../backend/users/check_forms.php');
        const data = await response.json();

        const container = document.getElementById('forms-container');

        if (data.status !== 'success') {
          container.innerHTML = `<div class="alert alert-warning">${data.message}</div>`;
          return;
        }

        const { required_forms, completed_forms } = data;

        if (required_forms.length === 0) {
          container.innerHTML = `
            <div class="alert alert-success">No forms required at this time. You may proceed with scheduling.</div>
          `;
          return;
        }

        let allCompleted = required_forms.every(form => completed_forms.includes(form.form_index));

        const formList = document.createElement('ul');
        formList.classList.add('form-list');

        required_forms.forEach(form => {
          const isCompleted = completed_forms.includes(form.form_index);
          const li = document.createElement('li');
          li.innerHTML = `
            <a href="student_form.html?id=${form.form_index}" class="form-title">${form.form_name}</a>
            <span class="status-badge ${isCompleted ? 'status-completed' : 'status-pending'}">
              ${isCompleted ? 'Done' : 'Pending'}
            </span>
          `;
          formList.appendChild(li);
        });

        container.innerHTML = '';
        container.appendChild(formList);

        container.innerHTML += allCompleted
          ? `<div class="alert alert-success">All required forms completed! You may now <a href="schedule.html">schedule an appointment</a>.</div>`
          : `<div class="alert alert-warning">Please complete all required forms before scheduling.</div>`;

      } catch (error) {
        console.error('Error fetching forms:', error);
        document.getElementById('forms-container').innerHTML =
          `<div class="alert alert-warning">Something went wrong. Please try again later.</div>`;
      }
    }

    fetchForms();
  </script>
</body>
</html>
