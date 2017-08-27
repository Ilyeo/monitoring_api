require 'rails_helper'

RSpec.describe Event, type: :model do
  before { @event = FactoryGirl.build(:event) }

  subject { @event }

  it { should belong_to(:address) }

  it { should validate_presence_of(:zone_code) }
  it { should validate_presence_of(:zone_description) }
  it { should validate_presence_of(:event_type) }

end
