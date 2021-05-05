API_V1 = {
  swagger: '2.0',
  info: {
    title: 'API V1',
    version: 'v1'
  },
  basePath: '/api/v1',
  definitions: {
    user: USER_SCHEMA,
    provider_ingredient: PROVIDER_INGREDIENT_SCHEMA,
    ingredient: INGREDIENT_SCHEMA,
    ingredient_response: INGREDIENT_RESPONSE_SCHEMA,
    ingredients_collection: INGREDIENTS_COLLECTION_SCHEMA,
    ingredient_resource: INGREDIENT_RESOURCE_SCHEMA,
    provider: PROVIDER_SCHEMA,
    provider_response: PROVIDER_RESPONSE_SCHEMA,
    providers_collection: PROVIDERS_COLLECTION_SCHEMA,
    provider_resource: PROVIDER_RESOURCE_SCHEMA,
    recipe: RECIPE_SCHEMA,
    recipes_collection: RECIPES_COLLECTION_SCHEMA,
    recipe_resource: RECIPE_RESOURCE_SCHEMA,
    recipe_response: RECIPE_RESPONSE_SCHEMA
  }
}
