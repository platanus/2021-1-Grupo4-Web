API_V1 = {
  swagger: '2.0',
  info: {
    title: 'API V1',
    version: 'v1'
  },
  basePath: '/api/v1',
  definitions: {
    provider: PROVIDER_SCHEMA,
    providers_collection: PROVIDERS_COLLECTION_SCHEMA,
    provider_resource: PROVIDER_RESOURCE_SCHEMA,
    user: USER_SCHEMA
  }
}
