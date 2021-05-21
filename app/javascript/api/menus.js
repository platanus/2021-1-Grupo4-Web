import client from '../auth/authClient.js';

function getMenus() {
  return (client
    .get('/menus', {
    }));
}

export { getMenus };