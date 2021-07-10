# frozen_string_literal: true

USER_SCHEMA = {
  type: :object,
  properties: {
    email: { type: :string },
    password: { type: :string }
  }
}

CHANGE_PASSWORD_SCHEMA = {
  type: :object,
  properties: {
    old_password: { type: :string },
    password: { type: :string },
    password_confirmation: { type: :string }
  }
}
