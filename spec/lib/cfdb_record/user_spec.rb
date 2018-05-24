# frozen_string_literal: true

require 'spec_helper'
require 'cfdb_record/user'

RSpec.describe CFDBRecord::User do
  context 'when submit with userid' do
    before :each do
      submits = [
        { submit_time: 10.01, userid: 'userid1', tel: 'tel1', email: 'email1' },
        { submit_time: 10.02, userid: 'userid2', tel: 'tel2', email: 'email2' },
        { submit_time: 10.03, userid: 'userid1', tel: 'tel3', tag: 'tag1' },
        { submit_time: 10.04, userid: 'userid1', tel: 'tel4', tag: '' }
      ]
      submits.each do |submit|
        submit.except(:submit_time).each do |k, v|
          create(:value, submit_time: submit[:submit_time], field_name: k, field_value: v)
        end
      end
      CFDBRecord::Submit.refresh_all
    end

    describe 'all' do
      it 'count bases on userid' do
        expect(CFDBRecord::User.all.count).to eq(2)
      end
    end

    describe 'changed_after' do
      it 'returns only gt submit_time and its attrs not update by empty column' do
        users = CFDBRecord::User.changed_after(10.02)
        expect(users.count).to eq(1)
        expect(users.first.userid).to eq('userid1')
        expect(users.first.attrs['email']).to eq('email1')
        expect(users.first.attrs['tag']).to eq('tag1')
        expect(users.first.attrs['tel']).to eq('tel4')
      end
    end
  end

  context 'when submit without userid' do
    before :each do
      submits = [
        { submit_time: 0.01, tel: 'tel1', cf7msmstep: '1-3' },
        { submit_time: 0.02, tel: 'tel2', cf7msmstep: '3-3' },
        { submit_time: 0.03, tel: 'tel3' }
      ]
      submits.each do |submit|
        submit.except(:submit_time).each do |k, v|
          create(:value, submit_time: submit[:submit_time], field_name: k, field_value: v)
        end
      end
      CFDBRecord::Submit.refresh_all
    end

    describe 'all' do
      it 'count bases on userid' do
        users = CFDBRecord::User.all
        expect(users.count).to eq(2)
        expect(users.first.userid).to eq('submit_without_userid_posted_at_0.02')
        expect(users.first.attrs['tel']).to eq('tel2')
        expect(users.second.attrs['tel']).to eq('tel3')
      end
    end
  end
end
