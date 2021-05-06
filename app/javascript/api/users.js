import axios from 'axios';

async function registerUser(userEmail, userPassword) {
  return (axios
    .post('/api/v1/users/registrations', {
      user: {
        email: userEmail,
        password: userPassword,
      },
    }));
}

async function loginUser(userEmail, userPassword) {
  return (axios
    .post('/api/v1/users/sessions', {
      user: {
        email: userEmail,
        password: userPassword,
      },
    })
  );
}

export { registerUser, loginUser };
