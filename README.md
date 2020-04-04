# Pró-Aluno FFLCH

Esse repositório contém a infraestrutura completa como
código do processo de build das 
máquinas das salas da pró-alunos da FFLCH.

Esta aberto a contribuições via mecanismos de pull requests e issues
do github. É uma iniciativa dos alunos/as de graduação da FFLCH
e do FLUSP (flusp.ime.usp.br).


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

## Informações para contribuição:

### Preparação do ambiente (testado com debian 10)

Instale na sua distro: ansible, vagrant

Instalação e configuração do libvirt para criar virtualização:

    $ sudo apt install virt-manager libvirt-dev

Instalação do plugin do libvirt no ansible:

    $ vagrant plugin install vagrant-libvirt

Ligar as VMs:
    
    git clone git@github.com:fflch/proaluno.git
    cd proaluno
    vagrant up

Instalação das roles do ansible

    ansible-galaxy install -r requirements.yml

Provisionando o servidor samba com senha do Administrator Pr0Aluno123:

    ansible-playbook playbooks/samba.yml

Provisionando a VM:

    ansible-playbook playbooks/vm.yml

Criar um usuário no samba:

    vagrant ssh samba
    sudo samba-tool user create FULANO

Agora é só rebootar a VM e logar na interface com usuário criado no samba.

Comandos úteis:

    ansible vm -a "/usr/sbin/init 0"
    ansible vm -a "/sbin/reboot"
    ansible vm -m ping

