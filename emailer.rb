#!/usr/bin/env ruby
require 'net/smtp'

def send_email(from, from_alias, to, to_alias, subject, message)
	msg = <<END_OF_MESSAGE
From: #{from_alias} <#{from}>
To: #{to_alias} <#{to}>
Subject: #{subject}
Dear,
	This is a gentle reminder for serving in library this Sunday:
	- #{message}
	Please feel free to reach ip@cbmny.us if any questions or changes for this week. Thanks 

- send by Library Service Email reminder
END_OF_MESSAGE
	
	Net::SMTP.start('localhost') do |smtp|
		smtp.send_message msg, from, to
	end
end


def main ()
    # the following several lines are for parsing csv file
    # we will use something similar to read of a csv file into memeory for translation services
    # we will also need an email table (not necessary) if group email
    # it would be nice if we have a translation scheduler who in charge

     filename = 'translation_schedule.csv'
     file = File.new(filename, 'r')
 
     file.each_line("\n") do |row|
         columns = row.split(",")
   
         break if file.lineno > 10
     end
    
    groups=["group1", "group2", "group3", "group4", "group5"]
    large_month_index=[1, 3, 5, 7, 8, 10,12]

    current=Time.new  # there might be a bug here, that we need to change the current date to the time.new+3 days since the reminder is sent out on Wednesday; 3 days before the serving Sunday
    
    i=(current.day+3)/7
    m=large_month_index.index(current.month)
    m=m % 4 if m!=nil  
    
    if i==5 then
	serve=groups[m]
    else
	serve=groups[i]
    end

    subject="Serving library this week -" + serve
    send_email("ip@cbmny.us", "Library Serving Scheduler","ip@cbmny.usm", "test",subject, serve)

end


main()


