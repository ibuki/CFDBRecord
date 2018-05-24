# frozen_string_literal: true

require 'active_record'

class CFDBRecord
  class Value < ActiveRecord::Base
    self.table_name = 'wp_cf7dbplugin_submits'

    def field_name
      super.tr(' -', '')
    end

    class << self
      def all_submit_times
        group(:submit_time).pluck(:submit_time)
      end

      def all_userids
        where(field_name: 'userid').group(:field_value).pluck(:field_value)
      end

      def all_field_names
        all.map(&:field_name).uniq
      end

      def latest_submit_time
        all_submit_times.last
      end
    end
  end
end
