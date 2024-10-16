#!/bin/bash

# dump hostname
hostname=$(hostname)

# Coleta o username da pessoa que está logada
who=$(who | grep -w tty7)
logged_username=$(echo $who | cut -d' ' -f1)

# Coleta da data e horário do login
logged_date=$(echo $who | cut -d' ' -f3)
logged_hora=$(echo $who | cut -d' ' -f4)


curl --header "Authorization: 123"         \
     -H "Content-Type: application/json"      \
     -X POST http://192.168.8.1:8000/api/status  \
     -d "{
           \"username\": \"$name\",
           \"hostname\": \"$hostname\",
           \"login_at\": \"$data $hora\"
         }"
