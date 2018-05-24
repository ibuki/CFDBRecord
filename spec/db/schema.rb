# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table 'wp_cf7dbplugin_submits' do |t|
    t.decimal 'submit_time', precision: 16, scale: 4
    t.string 'form_name'
    t.string 'field_name'
    t.text 'field_value'
    t.bigint 'field_order'
    t.binary 'file'
  end
end
