import client from '../auth/authClient.js';

function getMenus() {
  return (client
    .get('/menus', {
    }));
}

function getMenu(menuId) {
  return (client
    .get(`/menus/${menuId}`, {
    }));
}

function postMenu(menu) {
  return (client
    .post('/menus',
      { menu },
    ));
}

function updateMenu(menuId, menu) {
  return (client
    .put(`/menus/${menuId}`,
      { menu },
    ));
}

function deleteMenu(menuId) {
  return (client
    .delete(`/menus/${menuId}`, {
    }));
}

function getShoppingList(menuId) {
  return (client
    .get(`/menus/${menuId}/shopping-list`, {
    }));
}

export { getMenus, getMenu, postMenu, updateMenu, deleteMenu, getShoppingList };
