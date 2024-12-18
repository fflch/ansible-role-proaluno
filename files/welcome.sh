# Welcome message
texto=$(cat /proaluno/WELCOME)
zenity --info \
       --no-wrap \
       --title="Boas-vindas!" \
       --text="$texto"