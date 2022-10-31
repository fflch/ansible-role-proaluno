#!/bin/bash

who=$(who | grep -w tty7)
name=$(echo $who | cut -d' ' -f1)
data=$(echo $who | cut -d' ' -f3)
hora=$(echo $who | cut -d' ' -f4)
hostname=$(hostname)

curl --header "Authorization: 123"         \
     -H "Content-Type: application/json"      \
     -X POST http://192.168.8.1:8000/api/status  \
     -d "{
           \"username\": \"$name\",
           \"hostname\": \"$hostname\",
           \"login_at\": \"$data $hora\"
         }"
