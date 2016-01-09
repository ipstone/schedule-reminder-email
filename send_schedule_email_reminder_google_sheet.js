function send_schedule_email_reminder() {
  // This first part of reading the contents can be abbrieviated probably

  var startHeaderRow, lastColumn, startContentRow =3, 12, 4
  var sheet=SpreadsheetApp.getActiveSheet();

  var header=sheet.getRange(startHeaderRow, 1, 1, lastColumn).getValues();
  // Read in header based on startHeaderRow, lastColumn
  //Ref: https://developers.google.com/apps-script/reference/spreadsheet/sheet#getRange(Integer,Integer,Integer,Integer)

  var numRows=sheet.getDataRange().getNumRows(); // Get total number rows
  var dataRange=sheet.getRange(startContentRow, 1, numRows, lastColumn);
  var data=dataRange.getValues();

  var emailAddress="your_email_address@domain.com";
  var emailSubject="Name_your_email_subject";
  var emailContent="Add_introduction_text_in_email"

  var currentDate=new Date()  // Get current date
  // Loop through the sheet for date within the next 7 days
  for (l in data) {
    var row=data[l];
    var dateSchedule=row[0];
    Logger.log(dateSchedule)
    var differenceInMillis = currentDate.getTime() - dateSchedule.getTime();
    var daysDiff = Math.floor( differenceInMillis /1000/60/60/24 );
    if ((daysDiff<=0) && (daysDiff>=-7)) {
      break;};
  };

  emailSubject += row[0].toDateString(); // Add date to subject

  // Add each column in the row of this found date, i.e., collect all fields
  emailContent+=row[0].toDateString()+"\n\n"; // Add date to content

  // Collect all fields in var content
  var content="\t"
  for (var i = 1; i<11; i++) {
    content += header[0][i]+": "+row[i]+"\n\t";
  };

  emailContent += content
  emailContent += "Add_last_paragraph_of_the_email. You can also insert the hyperlink of the shared google sheet document."

  MailApp.sendEmail(emailAddress, emailSubject, 
                    emailContent, 
                    {cc:"your_friends@domain.com"}); 
  //cc is an option: string with comman seperated email addresses}
