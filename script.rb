# frozen_string_literal: true

require 'onlyoffice_webdriver_wrapper'

server_url = ENV['URL']
screenshot_timeout = ENV['SCREENSHOT_TIMEOUT'] || 60

kill 'Server url is not specified. Set `URL` env var' unless server_url

url_with_username = "#{server_url}&username=#{Socket.gethostname}"
chrome = OnlyofficeWebdriverWrapper::WebDriver.new(:chrome)
chrome.open(url_with_username)
loop do
  OnlyofficeLoggerHelper.log("Browser logs: #{chrome.browser_logs}")
  chrome.webdriver_screenshot
  sleep(screenshot_timeout)
end
