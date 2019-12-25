# frozen_string_literal: true

require 'onlyoffice_webdriver_wrapper'

url = ENV['URL'] || 'http://178.128.186.166:8000/open?key=f8ba44f2-1fb8-41cb-80c7-5aaa619fbbfa'

chrome = OnlyofficeWebdriverWrapper::WebDriver.new(:chrome)
chrome.open(url)
loop do
  OnlyofficeLoggerHelper.log("Browser logs: #{chrome.browser_logs}")
  sleep(10)
end
