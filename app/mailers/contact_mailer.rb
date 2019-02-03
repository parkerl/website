class ContactMailer < ApplicationMailer
  def contact_email(params)
    name = params[:name]
    @email = params[:email]
    @message = params[:message]

    mail(to: Figaro.env.CONTACT_EMAIL, subject: "#{name} would like to connect!")
  end

  def thank_you_email(name, email)
    mail(to: email, subject: "#{name}, thanks for contacting EarthVectors!")
  end
end
