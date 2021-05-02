require 'swagger_helper'

describe 'API::V1::Providers', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:user_email) { user.email }
  let(:user_token) { user.authentication_token }

  path '/providers' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    get 'Retrieves Providers' do
      description 'Retrieves all the providers'
      produces 'application/json'

      let(:collection_count) { 5 }
      let(:expected_collection_count) { collection_count }

      before { create_list(:provider, collection_count) }

      response '200', 'Providers retrieved' do
        schema('$ref' => '#/definitions/providers_collection')

        run_test! do |response|
          expect(JSON.parse(response.body)['data'].count).to eq(expected_collection_count)
        end
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
      end
    end

    post 'Creates Provider' do
      description 'Creates Provider'
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :provider,
        in: :body,
        schema: {
          type: "object",
          properties: {
            provider: { "$ref" => "#/definitions/provider" }
          },
          required: [
            :provider
          ]
        }
      )

      response '201', 'provider created' do
        let(:provider) do
          {
            name: 'Some name',
            address: 'Some address',
            country: 'Some country'
          }
        end

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:provider) { {} }
        let(:user_token) { 'invalid' }

        run_test!
      end
    end
  end

  path '/providers/{id}' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    parameter name: :id, in: :path, type: :integer

    let(:existent_provider) { create(:provider) }
    let(:id) { existent_provider.id }

    get 'Retrieves Provider' do
      produces 'application/json'

      response '200', 'provider retrieved' do
        schema('$ref' => '#/definitions/provider_resource')

        run_test!
      end

      response '404', 'invalid provider id' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
      end
    end

    put 'Updates Provider' do
      description 'Updates Provider'
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :provider,
        in: :body,
        schema: {
          type: "object",
          properties: {
            provider: { "$ref" => "#/definitions/provider" }
          },
          required: [
            :provider
          ]
        }
      )

      response '200', 'provider updated' do
        let(:provider) do
          {
            name: 'Some name',
            address: 'Some address',
            country: 'Some country'
          }
        end

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:provider) { {} }
        let(:user_token) { 'invalid' }

        run_test!
      end
    end

    delete 'Deletes Provider' do
      produces 'application/json'
      description 'Deletes specific provider'

      response '204', 'provider deleted' do
        run_test!
      end

      response '404', 'provider not found' do
        let(:id) { 'invalid' }

        run_test!
      end

      response '401', 'user unauthorized' do
        let(:user_token) { 'invalid' }

        run_test!
      end
    end
  end
end
