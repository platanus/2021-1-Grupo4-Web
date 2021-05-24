import client from '../auth/authClient.js';

function getMenus() {
  return (client
    .get('/menus', {
    }));
}

function deleteMenu(menuId) {
  return (client
    .delete(`/menus/${menuId}`, {
    }));
}

function postMenu(menu) {
  return (client
    .post('/menus',
      { menu },
    ));
}

function editMenu(menuId, menu) {
  return (client
    .put(`/menus/${menuId}`,
      { menu }, {
      }));
}

export { getMenus, deleteMenu, postMenu, editMenu };
