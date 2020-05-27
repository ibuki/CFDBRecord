# frozen_string_literal: true

FactoryBot.define do
  factory :value, class: 'CFDBRecord::Value' do
    submit_time { 1 }
    form_name { 'form_name' }
    field_name { 'field_name' }
    field_value { 'field_value' }
    field_order { 0 }
    file { nil }
    initialize_with { new(attributes) }
  end
end
