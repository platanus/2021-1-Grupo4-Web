import axios from 'axios';
import { camelizeKeys, decamelizeKeys } from 'humps';

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

client.interceptors.response.use(
  response => {
    if (response.data && response.headers['content-type'].match('application/json')) {
      response.data = camelizeKeys(response.data);
    }

    return response;
  });

client.interceptors.request.use(config => {
  const newConfig = { ...config };
  if (newConfig.headers['Content-Type'] === 'multipart/form-data') {
    return newConfig;
  }
  if (config.params) {
    newConfig.params = decamelizeKeys(config.params);
  }
  if (config.data) {
    newConfig.data = decamelizeKeys(config.data);
  }

  return newConfig;
});

export default client;
