require 'rails_helper'

Capybara.register_driver :selenium_chrome do |app|
  browser_options = ::Selenium::WebDriver::Chrome::Options.new

  browser_options.args << 'auto-open-devtools-for-tabs'
  browser_options.args << 'window-size=1920,1080'
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end

Capybara.default_driver = :selenium_chrome
Capybara.javascript_driver = :selenium_chrome

Capybara.register_server :rails_puma do |app, port, host|
  require 'rack/handler/puma'
  Rack::Handler::Puma.run(app, Port: port, Threads: '0:1', Silent: true)
end

Capybara.server = :rails_puma
Capybara.threadsafe = true

RSpec.configure do |config|
  config.use_transactional_fixtures = false
end

ActionController::Base.allow_forgery_protection = true

def by(message)
  if block_given?
    yield
  else
    skip message
  end
end

alias and_by by
alias it_also by
