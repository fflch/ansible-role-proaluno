#!/bin/bash
# Esse script requer bash!

if [ -z $BASH ]; then
    echo "limpa_fila_impressao.sh: Esse script requer bash."
    exit 1
fi

# Pega todas as impressoras na máquina.
get_all_printers()
{
    lpstat -a | awk '{ print $1 }'
}

# Mata todos os jobs na máquina.
kill_all_jobs()
{

    all_printers=$(get_all_printers)

    for printer in $all_printers; do
        lpstat -o $printer | while read job; do
            jobnum=$(echo $job | cut -f1 -d" "| cut -f2 -d-)
            echo "Removendo job $jobnum na impressora $printer..."
            lprm -P $printer $jobnum
        done
    done
}

kill_all_jobs
