# frozen_string_literal: true

require 'spec_helper'
require 'cfdb_record/value'

RSpec.describe CFDBRecord::Value do
  describe 'field_name' do
    it 'is hypen and space removed' do
      value = create(:value, field_name: 'Super-mail address_1')

      expect(value.field_name).to eq('Supermailaddress_1')
    end
  end
end
