# frozen_string_literal: true

require 'cfdb_record/value'
require 'uri'

class CFDBRecord
  class Submit
    def initialize(submit_time)
      @submit_time = submit_time
    end

    def attrs
      @attrs ||= begin
        attrs = Value.where(submit_time: @submit_time).each_with_object({}) { |val, obj| obj[val.field_name] = val.field_value }
        add_attrs(attrs)
      end
    end

    def userid
      @userid ||= first_userid_valid? ? attrs[first_userid_key] : userid_alt
    end

    def first_userid_valid?
      first_userid_key && !attrs[first_userid_key].empty?
    end

    def last_step?
      return true unless attrs.key?('cf7msmstep')
      step, total = attrs['cf7msmstep'].split('-')
      step == total
    end

    private

    def add_attrs(base_attrs)
      base_attrs.merge!(attrs_from_url(base_attrs['url']))
      base_attrs['submit_time'] = @submit_time
      base_attrs['data_source'] = 'Yahooスポンサードサーチ' if base_attrs['media'] == 'yss'
      base_attrs['data_source'] = 'GoogleAdwords' if base_attrs['media'] == 'gaw'
      base_attrs
    end

    def attrs_from_url(url)
      return {} unless url
      params = URI.parse(url).query
      return {} unless params
      Hash[URI.decode_www_form(params)]
    end

    def userid_alt
      "submit_without_userid_posted_at_#{@submit_time}"
    end

    def first_userid_key
      @first_userid_key ||= attrs.keys.sort.find { |key| key.start_with?('userid') }
    end

    class << self
      def all
        @all || refresh_all
      end

      def refresh_all
        @all = Value.all_submit_times.map { |submit_time| new(submit_time) }
                    .select { |submit| submit.first_userid_valid? || submit.last_step? }
      end

      def all_userids
        all.map(&:userid).uniq
      end

      def all_userids_changed_after(target_time)
        all.select { |submit| submit.attrs['submit_time'] > target_time }.map(&:userid).uniq
      end

      def find_by_userid(userid)
        all.select { |submit| submit.userid == userid }
      end
    end
  end
end
