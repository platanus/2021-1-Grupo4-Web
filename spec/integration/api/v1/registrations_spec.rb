require 'swagger_helper'

# rubocop:disable RSpec/EmptyExampleGroup, RSpec/MultipleMemoizedHelpers
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

      response '200', 'password correctly updated' do
        let(:user) do
          {
            user: {
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
              password: 'some_password',
              password_confirmation: 'some_password2'
            }
          }
        end

        run_test!
      end
    end
  end

  path '/users/forgot-password' do
    post 'Send email for recover password tro user' do
      consumes 'application/json'
      produces 'application/json'
      parameter(
        name: :user,
        in: :body,
        schema: {
          type: "object",
          properties: {
            user: { "$ref" => "#/definitions/forgot_password" }
          },
          required: [
            :user
          ]
        }
      )

      let!(:user_who_forgot) { create(:user, email: 'someone@mail.com') }

      response '201', 'recover password email correctly sent' do
        let(:user) do
          {
            user: {
              email: 'someone@mail.com'
            }
          }
        end

        let(:mail) { instance_double('mailer', deliver: true) }

        before { allow(Devise::Mailer).to receive(:reset_password_instructions).and_return(mail) }

        run_test! do
          expect(Devise::Mailer).to have_received(:reset_password_instructions)
          expect(user_who_forgot.reload.reset_password_token).not_to be_nil
        end
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup, RSpec/MultipleMemoizedHelpers
