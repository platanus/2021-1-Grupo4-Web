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

function editMenu(menuId, menuInfo) {
  return (client
    .put(`/menus/${menuId}`,
      { menuInfo }, {
      }));
}

export { getMenus, deleteMenu, postMenu, editMenu };
