
1.
```bash
kubectl --namespace meusite logs --follow pod/serverweb --all-containers --selector app=ovo |grep erro
```

2.
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: meu-spread
spec:
  template:
    metadata:
      name: meu-spread
    spec:
      containers:
      - name: nginx
        image: nginx:latest
```

3.
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: meu-webserver
spec:
  selector:
    matchLabels:
      tier: webserver
  template:
    metadata:
      labels:
        tier: webserver
      name: meu-webserver
    spec:
      initContainers:
      - name: alpine
        image: alpine
        command:
          - "/bin/sh"
          - "-c"
          - "echo HelloGetup > /app/index.html"
        volumeMounts:
        - name: temp
          mountPath: "/app"
      containers:
      - name: nginx
        image: nginx:latest
        volumeMounts:
        - name: temp
          mountPath: /usr/share/nginx/html
      volumes:
      - name: temp
        emptyDir: {}
```

4.
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: meuweb
spec:
  selector:
    matchLabels:
      tier: webserver
  template:
    metadata:
      labels:
        tier: webserver
      name: meuweb
    spec:
      containers:
      - name: nginx
        image: nginx:1.16
      nodeSelector:
        node-role.kubernetes.io/control-plane:
```

5.
```bash
kubectl set image deployment/meuweb nginx=nginx:1.19
```

6.
```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm search repo ingress-nginx 
helm upgrade ingress-nginx ingress-nginx/ingress-nginx --set controller.hostPort.enabled=true,controller.service.type=NodePort,controller.updateStrategy.type=Recreate
```

7.
```bash
kubectl create deployment --image nginx:1.11.9-alpine pombo --replicas 4
kubectl set image deployment/pombo nginx=nginx:1.16 --record
kubectl set image deployment/pombo nginx=nginx:1.19 --record
kubectl rollout history deployment/pombo
kubectl rollout undo deployment pombo --to-revision 1
kubectl expose deployment pombo --port 80
kubectl create ingress web --class=default --rule="pombo.com/*=pombo:80"
```
8.
```bash
kubectl create deployment --image redis guardaroupa
kubectl expose deployment guardaroupa --type ClusterIP --port 6379
```
9.
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: meusiteset
  namespace: backend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
          name: web
        volumeMounts:
        - name: my-data
          mountPath: /data
  volumeClaimTemplates:
  - metadata:
      name: my-data
    spec:
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 1Gi
```

10.
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    backend: balaclava
    minhachave: semvalor
  name: balaclava
  namespace: backend
spec:
  replicas: 2
  selector:
    matchLabels:
      backend: balaclava
      minhachave: semvalor
  template:
    metadata:
      labels:
        backend: balaclava
        minhachave: semvalor
    spec:
      containers:
      - image: redis
        name: redis
```
11. 11 - linha de comando para listar todos os serviços do cluster do tipo `LoadBalancer` mostrando tambem `selectors`.
```bash
```

12.
```bash
kubectl create secret --namespace segredosdesucesso generic meusegredo --from-literal segredo=azul --from-file chave-secreta
```

13.
```bash
kubectl create configmap configsite --namespace site --from-literal index.html="Marcos Alano"
```

14.
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: meudeploy
  name: meudeploy
  namespace: default
spec:
  selector:
    matchLabels:
      app: meudeploy
  template:
    metadata:
      labels:
        app: meudeploy
    spec:
      containers:
      - image: nginx:latest
        name: nginx
        volumeMounts:
        - name: secret
          mountPath: "/app"
      volumes:
      - name: secret
        secret:
          secretName: meusegredo
```

15.
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: depconfigs
  name: depconfigs
  namespace: site
spec:
  selector:
    matchLabels:
      app: depconfigs
  template:
    metadata:
      labels:
        app: depconfigs
    spec:
      containers:
      - image: nginx:latest
        name: nginx
        volumeMounts:
        - name: data
          mountPath: "/usr/share/nginx/html"
      volumes:
      - name: data
        configMap:
          name: configsite
```


16. 
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    chaves: secretas
  name: meudeploy-2
  namespace: segredosdesucesso
spec:
  selector:
    matchLabels:
      chaves: secretas
  template:
    metadata:
      labels:
        chaves: secretas
    spec:
      containers:
      - image: nginx:1.16
        name: nginx
        envFrom:
        - secretRef:
            name: meusegredo
```

17.
```bash
kubectl create namespace cabeludo
kubectl create deployment cabelo --image nginx:latest
kubectl create secret generic acesso --namespace cabeludo --from-literal username=pavao --from-literal password=asabranca
export USUARIO=$(kubectl get secret acesso -n cabeludo -o jsonpath='{.data.password}'|base64 -d)
export SENHA=$(kubectl get secret acesso -n cabeludo -o jsonpath='{.data.username}'|base64 -d)
```

18.
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
  namespace: cachehits
spec:
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
      name: redis
    spec:
      containers:
      - name: redis
        image: redis
        volumeMounts:
        - name: app-cache
          mountPath: /data/redis
      volumes:
      - name: app-cache
        emptyDir: {}
```

19 - com uma linha de comando escale um deploy chamado `basico` no namespace `azul` para 10 replicas.

19.
```bash
kubectl scale --namespace azul deployment basico --replicas 10
```

20.
```bash
kubectl autoscale deployment site --namespace frontend --min 2 --max 5 --cpu-percent 90


21.
```
21.
```bash
kubectl get secret piadas -n meussegredos -o jsonpath='{.data.segredos}'|base64 -d
```

22.
```bash
kubectl taint node k8s-worker1 key=value:NoSchedule
```

23.
```bash
kubectl drain k8s-worker1
```

24. Colocar o manifesto YAML dentro do diretório /etc/kubernetes/manifests.

25.
```bash
kubectl create serviceaccount userx --namespace developer
kubectl create role --namespace developer --verb get,list,watch,create,delete,update,patch --resource pods,pods/status,deployments developer-role
kubectl create rolebinding userx-developer-rolebinding --role developer-role --serviceaccount developer:userx --namespace developer
kubectl auth can-i {get,list,watch,create,delete,update,patch} {pods,pods/status,deployments} --namespace developer --as system:serviceaccount:developer:userx
```

26.
```bash
openssl genrsa -out myuser.key 2048
openssl req -new -key myuser.key -out myuser.csr
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: jane
  request: < conteúdo do arquivo myuser.csr em base64 sem quebra de linha>
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # one day
  usages:
  - client auth
EOF
kubectl certificate approve jane
kubectl create role --namespace frontend --verb list --resource pods jane-role
kubectl create rolebinding --user jane --role jane-role jane-rolebinding --namespace frontend
```

27.
```bash
kubectl --namespace kube-system get componentstatuses
```