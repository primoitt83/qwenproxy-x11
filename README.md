# qwenproxy-x11

Crie a rede net:
````
docker network create --driver=bridge --subnet=172.15.0.0/16 net
````

Suba o projeto:
````
cd /opt
git clone https://github.com/primoitt83/qwenproxy-x11.git
docker-compose up -d
````

Entre no container e inicie o X11:
````
docker-compose exec qwenproxy-x11 /bin/bash
/entrypoint.sh &
````

Verificar os processos:
````
pgrep -f "Xvfb|x11vnc|fluxbox|websockify" -l
159 fluxbox
160 websockify
162 Xvfb
````

Se não aparece os 4x, mate e rode novamente:
````
pkill websockify; pkill fluxbox; pkill x11vnc; pkill Xvfb; pkill supervisord

/entrypoint.sh &

pgrep -f "Xvfb|x11vnc|fluxbox|websockify" -l
197 websockify
199 Xvfb
202 x11vnc
203 fluxbox
````

Agora sim podemos acessar no navegador o novnc:
````
http://SEU_IP_LOCAL:8080/vnc.html

````
Aqui ficou assim:
````
http://192.168.0.16:8080/vnc.html
````

Use a senha listada no compose:

senha@123

Se ficar tudo preto, tudo bem.. isso é normal

No terminal execute:
````
npm run login
````

Volte pro navegador... Aguarde carregar o chat do Qwen, faça seu login e feche o Chromium..

No terminal já podemos matar o x11 e sair do container:
````
pkill websockify; pkill fluxbox; pkill x11vnc; pkill Xvfb; pkill supervisord
exit
````

Teste os endpoints

No terminal:
````
curl http://localhost:3000/health
{"status":"ok"}

curl http://localhost:3000/v1/models
````

Ou navegador:
````
http://localhost:3000/health

http://localhost:3000/v1/models
````
Acompanhe os logs do container:
````
docker-compose logs -f --tail=100
qwenproxy-x11  | 
qwenproxy-x11  | > qwenproxy@1.0.0 start
qwenproxy-x11  | > npx tsx src/index.ts
qwenproxy-x11  | 
qwenproxy-x11  | npm warn exec The following package was not found and will be installed: tsx@4.22.1
qwenproxy-x11  | ◇ injected env (0) from .env // tip: ◈ encrypted .env [www.dotenvx.com]
qwenproxy-x11  | [Playwright] Launching chromium...
qwenproxy-x11  | Playwright initialized (chromium).
qwenproxy-x11  | 
qwenproxy-x11  | 🚀 QwenProxy started!
qwenproxy-x11  | - Local:   http://localhost:3000
qwenproxy-x11  | - Network: http://172.15.0.15:3000
qwenproxy-x11  | 
qwenproxy-x11  | Available Routes:
qwenproxy-x11  | - [ALL] /*
qwenproxy-x11  | - [ALL] /v1/*
qwenproxy-x11  | - [GET] /health
qwenproxy-x11  | - [POST] /v1/chat/completions
qwenproxy-x11  | - [GET] /v1/models
qwenproxy-x11  | 
````
