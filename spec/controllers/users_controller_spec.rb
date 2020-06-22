require 'rails_helper'
require 'rails-controller-testing'

RSpec.describe UsersController, type: :controller do
  let(:user) {FactoryBot.create(:user)}

  describe 'POST #create' do
    it 'creates user with appropriate params' do
      expect { post :create, params: {user: FactoryBot.attributes_for(:user)}}.to change(User, :count).by(1)
      expect(flash[:notice]).to eq(I18n.t('users.create.success'))
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
  end

end