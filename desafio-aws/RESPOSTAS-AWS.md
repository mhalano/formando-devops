1. Nenhum problema nessa questão. Foi só copiar e colar os comandos.
2. Problemas no security group usado pela instância EC2. Source IP definido para "0.0.0.0/1" e não "0.0.0.0/0". Portas liberadas de 81-8080, o que não inclui a porta 80. Após fazer esses ajustes funcionou corretamente.
3. Havia dois problemas. O primeiro foi liberar a porta do SSH no security group. O segundo problema foi adicionar uma chave. Usei o recurso de SSM da AWS. Para isso adicionei uma IAM role com as permissões adequadas. Foi fácil por que já tinha criado uma role com instance profile para fazer uns testes relacionados ao SSM
4. Apenas precisei executar `sudo systemctl enable httpd`
5.1. Criei um snapshot (pois não posso clonar o volume diretamente)
5.2. Criei uma imagem AMI a partir do snapshot
5.3. Iniciei uma nova instância usando a imagem AMI e a security group criada pela stack
5.4. Criei um target group com as duas instâncias
5.5. Apontei o load balancer para usar o target group
6.1. Criei uma security group exclusiva para o balanceador onde ele aceita conexão de qualquer lugar na porta 80.
6.2. Editei o security group das instâncias para só receber tráfego vindo do security group do load balancer

