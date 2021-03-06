web:
	docker compose exec web bash
up:
	docker compose up -d
down:
	docker compose stop
migrate0:
	docker compose exec rails db:migrate VERSION=0
migrate:
	docker compose exec rails db:migrate
rollback:
	docker compose exec rails db:rollback
stop:
	docker compose stop
sql:
	docker compose exec db bash
restart:
	docker compose restart
t:
	docker compose exec web rails test