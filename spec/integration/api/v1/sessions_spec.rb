require 'swagger_helper'

describe 'API::V1::Sessions', swagger_doc: 'v1/swagger.json' do
  path '/users/sessions' do
    post 'Log in' do
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

      response '200', 'logged in' do
        let!(:new_user) { create(:user) }
        let(:user) do
          {
            user: {
              email: new_user.email,
              password: new_user.password
            }
          }
        end

        run_test!
      end
    end
  end
end
