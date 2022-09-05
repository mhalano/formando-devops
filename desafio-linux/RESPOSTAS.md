## RESPOSTAS

1. Remontei a raiz com `mount -o remount,rw /` e então editei a entrada do GRUB e defini `init=/bin/bash` como parâmetro. Depois descomentei a linha que dava permissão ao usuário vagrant em /etc/sudoers.d/vagrant, salvei do vi e reiniciei.
2.1. Executei `groupadd -g 2222 getup`, `useradd -g getup -G bin -u 1111 getup` e por fim criei um arquivo /etc/sudoers.d/getup com o conteúdo copiado e editado do /etc/sudoers.d/vagrant (user getup ao invés do user vagrant)
3.1. Editei o arquivo `/etc/ssh/sshd_config` e mudei `PasswordAuthentication yes` para `PasswordAuthentication no`. Depois reiniciei o serviço com systemctl restart sshd
3.2. Criei uma chave na minha máquina local com `ssh-keygen -t ecdsa -f vagrant_ecdsa. Copiei a linha do arquivo vagrant_ecdsa.pub para /home/.ssh/authorized_keys, uma vez que o passo 3.1 impossibilitou o uso do ssh-copy-id
3.3. Obtive a chave em texto plano com o comando `cat id_rsa-desafio-linux-devel.gz.b64|base64 -d| gzip -d > id_rsa`. Tentei conectar com `ssh -i id_rsa devel@192.168.1.17`, o que não funcionou. Olhei os logs em /var/log/secure e vi que a permissão do arquivo /home/devel/.ssh/authorized_keys estava errada. Usei o comando `chmod 600 /home/devel/.ssh/authorized_keys` para corrigir. Não consegui acesso mesmo assim. Ao adicionar a chave no ssh-agent com `ssh-add id_rsa` ocorre o erro "Error loading key "id_rsa": error in libcrypto". Este Artigo [aqui](https://serverfault.com/questions/895896/sshd-does-not-allow-publickey-authentication-due-to-libcrypto-bug) informa que a chave é muito antiga. Quando copiei a chave para dentro da VM e executei `ssh -i id_rsa devel@localhost` funcionou adequadamente
4. Editei o arquivo `/etc/nginx/nginx.conf` por que na linha 42 faltava o ponto e virgula no final da linha. Isso fez com que `nginx -t` para validar a configuração funcionasse. Depois precisei editar o arquivo /usr/lib/systemd/system/nginx.service por que na linha iniciada com "ExecStart=" estava um parametro incorreto "-BROKEN". Após remover o serviço voltou a subir, mas uma última coisa que teve que ser corrigida para o comando curl funcionar corretamente foi novamente editar o arquivo de configuração e mudar a porta onde o NGINX escuta de 90 para 80 (já que o comando diz que deve ser executado exatamente como está e assim vai pegar a porta padrão HTTP)
5.1. 
```
openssl genrsa -des3 -out myCA.key 2048
openssl req -x509 -new -nodes -key myCA.key -sha256 -days 1825 -out myCA.pem (common name desafio.local)
openssl genrsa -out www.desafio.local.key 2048
openssl req -new -key www.desafio.local.key -out www.desafio.local.csr (common name www.desafio.local)
openssl x509 -req -in www.desafio.local.csr -CA myCA.pem -CAkey myCA.key -CAcreateserial -out www.desafio.local.crt -days 825 -sha256 -extfile www.desafio.local.ext
```
Copiei os arquivos apropriados (www.desafio.local.{crt,key} para `/etc/pki/nginx` e editei o arquivo `/etc/nginx/nginx.conf` para 
funcionar com o dominio em questão. Os pontos principais foram ajustar o server_name e os paths para o certificado e a chave privada. 

Para acessar a URL usei o comando `curl --cacert myCA.pem` https://www.desafio.local`

Arquivo www.desafio.local.ext
```
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = www.desafio.local
```

6.1. Não fiz pois já estava funcionando.

6.2. Executei `curl -i https://httpbin.org/response-headers?hello=world`

6.3 ("Logs"). criei um arquivo /etc/logrotate.d/nginx com o seguinte conteúdo:
```
/var/log/nginx
{
    missingok
    sharedscripts
    postrotate
        /usr/bin/systemctl kill -s HUP nginx.service >/dev/null 2>&1 || true
    endscript
}
```
7.1 e 7.2 eu fiz e deu certo, mas perdi o log dos comandos após rebootar a VM.

7.3. Instalei o pacote xfsprogse e formatei o device com `mkfs.xfs /dev/sdc`









