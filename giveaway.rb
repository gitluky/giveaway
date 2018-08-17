require "selenium-webdriver"
require 'date'
require 'pry'

class Giveaway
	attr_accessor :driver, :email, :password

	def login
		# Prompts user for steam credentials
		puts "Enter Steam Account"
		self.email = gets.strip
		puts "Enter Steam PW"
		self.password = gets.strip

  	# OR Comment above and uncomment this to hardcode email and password instead
		#self.email = ""
		#self.password = ""

		# Creates and instance of Selenium Webdriver for firefox
		self.driver = Selenium::WebDriver.for :firefox

		# Opens page at Collectskins and sets the fields to a variable
		self.driver.get "https://collectskins.com/giveaway"
		account = self.driver.find_element(:id,"steamAccountName")
		pw = self.driver.find_element(:id,"steamPassword")
		button = self.driver.find_element(:id,"imageLogin")

		# Submits email and password provided above into the corresponding fields
		account.send_keys("#self.email")
		pw.send_keys("#self.password")
		button.click
		# Gives user 60 seconds wait time to submit verification code from steam
		wait = Selenium::WebDriver::Wait.new(:timeout => 60)
		#Browse to email and enter Steam validation code
		puts "Get Steam validation code from email and submit into the form"
		body = self.driver.find_element(:css, "body")
		wait.until {self.driver.find_element(:css, "body") != body}
		self.driver.get "https://collectskins.com/giveaway"
	end

	def get_ticket
		# Randomizes the time interval between 125 and 130 seconds as wait time
		random_time = rand(125..130)
		wait2 = Selenium::WebDriver::Wait.new(:timeout => random_time)
		# Will wait for the wait2 time or just click when the Button appears
		element = wait2.until {self.driver.find_element(:xpath =>"//button[@id='ticketButton' and text()='Get ticket']")}.click
		element.click
		puts "clicked the button at #{DateTime.now.to_s}"
	end
end

new_session = Giveaway.new
new_session.login

while true
	begin
		new_session.get_ticket
	rescue
		retry
	end
end
