require 'rails_helper'

describe SearchController, type: :controller do
  describe "GET index" do
    subject(:send_request) do
      get :index, params: params
    end

    context 'when params are valid' do
      let(:params) { { filter: { start_date: '2024-04-01', end_date: '2024-04-01' } } }
      let!(:schedule) { create(:schedule, available_from: '2024-04-01') }

      before { send_request }

      it "responds with available tour JSON data" do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(schedule.tour.name)
      end
    end

    context 'when param is missing' do
      let(:params) { { filter: { start_date: '2024-04-01' } } }

      before { send_request }

      it "responds with available tour JSON data" do
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to include('Bad Request')
      end
    end
  end
end
