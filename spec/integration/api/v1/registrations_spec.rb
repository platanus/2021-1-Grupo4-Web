require 'swagger_helper'

# rubocop:disable RSpec/EmptyExampleGroup
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

  path '/users/change-password' do
    parameter name: :user_email, in: :query, type: :string
    parameter name: :user_token, in: :query, type: :string

    post 'Changes password of user' do
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :user,
        in: :body,
        schema: {
          type: "object",
          properties: {
            user: { "$ref" => "#/definitions/change_password" }
          },
          required: [
            :user
          ]
        }
      )

      let!(:current_user) { create(:user, password: '12345678') }
      let(:user_email) { current_user.email }
      let(:user_token) { current_user.authentication_token }

      response '201', 'password correctly updated' do
        let(:user) do
          {
            user: {
              old_password: '12345678',
              password: 'some_password',
              password_confirmation: 'some_password'
            }
          }
        end

        run_test!
      end

      response '401', 'old password is not correct' do
        let(:user) do
          {
            user: {
              old_password: 'incorrect_password',
              password: 'some_password',
              password_confirmation: 'some_password'
            }
          }
        end

        run_test!
      end

      response '400', 'new password and confirmation are not the same' do
        let(:user) do
          {
            user: {
              old_password: '12345678',
              password: 'some_password',
              password_confirmation: 'some_password2'
            }
          }
        end

        run_test!
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
