#!/bin/sh

# Cor da mensagem. Você pode ver mais sobre isso aqui:
# https://misc.flogisoft.com/bash/tip_colors_and_formatting
GREEN='\033[1;32m'
RED='\e[91m'
YELLOW='\e[93m'
BOLD='\e[1m'
BLINK='\e[5m'
UNDER='\e[4m'
NC='\033[0m' # Reseta para o padrão

# Deixa um programa em loop infinito com uma mensagem de erro em vermelho.
abort()
{
	echo "${BOLD}${RED}$@${NC}"
	while true; do
		sleep 99999
	done
}

# Conecta ao servidor da FFLCH para pegar quantas quotas o aluno tem.
pega_quotas()
{
	local quotas=$(expr 30 - $(wget -q -O- {{proaluno_check_quota}}/pages/today/$(whoami)))
	if [ -z "$quotas" ]; then
		return 1
	fi

	echo $quotas
}

# Imprime a fila de impressão local. Se não couber no terminal, avisa que tem mais coisa...
imprime_fila()
{
	lpq_table=$(lpq -a)
	local num_lines=$(echo "$lpq_table" | wc -l)
	local remaining=$(expr $num_lines - 11)

	if [ -z "$lpq_table" ]; then
		echo "${BOLD}Não há documentos a serem processados na fila local${NC}"
		return 0
	fi

	echo "${BOLD}Documentos em processamento e ainda NÃO enviados para a impressora${NC}"
	echo "$lpq_table" | head -n 11

	if [ $remaining -gt 0 ]; then
		echo "${BOLD}Além desses, há mais${NC} ${RED}$remaining ${NC}${BOLD}trabalhos na fila local de impressão${NC}"
	fi

}

# Imprime a fila de impressão server
imprime_fila_server()
{
    lpq_sever=$(lpq -a -P {{proaluno_sala}} -h {{proaluno_cups_server}})
	local num_lines=$(echo "$lpq_sever" | wc -l)
	local remaining=$(expr $num_lines - 11)

	if [ -z "$lpq_sever" ]; then
		echo "${BOLD}Não há documentos na fila da impressora${NC}"
		return 0
	fi

	echo "${BOLD}Documentos na fila da impressora:${NC}"
	echo "$lpq_sever" | head -n 11

	if [ $remaining -gt 0 ]; then
		echo "${BOLD}Além desses, há mais${NC} ${RED}$remaining ${NC}${BOLD}trabalhos na fila da impressora${NC}"
	fi
}

# Imprime as quotas e chama imprime_fila.
imprime()
{
	echo "Conectando. Por favor, aguarde..."
	while true; do
		quotas=$(pega_quotas)
		if [ $? -ne 0 ]; then
			clear
			abort "Erro: Não foi possível conectar ao servidor de quotas!"
		elif [ $quotas -gt 0 ]; then
			clear
			echo "${BOLD}Você tem ${GREEN}${BOLD}$quotas${NC} ${BOLD}quotas de ${YELLOW}impressão${NC}"
        	else
			clear
			echo "${BOLD}Sua ${YELLOW}quota de impressão${NC}${BOLD} está ${RED}esgotada${NC}! Tente novamente amanhã!"

		fi
		echo ""
		imprime_fila
		echo ""
        imprime_fila_server
        sleep 3 # Espero 3 segundos na tentativa de não sobrecarregar o servidor.
	done
}

# Checa se lpq funciona
lpq -a > /dev/null
if [ $? -ne 0 ]; then
	abort "Erro: Utilitário lpq não encontrado. Contate a STI."
fi

imprime
