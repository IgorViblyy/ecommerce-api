# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Sign_in", type: :request  do
  let(:user) { create(:user) }
  let(:wrong_user) { create(:user, password: 'password1234') }

  describe "sign_in" do
    it "when return success" do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

      # This will add a valid token for `user` in the `Authorization` header
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)

      get '/login', headers: auth_headers

      expect(response).to have_http_status(:success)
    end

    it "when return failure" do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

      # This will add a valid token for `user` in the `Authorization` header
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, wrong_user)

      get '/login', headers: auth_headers

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
