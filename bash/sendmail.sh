#!/usr/bin/bash


declare -A email
declare -a destination

EMAIL_FILE="mail.txt"

# Send email
sendmail () {
   curl -s \
    --ssl-reqd \
    --url "${email[server]}" \
    --user "${email[sender]%>}:${email[pass]}" \
    --mail-from "${email[sender]%>}" \
    --mail-rcpt "${destination[1]%>}" \
    `for email in ${destination[@]}; do echo "--mail-rcpt ${email%>}"; done` \
    --upload-file mail.txt
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#                                 System Messages
#                                 ===============
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~ Information messages
syntax="From: \"User Name\" <username@gmail.com>
To: \"Mr Anderson\" <mynameisneo@matrix.com>
Subject: This is a test message\n
Your message goes here.
And it can be written with multiple lines."

editReminderMsg="Please remember to edit your e-mail file located in the same directory 
as this script has been evoked before to procceed"

createReminderMsg="Please create a file named $EMAIL_FILE before to proceed with the following syntax:"

#~~ Sucess messages
fileCreatedMsg="\e[32mFile created successfuly!\e[m"

emailReadyMsg="\e[33mthe email above is ready to be sent. Confirm your password to proceed\e[m"

emailSentMsg="\e[32mE-mail sent successfuly!\e[m"

#~~ Error messages
fileNotFoundMsg="File $EMAIL_FILE not found. trying to create one now."

cantCreateFileMsg="\e[31mSomething went wrong and the file couldn't be created.\e[m "

mailSupportMsg="This script only supports gmail for now."

generalErrorMsg="\e[31mSomething went wrong.\e[m"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#                                 Error Handling
#                                 ==============
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cantCreateEmailFileError () {
  # Show error message and exit
  if [[ ! -f $EMAIL_FILE  ]]; then
    echo -e "$cantCreateFileMsg"
    echo -e "$createReminderMsg"
    echo -e "$syntax"
    exit 1
  else
    # Show success message
    echo -e "$fileCreatedMsg"
    echo -e "$editReminderMsg"
    exit 0
  fi
}

emailFileNotFoundError () {
  # Create a e-mail file with apropriate syntax if not exists
  if [[ ! -f $EMAIL_FILE ]]; then
    echo -e "$fileNotFoundMsg"
    echo -e "$syntax" > $EMAIL_FILE

    cantCreateEmailFileError
  fi
}

emailFileNotFoundError


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#                                 Data Analysis
#                                 ==============
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Save all email adresses into ARGS
ARGS=$(xargs grep -Eoi '<.*>' $EMAIL_FILE < /dev/null)
set $ARGS "$@"

destination=($(sed s'/,/\n/g' mail.txt | grep -oP --color '<.*>'))
unset destination[0]

# get sender and destination from mail.txt
email['sender']=${1#<};
email['destination']=${2#<};

# verify the email's sender provider
if [[ ${email[sender]%>} == *@gmail.* ]]; then
  email['server']='smtps://smtp.gmail.com:465'
elif [[ ${email[sender]%>} == *hotmail.* ]]; then
  email['server']='smtp.live.com:587'
else
  echo "$mailSupportMsg"
  exit 0
fi

# confirm the email delivery and authentication
echo -e "\e[1m$(head -3 mail.txt)\e[m"
sed  1,3d mail.txt
echo
echo -e "\e[33m$emailReadyMsg\e[m"
echo
echo -en "\e[0;92mUser: $1\nPassword: \e[m"
read -s email[pass]
echo "${email[pass]//?/*}"

echo Sending email...
sendmail && echo -e "$emailSentMsg" || echo -e "$generalErrorMsg"
