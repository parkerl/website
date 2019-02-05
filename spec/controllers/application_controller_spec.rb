require 'rails_helper'

describe ApplicationController, type: :controller do
  it 'should respond with 200' do
    expect(ContactMailer).to receive(:contact_email).and_return(double('ContactMailer', deliver: true))
    expect(ContactMailer).to receive(:thank_you_email).and_return(double('ContactMailer', deliver: true))

    post :create, params: {name: '', email: '', message: ''}, xhr: true

    assert_response :success
  end

  it 'should call mailer with correct arguments to send contact email and thank_you_email' do
    expect(ContactMailer).to receive(:contact_email).with('asdf', 'asdf@example.com', 'Hello').and_return(double('ContactMailer', deliver: true))
    expect(ContactMailer).to receive(:thank_you_email).with('asdf', 'asdf@example.com').and_return(double('ContactMailer', deliver: true))

    post :create, params: {name: 'asdf', email: 'asdf@example.com', message: 'Hello'}, xhr: true

    assert_response :success
  end
end