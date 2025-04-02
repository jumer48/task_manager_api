require 'rails_helper'

RSpec.describe '/tasks', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:task) { create(:task, user: user) }
  
  # JWT token generation
  def auth_headers(user)
    token = JWT.encode(
      { user_id: user.id, exp: 24.hours.from_now.to_i },
      Rails.application.secret_key_base
    )
    { 'Authorization' => "Bearer #{token}" }
  end

  describe 'GET /tasks/:id' do
    context 'with valid task' do
      before { get "/tasks/#{task.id}", headers: auth_headers(user) }

      it 'returns the task' do
        expect(response.body).to include(task.title)
      end

      it 'returns 200 status' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with non-existent task' do
      before { get "/tasks/999999", headers: auth_headers(user) }

      it 'returns 404 status' do
        expect(response).to have_http_status(404)
      end

      it 'returns error message' do
        expect(response.body).to include('Task not found')
      end
    end

    context 'with unauthorized access' do
      before { get "/tasks/#{task.id}", headers: auth_headers(other_user) }

      it 'returns 403 status' do
        expect(response).to have_http_status(403)
      end
    end
  end
end