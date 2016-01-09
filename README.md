
# SYNOPSIS

The project has been renamed to "schedule-reminder-email" from "ruby-email-schedule-notice", as I have switched to sending reminder email through Google Sheets.

The new solution is simplier as it only depends on google sheet.
https://www.google.com/sheets/about/

# DESCRITION

To use "reminder" in google sheet, you can copy and paste the script "google_sheet_reminder.js" into your google sheet document, under "Tools/Script Editor". After saving the script, you may set it up to run at a regular (usually weekly) schedule to send out the reminder emails.


# OPTIONS

There are many options that you can tweak within the script. The usual needed tweaks are: 
	- Set the row number of the 'header' in the sheet
	- Set the start row number of your interested content
	- Set the last column number of your interested content
	...


# Reporting Bugs:
Report bugs to ip@cbmny.us, thanks you.
