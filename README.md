# Pró-Aluno FFLCH

Esse repositório contém a infraestrutura completa como
código do processo de build das 
máquinas das salas da pró-alunos da FFLCH.

Esta aberto a contribuições via de pull requests e issues do github. 
Foi inicialmente uma iniciativa dos alunos/as de graduação da FFLCH juntamente com a Seção  Técnica de Informática e apoio técnico do FLUSP (flusp.ime.usp.br) e do CCSL.

## Imagem

A imagem é construída com um arquivo preseed.cfg, versionado neste repositório
e disponível em:

 - http://public.fflch.usp.br/proaluno/preseed.cfg

## Provisionamento

Após a instalação da imagem, a ferramenta ansible é utilizada para configuração 
do resto do ambiente.

 - Integração com o servidor de autenticação samba da FFLCH
 - Instalação das impressoras
 - Instalação de pacotes por apt

![](https://github.com/fflch/proaluno/raw/master/diagrama.png)

### Preparação do ambiente (testado com debian 10)

Instale na sua distro: ansible, vagrant

Instalação e configuração do libvirt para criar virtualização:

    $ sudo apt install virt-manager libvirt-dev

Instalação do plugin do libvirt no ansible:

    $ vagrant plugin install vagrant-libvirt

Ligar as VMs:
    
    git clone git@github.com:VOCE-NO-GITHUB/proaluno.git
    cd proaluno
    vagrant up

Instalação das roles do ansible

    ansible-galaxy install -r requirements.yml

Provisionando infraestrutura:

    ansible-playbook playbooks/dev/cups.yml
    ansible-playbook playbooks/dev/samba.yml
    ansible-playbook playbooks/dev/laravel.yml
    ansible-playbook playbooks/dev/terminal.yml

A senha de todos serviços nesse ambiente de teste é: Pr0Aluno123

Criando um usuário no samba com número USP 8001:

    vagrant ssh samba
    sudo samba-tool user create 8001

Na máquina hospederia em /etc/hosts:

    192.168.7.203 quotas.proaluno.usp.br
    192.168.7.203 faker.proaluno.usp.br

Rota de controle de quota /check/{user}/{printer}/{pages}:

    http://quotas.proaluno.usp.br/check/8001/impressora_pdf_tea4cups/2

Rota que verifica quantas páginas foram impressas hoje para o usuário 8001:

    http://quotas.proaluno.usp.br/pages/today/8001

Usuário admin usando no laravel:

    999 admin do laravel



