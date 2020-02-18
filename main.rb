# frozen_string_literal: true

require 'bundler/setup'
require 'onlyoffice_documentserver_testing_framework'
require_relative 'onlyoffice_webdriver_page_opener/methods'

screenshot_timeout = ENV['SCREENSHOT_TIMEOUT'] || 60

instance = OnlyofficeDocumentserverTestingFramework::TestInstanceDocs.new
chrome = instance.webdriver
chrome.open(from_url)
loop do
  OnlyofficeLoggerHelper.log("Current url: #{chrome.get_url}")
  chrome.webdriver_screenshot
  puts(chrome.browser_logs)
  sleep(screenshot_timeout)
  unless instance.spreadsheet_editor.top_toolbar.users.count > 1
    chrome.webdriver_error("Only one user is connected to current document")
  end
end
