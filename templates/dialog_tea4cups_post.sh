#!/bin/bash

export LANG=C
export XAUTHORITY=/home/$TEAUSERNAME/.Xauthority
export DISPLAY=:0

su $TEAUSERNAME

# Essa parte é para darmos uma informação mais precisa sobre o cancelamento
# na real temos que contar as páginas para ver se não pode mesmo...
#quotas=$(expr 30 - $(wget -q -O- https://quotas.fflch.usp.br/pages/today/$(whoami)))                                                                        
#if [[ $quotas -gt 0 ]];
#then
#  motivo="Sua quota de impressão não permite imprimir esse arquivo."
#else
#  motivo="A impressora está congestionada, tente mais tarde."
#fi

if [[ "$TEASTATUS" -eq 0 ]];
then
  zenity --info --no-wrap --title "Atenção" --text \
  "
    <span>
      O arquivo <span size='x-large' weight='bold'> $TEATITLE </span> foi impresso com SUCESSO!                                               
    </span>
  " &
else
  zenity --info --no-wrap --title "Atenção" --text \
  "
    <span>
      Impressão do arquivo <span size='x-large' weight='bold'> $TEATITLE </span> CANCELADA!                                                                  
      Possíveis motivos: suas quotas acabaram, impressora está congestionada ou arquivo é muito grande para ser processado.                                                                          
    </span>
  " &
fi

exit 0
