SHELL := /bin/bash
.SHELLFLAGS := -ec

# --------------------------------------------------------- #

.PHONY: postgres-up
postgres-up:
	docker-compose -f ./containers/postgres/compose.yml up -d;

.PHONY: postgres-down
postgres-down:
	@read -p "Remove this project postgres contaniner? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/postgres/compose.yml down; \
	fi

.PHONY: postgres-down-prune
postgres-down-prune:
	@read -p "Remove this project postgres contaniner and the volume? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/postgres/compose.yml down -v; \
	fi

.PHONY: postgres-start
postgres-start:
	docker-compose -f ./containers/postgres/compose.yml start;

.PHONY: postgres-stop
postgres-stop:
	docker-compose -f ./containers/postgres/compose.yml stop;

.PHONY: postgres-restart
postgres-restart:
	docker-compose -f ./containers/postgres/compose.yml restart;

# --------------------------------------------------------- #

.PHONY: redis-up
redis-up:
	docker-compose -f ./containers/redis/compose.yml up -d;

.PHONY: redis-down
redis-down:
	@read -p "Remove this project redis contaniner? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/redis/compose.yml down; \
	fi

.PHONY: redis-down-prune
redis-down-prune:
	@read -p "Remove this project redis contaniner and the volume? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/redis/compose.yml down -v; \
	fi

.PHONY: redis-start
redis-start:
	docker-compose -f ./containers/redis/compose.yml start;

.PHONY: redis-stop
redis-stop:
	docker-compose -f ./containers/redis/compose.yml stop;

.PHONY: redis-restart
redis-restart:
	docker-compose -f ./containers/redis/compose.yml restart;

# --------------------------------------------------------- #

.PHONY: kafka-up
kafka-up:
	docker-compose -f ./containers/kafka/compose.yml up -d;

.PHONY: kafka-down
kafka-down:
	@read -p "Remove this project kafka contaniner? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/kafka/compose.yml down; \
	fi

.PHONY: kafka-down-prune
kafka-down-prune:
	@read -p "Remove this project kafka contaniner and the volume? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/kafka/compose.yml down -v; \
	fi

.PHONY: kafka-start
kafka-start:
	docker-compose -f ./containers/kafka/compose.yml start;

.PHONY: kafka-stop
kafka-stop:
	docker-compose -f ./containers/kafka/compose.yml stop;

.PHONY: kafka-restart
kafka-restart:
	docker-compose -f ./containers/kafka/compose.yml restart;
