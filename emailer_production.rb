#!/usr/bin/env ruby
require 'net/smtp'

def send_email(from, from_alias, to, to_alias, subject, message)
	msg = <<END_OF_MESSAGE
From: #{from_alias} <#{from}>
To: #{to_alias} <#{to}>
Subject: #{subject}
Dear ,

	This is a gentle reminder for serving in  library this Sunday:

	    - #{message}

	Please feel free to reach ip@cbmny.us if any questions or changes for this week. 

	Thanks 

- send by Library Service Email reminder
END_OF_MESSAGE
	
	Net::SMTP.start('localhost') do |smtp|
		smtp.send_message msg, from, to
	end
end

groups=["group1", "group2", "group3", "group4", "group5"]
large_month_index=[1, 3, 5, 7, 8, 10,12]

current=Time.new
i=(current.day+3)/7
m=large_month_index.index(current.month)
m=m % 4 if m!=nil  

if i==5 then
	serve=groups[m]
	else
	serve=groups[i]
end

subject="Library this week -  " + serve
send_email("ip@cbmny.us", "Library","ip@cbmny.us", "Librarians",subject, serve)
