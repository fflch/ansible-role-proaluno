#!/bin/sh

zenity --warning --no-wrap --text \
    '
    <span size="x-large" weight="bold">
        Pró-Aluno   
        </span>
        <span>
        Bem-vinde à Pró-Aluno da FFLCH!

        Instruções para impressão: 
        1) NUNCA mande para imprimir pelo navegador. Baixe o arquivo
        e imprima pelo leitor de PDF.
        2) Selecione "impressora".
        3) Em "Configurar página", escolha se a impressão é em
        frente verso ou somente um lado. Caso for frente e verso e seu texto
        foi escaneado em 2 páginas para uma, selecione "Borda menor".
        4) Em "Manuseio da página", escolha "Preencher a área de
        impressão".
        5) Clique em "Imprimir".
        6) Para visualizar as suas cotas, clique no ícone localizado
        na área de impressão "Veja suas quotas".
        7) Lá você poderá verificar a quantidade de cotas
        disponíveis e confirmar se seu arquivo foi para a fila de 
        impressão. 

        ATENÇÃO: Quando seu arquivo terminar de imprimir,
        uma janela pop-up vai avisar que seu documento foi impresso.

        </span>
        '
