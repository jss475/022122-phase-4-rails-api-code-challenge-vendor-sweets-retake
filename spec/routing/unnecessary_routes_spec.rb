require 'rails_helper'

RSpec.describe 'Unnecessary Routes', type: :routing do
  it 'does not define unnecessary vendors routes' do
    expect(post: '/vendors').not_to be_routable
    expect(patch: '/vendors/1').not_to be_routable
    expect(delete: '/vendors/1').not_to be_routable
  end

  it 'does not define unnecessary sweets routes' do
    expect(post: '/sweets').not_to be_routable
    expect(patch: '/sweets/1').not_to be_routable
    expect(delete: '/sweets/1').not_to be_routable
  end

  it 'does not define unnecessary vendor_sweets routes' do
    expect(get: '/vendor_sweets').not_to be_routable
    expect(get: '/vendor_sweets/1').not_to be_routable
    expect(patch: '/vendor_sweets/1').not_to be_routable
  end
end
