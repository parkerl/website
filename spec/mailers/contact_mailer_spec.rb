require 'rails_helper'

describe ContactMailer, :type => :mailer do
  it 'should send contact email with given email and name' do
    allow(Figaro.env).to receive(:CONTACT_EMAIL).and_return('someone@example.com')
    mail = described_class.contact_email('bob', 'bob@example.com', 'message').deliver_now

    expect(mail.subject).to eq('bob would like to connect!')
    expect(mail.to).to eq(['someone@example.com'])
  end

  it 'should set message and email for email template' do
    mail = described_class.contact_email('bob', 'bob@example.com', 'message').deliver_now

    expect(mail.body.encoded).to match('message')
  end

  it 'should send contact email' do
    mail = described_class.thank_you_email('bob', 'bob@example.com').deliver_now

    expect(mail.subject).to eq('bob, thanks for contacting EarthVectors!')
    expect(mail.to).to eq(['bob@example.com'])
  end
end