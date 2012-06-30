#!/usr/bin/env ruby
require 'net/smtp'
require 'date'

def send_email(fromEmail, fromName, toEmail, toName, subject, message)

  msg = <<MESSAGE
From: #{fromName} <#{fromEmail}>0
To: #{toName} <#{toEmail}>
Subject: #{subject}
#{message}
MESSAGE

  Net::SMTP.start('localhost') do |smtp|
    smtp.send_message msg, fromEmail, toEmail
  end
end

def schedule_by_file (scheduleFile)
# TODO: scheduleByFile shall return the schedule text, not
  # the email in the future
  t_msg,rows, rowname="", [], []
  File.open(scheduleFile, 'r') do |file|
    rowname=file.readline.split(",")
    while row=file.gets
      rows.push(row.split(","))
    end
  end
  p rowname
  rows.each do |row|
    if s_date=Date.strptime(row[0], "%m/%d/%Y") and \
      (s_date-Date.today>0 and  s_date-Date.today<7)#this
      #upcoming week
      row[1..-1].each_index do |i|
        t_msg+=(rowname[i]+": "+row[i]+"\n\t\t")
#        subject+=row[i]+","
      end
    end
  end

  t_msg="Dear , \
     \n    Here is the schedule for this week's ___:
    \n" + t_msg
  t_msg+="\n Please reply back to this list, if there's any change or rearrangement. Thanks \n
		Any technical issues, please email: us \n"
end

def schedule_by_rotation(schedulegroup)
  #Schedule rotation shall return the text, not sending the
  #email
  groups=scheduleGroup
  large_month_index=[1, 3, 5, 7, 8, 10,12]
  current=Time.new
  i=(current.day)/7 # use mod to rotate
  # Here starts complex arrangement: if large month, then
  # rotate, if not large month, then just the calc by mod
  m=large_month_index.index(current.month)
  if m!=nil
    m=m % 4
    serve= (i>=5 ? serve=groups[m]: serve=groups[i])
  else
    serve=groups[i-1]
  end

  l_msg=<<END_OF_LIB
Dear,
	This is a gentle reminder for serving in library this Sunday:
	- #{serve}
	Please feel free to reach __@__ if any questions or changes for this week. Thanks

- send by Library Service Email reminder
END_OF_LIB
end

def main()
  p scheduleByFile("test.csv") #not tested yet this time
  p schedule_by_rotation(%w{ group1, group2, group3, group4})
end

main()
