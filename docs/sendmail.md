# Sendmail
![sendmail](https://user-images.githubusercontent.com/37278803/131994791-0e2d56d6-1dd6-4c90-98f5-33613b7a2607.gif)

A commandline tool to send emails directly from the terminal.

## Prerequisites: 
* bash
* Curl  

## Instalation: 
1. download the [sendmail.sh](https://github.com/PinheiroCosta/MyScripts/blob/main/bash/sendmail.sh)  
2. give execution permission with ```chmod +x sendmail``` 
3. and then just just run the script ```$ ./sendmail``` 

## How to use: 
The email must be written inside of a file called mail.txt within the same directory as the script is with the following syntax.

```
From: "User Name" <username@gmail.com>
To: "John Smith" <john@example.com>
Subject: This is a test message

Your message goes here.
And it can be written with multiple lines.
```

# NOTE
You may need to authorize the "less secure apps" option in your gmail account to this script work properly. Do it at your own risk
https://myaccount.google.com/lesssecureapps
