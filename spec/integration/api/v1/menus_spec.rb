require 'swagger_helper'

describe 'ApiV1::Menus', swagger_doc: 'v1/swagger.json' do
  let!(:user) { create(:user) }
  let(:user_email) { user.email }
  let(:user_token) { user.authentication_token }
  let(:user_to_update) { create(:user) }

  path '/menus' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    get 'Retrieves Menus' do
      description 'Retrieves all the menus'
      produces 'application/json'

      let(:collection_count) { 5 }
      let(:expected_collection_count) { collection_count }

      before { create_list(:menu, collection_count, user: user) }

      response '200', 'Menus retrieved' do
        schema('$ref' => '#/definitions/menus_collection')

        run_test! do |response|
          expect(JSON.parse(response.body)['data'].count).to eq(expected_collection_count)
        end
      end
    end

    post 'Creates Menu' do
      description 'Creates Menu'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :menu, in: :body)

      response '201', 'menu created' do
        let(:menu) do
          {
            name: 'Some name'
          }
        end

        run_test!
      end
    end
  end

  path '/menus/{id}' do
    parameter name: :id, in: :path, type: :integer
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    let(:existent_menu) { create(:menu, user: user) }
    let(:id) { existent_menu.id }

    get 'Retrieves Menu' do
      produces 'application/json'

      response '200', 'menu retrieved' do
        schema('$ref' => '#/definitions/menu_resource')

        run_test!
      end

      response '404', 'invalid menu id' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates Menu' do
      description 'Updates Menu'
      consumes 'application/json'
      produces 'application/json'
      parameter(name: :menu, in: :body)

      response '200', 'menu updated' do
        let(:menu) do
          {
            name: 'Some other name'
          }
        end

        run_test!
      end
    end

    delete 'Deletes Menu' do
      produces 'application/json'
      description 'Deletes specific menu'

      response '204', 'menu deleted' do
        run_test!
      end

      response '404', 'menu not found' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end
end
