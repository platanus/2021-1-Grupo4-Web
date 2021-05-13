API_V1 = {
  swagger: '2.0',
  info: {
    title: 'API V1',
    version: 'v1'
  },
  basePath: '/api/v1',
  definitions: {
    recipe_step_update: RECIPE_STEP_UPDATE_SCHEMA,
    recipe_step_response: RECIPE_STEP_RESPONSE_SCHEMA,
    recipe_step: RECIPE_STEP_SCHEMA,
    recipe_steps_collection: RECIPE_STEPS_COLLECTION_SCHEMA,
    recipe_step_resource: RECIPE_STEP_RESOURCE_SCHEMA,
    user: USER_SCHEMA,
    provider_ingredient: PROVIDER_INGREDIENT_SCHEMA,
    cornershop_product: CORNERSHOP_PRODUCT_SCHEMA,
    ingredient: INGREDIENT_SCHEMA,
    ingredient_response: INGREDIENT_RESPONSE_SCHEMA,
    ingredients_collection: INGREDIENTS_COLLECTION_SCHEMA,
    ingredient_resource: INGREDIENT_RESOURCE_SCHEMA,
    provider: PROVIDER_SCHEMA,
    provider_response: PROVIDER_RESPONSE_SCHEMA,
    providers_collection: PROVIDERS_COLLECTION_SCHEMA,
    provider_resource: PROVIDER_RESOURCE_SCHEMA,
    menu: MENU_SCHEMA,
    menu_response: MENU_RESPONSE_SCHEMA,
    menus_collection: MENUS_COLLECTION_SCHEMA,
    menu_resource: MENU_RESOURCE_SCHEMA,
    recipe: RECIPE_SCHEMA,
    recipes_collection: RECIPES_COLLECTION_SCHEMA,
    recipe_resource: RECIPE_RESOURCE_SCHEMA,
    recipe_response: RECIPE_RESPONSE_SCHEMA
  }
}
