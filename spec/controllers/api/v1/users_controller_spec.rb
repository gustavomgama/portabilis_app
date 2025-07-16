require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) do
        {
          user: {
            email: "testapi@example.com",
            password: "123123",
            password_confirmation: "123123",
            active: true
          }
        }
      end

      it "creates a new User" do
        expect {
          post :create, params: valid_params, format: :json
        }.to change(User, :count).by(1)
      end

      it "returns created status" do
        post :create, params: valid_params, format: :json
        expect(response).to have_http_status(:created)
      end

      it "returns the created user as JSON" do
        post :create, params: valid_params, format: :json
        json = JSON.parse(response.body)
        expect(json["email"]).to eq("testapi@example.com")
        expect(json).to have_key("id")
        expect(json["active"]).to eq(true)
      end
    end

    context "with invalid params" do
      let(:invalid_params) do
        { user: { email: "", password: "", password_confirmation: "", active: true } }
      end

      it "does not create a user" do
        expect {
          post :create, params: invalid_params, format: :json
        }.not_to change(User, :count)
      end

      it "returns unprocessable_entity status" do
        post :create, params: invalid_params, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns errors in JSON" do
        post :create, params: invalid_params, format: :json
        json = JSON.parse(response.body)
        expect(json).to have_key("errors")
        expect(json["errors"]).not_to be_empty
      end
    end
  end

  describe "PATCH #update" do
    let!(:user) do
      User.create!(
        email: "notnew@example.com",
        password: "password123",
        password_confirmation: "password123",
        active: false
      )
    end

    context "with valid params" do
      let(:valid_update_params) do
        {
          id: user.id,
          user: {
            email: "updated@example.com",
            active: true
          }
        }
      end

      it "updates the user" do
        patch :update, params: valid_update_params, format: :json
        user.reload
        expect(user.email).to eq("updated@example.com")
        expect(user.active).to eq(true)
      end

      it "returns success status" do
        patch :update, params: valid_update_params, format: :json
        expect(response).to have_http_status(:ok)
      end

      it "returns the updated user as JSON" do
        patch :update, params: valid_update_params, format: :json
        json = JSON.parse(response.body)
        expect(json["email"]).to eq("updated@example.com")
        expect(json["active"]).to eq(true)
      end
    end

    context "with invalid params" do
      let(:invalid_update_params) do
        {
          id: user.id,
          user: {
            email: "",
            active: true
          }
        }
      end

      it "does not update the user" do
        patch :update, params: invalid_update_params, format: :json
        user.reload
        expect(user.email).to eq("notnew@example.com")
      end

      it "returns unprocessable_entity status" do
        patch :update, params: invalid_update_params, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns errors in JSON" do
        patch :update, params: invalid_update_params, format: :json
        json = JSON.parse(response.body)
        expect(json).to have_key("errors")
        expect(json["errors"]).not_to be_empty
      end
    end
  end
end
