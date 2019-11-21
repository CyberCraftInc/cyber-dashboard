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

  describe 'data' do
    let(:project) { build(:project) }

    it 'returns an array of objects as json' do
      as_json = project.data

      expect(as_json[:name]).to eq(project.name)
      expect(as_json[:desc]).to eq(project.desc)
      expect(as_json[:users]).to eq(project.users.map(&:data))
    end
  end
end
