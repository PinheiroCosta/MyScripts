#!/usr/bin/bash

# Send email
sendmail () {
  curl -s \
    --ssl-reqd \
    --url "${email[server]}" \
    --user "${email[sender]%>}:${email[pass]}" \
    --mail-from "${email[sender]%>}" \
    --mail-rcpt "${email[destination]%>}" \
    --upload-file mail.txt
}

# verify if the mail file exists
if [[ -f mail.txt ]]; then
  ARGS=$(xargs grep -Eoi '<.*>' mail.txt < /dev/null)
  set $ARGS "$@"
else
  # create a mail file
  echo "File mail.txt not found. trying to create one now."
  echo -e "From: \"User Name\" <username@gmail.com>\nTo: "John Smith" <john@example.com>\nSubject: This is a test message\n\nYour message goes here.\nAnd it can be written with multiple lines." > mail.txt

  # if file does not exist try to create one and exit.
  if [[ -f mail.txt ]]; then
    echo -e "File created successufuly. Please remeber to edit your email file located in this same directory before proceed.\n"
    exit 0
  else
    # show error message and exit with error.
    echo "Something went wrong and the file couldn't be created. Please create a file named mail.txt before proceed with the following syntax:"
    echo -e "From: \"User Name\" <username@gmail.com>\nTo: "John Smith" <john@example.com>\nSubject: This is a test message\n\nYour message goes here.\nAnd it can be written with multiple lines."
    exit 1
  fi
fi

# get sender and destination from mail.txt
declare -A email;
email['sender']=${1#<};
email['destination']=${2#<};

# verify the email provider
if [[ ${email[sender]%>} == *@gmail.* ]]; then
  email['server']='smtps://smtp.gmail.com:465'
else
  echo "this script only supports gmail for now."
  exit 0
fi

# confirm the email delivery and authentication
echo -e "\e[1m$(cat mail.txt)\e[m"
echo
echo -e "\e[33mthe above email is ready to be sent. Confirm your password to proceed\e[m"
echo
echo -en "\e[0;92mUser: $1\nPassword: \e[m"
read -s email[pass]
echo "${email[pass]//?/*}"

echo Sending email...
sendmail && echo -e "\e[32mEmail sent successufly!\e[m" || echo -e "\e[31mSomething went wrong\e[m"
