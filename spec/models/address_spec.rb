require 'rails_helper'

RSpec.describe Address, type: :model do
  before { @address = FactoryGirl.build(:address) }

  subject { @address }

  it { should belong_to(:user) }
  it { should have_many(:events).dependent(:destroy) }

  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:city) }
end
