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
    ingredients_collection: INGREDIENTS_COLLECTION_SCHEMA,
    ingredient_resource: INGREDIENT_RESOURCE_SCHEMA
  }
}
