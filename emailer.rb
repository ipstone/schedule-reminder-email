#!/usr/bin/env ruby
require 'net/smtp'
require 'date'

def send_email(from, from_alias, to, to_alias, subject, message)

msg = <<END_OF_MESSAGE
From: #{from_alias} <#{from}>
To: #{to_alias} <#{to}>
Subject: #{subject}

#{message}

END_OF_MESSAGE

	Net::SMTP.start('localhost') do |smtp|
		smtp.send_message msg, from, to
	end
end

def translation_reminder (FromEmail, ToEmail, SenderName, ScheduleFile)
     rows=[]; subject="Translation Reminder:"
     file = File.open(ScheduleFile, 'r')
     rowname=file.readline.split(",")
     while row=file.gets
         rows.push(row.split(","))
     end
     file.close

     t_msg="Dear , \
     \n    Here is the schedule for this week's translation: \n"

     rows.each do |row|
			 if s_date=Date.parse(row[0]) and (s_date-Date.today>0 and s_date-Date.today<7	)#this upcoming week
					row[1..-1].each_index do |i|
						t_msg+=(rowname[i]+": "+row[i]+"\n\t\t")
						subject+=row[i]+","
					end
			end
		end

		t_msg+="\n Please reply back to this list, if there's any change or rearrangement. Thanks \n
		Any technical issues, please email: us \n\
		In His grace. "

	send_email(FromEmail, "Translation Reminder",ToEmail, SenderName,subject, t_msg)

	end

def library_reminder(FromEmail, ToEmail, SenderName, ScheduleGroup)
    # groups=["group1", "group2", "group3", "group4", "group5"]
     groups=ScheduleGroup
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

l_msg=<<END_OF_LIB

Dear,
	This is a gentle reminder for serving in library this Sunday:
	- #{serve}
	Please feel free to reach __@__ if any questions or changes for this week. Thanks

- send by Library Service Email reminder

END_OF_LIB

    subject="Serving library this week -" + serve
    send_email(FromEmail, "Library Serving Scheduler",ToEmail, SenderName,subject, l_msg)

end

def main()

translation_reminder()
library_reminder()

end

main()


