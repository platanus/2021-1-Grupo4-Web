require 'swagger_helper'

describe 'API::V1::Registrations', swagger_doc: 'v1/swagger.json' do
  path '/users/registrations' do
    post 'Create user' do
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :user,
        in: :body,
        schema: {
          type: "object",
          properties: {
            user: { "$ref" => "#/definitions/user" }
          },
          required: [
            :user
          ]
        }
      )

      response '201', 'user created' do
        let(:user) do
          {
            user: {
              email: 'test@platan.us',
              password: 'some_password'
            }
          }
        end

        run_test!
      end
    end
  end
end
