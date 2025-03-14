# !/bin/sh
timenow=$(date)
hostname=$(hostname)
ip=$(ip a | grep inet | grep eth1 | cut -d' ' -f6 | cut -d'/' -f1)
who=$(who | grep -w tty7)
name=$(echo $who | cut -d' ' -f1)
date=$(echo $who | cut -d' ' -f3)
time=$(echo $who | cut -d' ' -f4)

monitor=$(xrandr | grep ' connected')
keyboard=$(ls /dev/input/by-id | grep -i keyboard)
mouse=$(ls /dev/input/by-id | grep -i 'mouse' | grep -v 'event')

# LINK PROVISORIO
curl --header "Authorization: 123"         \
    -H "Content-Type: application/json"      \
    -X POST https://factual-more-yak.ngrok-free.app/controle/recebe.php/  \
    -d "{
          \"timenow\": \"$timenow\",
          
          \"hostname\": \"$hostname\",
          \"ip\":       \"$ip\",
          \"username\": \"$name\",
          \"login_at\": \"$date $time\",

          \"monitor\": \"$monior\",
          \"mouse\": \"$mouse\",
          \"keyboard\": \"$keyboard\"
        }"  
