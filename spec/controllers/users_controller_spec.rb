require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:admin) { User.create!(email: "admin@example.com", password: "12345678", role: :admin) }
  let(:user) { User.create!(email: "user@example.com", password: "12345678") }
  let(:other_user) { User.create!(email: "other@example.com", password: "12345678") }

  describe "GET #index" do
    context "as admin" do
      it "returns http success" do
        sign_in admin
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns @users ordered by id desc" do
        sign_in admin
        get :index
        expect(assigns(:users)).to eq(User.order(id: :desc))
      end
    end

    context "as non-admin" do
      it "redirects to root path" do
        sign_in user
        get :index
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Access denied")
      end
    end

    context "not logged in" do
      it "redirects to root path" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested user" do
      sign_in admin
      get :show, params: { id: other_user.id }
      expect(assigns(:user)).to eq(other_user)
    end

    it "returns http success" do
      sign_in admin
      get :show, params: { id: other_user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "assigns a new User" do
      sign_in admin
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "returns http success" do
      sign_in admin
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:valid_params) { { user: { email: "new@example.com", password: "12345678" } } }
    let(:invalid_params) { { user: { email: "", password: "" } } }

    context "with valid params" do
      it "creates a new user" do
        sign_in admin
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end

      it "redirects to users_path" do
        sign_in admin
        post :create, params: valid_params
        expect(response).to redirect_to(users_path)
        expect(flash[:notice]).to eq("User created")
      end
    end

    context "with invalid params" do
      it "does not create a user" do
        expect {
          post :create, params: invalid_params
        }.not_to change(User, :count)
      end

      it "renders new template with unprocessable_entity status" do
        sign_in admin
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested user" do
      sign_in admin
      get :edit, params: { id: other_user.id }
      expect(assigns(:user)).to eq(other_user)
    end

    it "returns http success" do
      sign_in admin
      get :edit, params: { id: other_user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    let(:user_to_update) { other_user }
    let(:valid_params) { { id: user_to_update.id, user: { email: "updated@example.com", active: true } } }
    let(:invalid_params) { { id: user_to_update.id, user: { email: "", active: true } } }

    context "with valid params" do
      it "updates the user" do
        sign_in admin
        patch :update, params: valid_params
        user_to_update.reload
        expect(user_to_update.email).to eq("updated@example.com")
      end

      it "redirects to users_path" do
        sign_in admin
        patch :update, params: valid_params
        expect(response).to redirect_to(users_path)
        expect(flash[:notice]).to eq("User updated.")
      end
    end

    context "with invalid params" do
      it "does not update the user" do
        sign_in admin
        patch :update, params: invalid_params
        user_to_update.reload
        expect(user_to_update.email).not_to eq("")
      end

      it "renders edit template with unprocessable_entity status" do
        sign_in admin
        patch :update, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end
end
