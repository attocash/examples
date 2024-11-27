Steps to run Atto node in docker :

Install docker: https://www.docker.com/
git pull https://github.com/attocash/docker-atto
Edit docker-compose.yml {external-ip} with your IP for example "ws://123.1.2.3:8082"
Start service in background: docker compose -f docker-compose.yml --project-name atto up -d
or without detached: docker compose -f docker-compose.yml --project-name atto up -d
You can check health of node by: docker compose exec node curl -f http://localhost:8081/health
