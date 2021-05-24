import client from '../auth/authClient.js';

function getProviders() {
  return (client
    .get('/providers', {
    }));
}
function postProvider(provider) {
  return (client
    .post('/providers',
      { provider },
    ));
}

// eslint-disable-next-line import/prefer-default-export
export { getProviders, postProvider };
