# frozen_string_literal: true

require 'cfdb_record/submit'

class CFDBRecord
  class User
    attr_reader :userid

    def initialize(userid)
      @userid = userid
      @submits = Submit.find_by_userid(userid)
    end

    def attrs
      @attrs ||= @submits.inject({}) { |attrs, submit| attrs.merge(submit.attrs.reject { |_, v| v.blank? }) }
    end

    class << self
      def all
        Submit.all_userids.map { |userid| new(userid) }.sort_by { |user| user.attrs['submit_time'] }
      end

      def changed_after(target_time)
        Submit.all_userids_changed_after(target_time).map { |userid| new(userid) }.sort_by { |user| user.attrs['submit_time'] }
      end
    end
  end
end
