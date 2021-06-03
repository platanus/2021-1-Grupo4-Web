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
function deleteProvider(providerID) {
  return (client
    .delete(`/providers/${providerID}`, {
    }));
}
function editProvider(providerId, providerInfo) {
  return (client
    .put(`/providers/${providerId}`, {
      provider: providerInfo,
    }, {
    }));
}

// eslint-disable-next-line import/prefer-default-export
export { getProviders, postProvider, deleteProvider, editProvider };
