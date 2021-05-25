import axios from 'axios';

const tokenEl = document && document.querySelector('meta[name="csrf-token"]');
const CSRFToken = tokenEl && tokenEl.getAttribute('content');

function registerUser(userEmail, userPassword) {
  return (axios
    .post('/api/v1/users/registrations', {
      user: {
        email: userEmail,
        password: userPassword,
      },
    },
    {
      headers: {
        'X-CSRF-Token': CSRFToken,
      },
    },
    ));
}

function loginUser(userEmail, userPassword) {
  return (axios
    .post('/api/v1/users/sessions', {
      user: {
        email: userEmail,
        password: userPassword,
      },
    },
    {
      headers: {
        'X-CSRF-Token': CSRFToken,
      },
    },
    )
  );
}

async function logoutUser() {
  return (axios
    .delete('/users/sign_out',
      {
        headers: {
          'X-CSRF-Token': CSRFToken,
        },
      },
    )
  );
}

export { registerUser, loginUser, logoutUser };
