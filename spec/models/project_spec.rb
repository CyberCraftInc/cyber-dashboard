require 'rails_helper'
RSpec.describe Project, type: :model do
  describe 'Valid?' do
    let(:project) { build(:project) }
    let(:project_without_name) { build(:project, name: nil) }

    it 'valid with valid attributes' do
      expect(project).to be_valid
    end

    it 'invalid without name attribute' do
      expect(project_without_name).not_to be_valid
    end
  end
end
