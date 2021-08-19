## vagrant:

    sudo apt install virt-manager libvirt-dev
    vagrant plugin install vagrant-libvirt

## cups

ip: 192.168.7.201
    apt install cups cups-tea4cups printer-driver-all openprinting-ppds

    mkdir -p /etc/systemd/system/org.cups.cupsd.socket.d/
    /etc/systemd/system/org.cups.cupsd.socket.d/override.conf

[Socket]
ListenStream=631


# Quando o tea4cups retornar falso, não tentar imprimir novamente, apenas cancele
ErrorPolicy abort-job
JobRetryLimit 0

# Preservar Jobs por 7 dias
# Supondo que o job é 187285, ele estará na pasta:
# /var/spool/cups/d187285-001
# find .|xargs file|grep -i pdf
PreserveJobFiles 604800

# Specifies the maximum time a job may take to print before it is canceled.
# Se em 20 minutos a impressora não imprimir, o job é cancelado
MaxJobTime 1200

Listen 192.168.7.202:631

systemctl restart cups


http://192.168.7.202:631

## samba 

Corrigindo locale:

    locale-gen pt_PT.UTF-8
    dpkg-reconfigure locales

Configurações de resolução do nome samba.proaluno.usp.br:

- ip: 192.168.7.202
- /etc/hostname: samba.proaluno.usp.br
- /etc/hosts: 127.0.1.1 samba samba.proaluno.usp.br

Instalação de pacotes:

    apt -y install samba krb5-config krb5-user libnss-winbind libpam-winbind winbind samba smbclient ldb-tools samba-common

Remover configuração default:

    rm /etc/samba/smb.conf

Provisionar samba-ad-dc:

    samba-tool domain provision --server-role=dc --dns-backend=SAMBA_INTERNAL --realm='PROALUNO.USP.BR' --domain='PROALUNO' --adminpass='Pr0Aluno123' --use-rfc2307

Configuração kerberos:

    cp /var/lib/samba/private/krb5.conf /etc/

Desabilitar smbd nmbd winbind:

    systemctl stop smbd nmbd winbind
    systemctl disable smbd nmbd winbind

Habilitar samba-ad-dc:

    systemctl unmask samba-ad-dc
    systemctl start samba-ad-dc
    systemctl enable samba-ad-dc 

Desabilitando complexidade de senhas:

    samba-tool user setexpiry Administrator --noexpiry 
    samba-tool domain passwordsettings set --complexity=off
    samba-tool domain passwordsettings set --history-length=0
    samba-tool domain passwordsettings set --min-pwd-age=0
    samba-tool domain passwordsettings set --max-pwd-age=0
    samba-tool domain passwordsettings set --min-pwd-length=0

Criando um grupo chamado ALUNOGR:

    samba-tool group add ALUNOGR

Criando um usuário chamado 666666:

    samba-tool user create 666666

Adicionando o usuário 666666 ao grupo ALUNOGR:

    samba-tool group addmembers ALUNOGR 666666
    samba-tool group listmembers ALUNOGR

Configurações global do log:

    log level = 10
    log file  = /var/log/samba/%m.log

Configurações global da conexão com o servidor de impressão CUPS:

    printcap name = cups
    printing = CUPS
    cups server = 192.168.7.201:631
    load printers = no

Configurações global que melhora a performance das impressões
https://wiki.samba.org/index.php/Setting_up_Samba_as_a_Print_Server :

    rpc_server:spoolss = external
    rpc_daemon:spoolssd = fork

Seção **printers** para todas impressoras:

    [printers]
        comment = All Printers
        browseable = no
        printable = True
        guest ok = no
        read only = yes
        path = /var/spool/samba/

Seção **impressora_virtual** para a impressora virtual:

    [impressora_virtual] 
        path = /var/spool/samba/ 
        browseable = yes 
        printable = yes 
        printer name = impressora_virtual
        valid users = @ALUNOGR




