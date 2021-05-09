import axios from 'axios';

const client = axios.create({
  baseURL: '/api/v1',
  headers: {
    'Accept': 'application/json',
  },
  params: {
    'user_email': localStorage.getItem('email'),
    'user_token': localStorage.getItem('token'),
  },
});

export default client;
