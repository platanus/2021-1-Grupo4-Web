import client from '../auth/authClient.js';

function getMenus() {
  return (client
    .get('/menus', {
    }));
}

function postMenu(menu) {
  return (client
    .post('/menus',
      { menu },
    ));
}

function deleteMenu(menuId) {
  return (client
    .delete(`/menus/${menuId}`, {
    }));
}

export { getMenus, postMenu, deleteMenu };
