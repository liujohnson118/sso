require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) {FactoryBot.create(:user)}

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates user with appropriate params, and redirects with notice' do
        expect {post :create, params: {user: FactoryBot.attributes_for(:user)}}.to change(User, :count).by(1)
        expect(flash[:notice]).to eq(I18n.t('users.create.success'))
        expect(subject).to redirect_to(edit_user_path(id: User.order(created_at: :desc).last.id))
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      user.reload
    end
    it 'deletes user' do
      expect {delete :destroy, params: {id: user.id}}.to change(User, :count).by(-1)
      expect(flash[:notice]).to eq(I18n.t('users.delete.success'))
      expect(subject).to redirect_to(users_path)
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: {id: user.id}
    end
    it 'creates user with appropriate params' do
      expect(assigns[:user]).to eq(user)
    end
  end

  describe 'GET #index' do
    before do
      user.reload
      get :index
    end
    it 'assigns users' do
      expect(assigns[:users]).to eq([user])
    end
  end

  describe 'POST #update' do
    before do
      user.reload
      post :update, params: {user: {email: 'john@doe.ca'}, id: user.id}
    end
    it 'updates appropriate attribute of user' do
      expect(user.reload.email).to eq('john@doe.ca')
    end
    it 'redirects to edit user page' do
      expect(subject).to redirect_to(edit_user_path(id: user.id))
    end
    it 'shows update success notice' do
      expect(flash[:notice]).to eq(I18n.t('users.update.success'))
    end
  end

end