Steps to run Atto node in docker :

1. Install docker: https://www.docker.com/
2. git pull https://github.com/attocash/docker-atto
3. Edit docker-compose.yml {external-ip} with your IP for example "ws://123.1.2.3:8082"
4. Start service in background: docker compose -f docker-compose.yml --project-name atto up -d
5. or without detached: docker compose -f docker-compose.yml --project-name atto up -d
6. You can check health of node by: docker compose exec node curl -f http://localhost:8081/health
