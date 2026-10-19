SHELL := /bin/bash
.SHELLFLAGS := -ec

.DEFAULT_GOAL := help

# --------------------------------------------------------- #

##@ Info

.PHONY: help
help: ## Show this help message
	@awk 'BEGIN {FS = ":.*##"} \
		/^[a-zA-Z0-9_-]+:.*##/ { printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2 } \
		/^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) }' $(MAKEFILE_LIST)

# --------------------------------------------------------- #

##@ Postgres Primary

.PHONY: postgres-primary-up
postgres-primary-up: ## Start postgres primary container
	docker-compose -f ./containers/postgres-primary/compose.yml up -d;

.PHONY: postgres-primary-down
postgres-primary-down: ## Stop & remove postgres primary container
	@read -p "Remove this project postgres primary container? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/postgres-primary/compose.yml down; \
	fi

.PHONY: postgres-primary-down-v
postgres-primary-down-v: ## Stop & remove postgres primary container + volume
	@read -p "Remove this project postgres primary container and the volume? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/postgres-primary/compose.yml down -v; \
	fi

.PHONY: postgres-primary-start
postgres-primary-start: ## Start postgres primary container
	docker-compose -f ./containers/postgres-primary/compose.yml start;

.PHONY: postgres-primary-stop
postgres-primary-stop: ## Stop postgres primary container
	docker-compose -f ./containers/postgres-primary/compose.yml stop;

.PHONY: postgres-primary-restart
postgres-primary-restart: ## Restart postgres primary container
	docker-compose -f ./containers/postgres-primary/compose.yml restart;

.PHONY: postgres-primary-logs
postgres-primary-logs: ## Tail postgres primary logs
	docker-compose -f ./containers/postgres-primary/compose.yml logs;

# --------------------------------------------------------- #

##@ Postgres Replica

.PHONY: postgres-replica-up
postgres-replica-up: ## Start postgres replica container
	docker-compose -f ./containers/postgres-replica/compose.yml up -d;

.PHONY: postgres-replica-down
postgres-replica-down: ## Stop & remove postgres replica container
	@read -p "Remove this project postgres replica container? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/postgres-replica/compose.yml down; \
	fi

.PHONY: postgres-replica-down-v
postgres-replica-down-v: ## Stop & remove postgres replica container + volume
	@read -p "Remove this project postgres replica container and the volume? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/postgres-replica/compose.yml down -v; \
	fi

.PHONY: postgres-replica-start
postgres-replica-start: ## Start postgres replica container
	docker-compose -f ./containers/postgres-replica/compose.yml start;

.PHONY: postgres-replica-stop
postgres-replica-stop: ## Stop postgres replica container
	docker-compose -f ./containers/postgres-replica/compose.yml stop;

.PHONY: postgres-replica-restart
postgres-replica-restart: ## Restart postgres replica container
	docker-compose -f ./containers/postgres-replica/compose.yml restart;

.PHONY: postgres-replica-logs
postgres-replica-logs: ## Tail postgres replica logs
	docker-compose -f ./containers/postgres-replica/compose.yml logs;

# --------------------------------------------------------- #

##@ Postgres (combined)

.PHONY: postgres-up
postgres-up: ## Start primary + replica
	make postgres-primary-up; \
	make postgres-replica-up;

.PHONY: postgres-down
postgres-down: ## Stop & remove primary + replica
	@read -p "Remove this project postgres primary & replica container? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/postgres-primary/compose.yml down; \
		docker-compose -f ./containers/postgres-replica/compose.yml down; \
	fi

.PHONY: postgres-down-v
postgres-down-v: ## Stop & remove primary + replica and volumes
	@read -p "Remove this project postgres primary & replica container and the volume? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/postgres-primary/compose.yml down -v; \
		docker-compose -f ./containers/postgres-replica/compose.yml down -v; \
	fi

.PHONY: postgres-start
postgres-start: ## Start primary + replica
	make postgres-primary-start; \
	make postgres-replica-start;

.PHONY: postgres-stop
postgres-stop: ## Stop primary + replica
	make postgres-primary-stop; \
	make postgres-replica-stop;

.PHONY: postgres-restart
postgres-restart: ## Restart primary + replica
	make postgres-primary-restart; \
	make postgres-replica-restart;

# --------------------------------------------------------- #

##@ Redis

.PHONY: redis-up
redis-up: ## Start redis container
	docker-compose -f ./containers/redis/compose.yml up -d;

.PHONY: redis-down
redis-down: ## Stop & remove redis container
	@read -p "Remove this project redis container? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/redis/compose.yml down; \
	fi

.PHONY: redis-down-prune
redis-down-prune: ## Stop & remove redis container + volume
	@read -p "Remove this project redis container and the volume? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/redis/compose.yml down -v; \
	fi

.PHONY: redis-start
redis-start: ## Start redis container
	docker-compose -f ./containers/redis/compose.yml start;

.PHONY: redis-stop
redis-stop: ## Stop redis container
	docker-compose -f ./containers/redis/compose.yml stop;

.PHONY: redis-restart
redis-restart: ## Restart redis container
	docker-compose -f ./containers/redis/compose.yml restart;

.PHONY: redis-logs
redis-logs: ## Tail redis logs
	docker-compose -f ./containers/redis/compose.yml logs;

# --------------------------------------------------------- #

##@ Kafka

.PHONY: kafka-up
kafka-up: ## Start kafka container
	docker-compose -f ./containers/kafka/compose.yml up -d;

.PHONY: kafka-down
kafka-down: ## Stop & remove kafka container
	@read -p "Remove this project kafka container? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/kafka/compose.yml down; \
	fi

.PHONY: kafka-down-prune
kafka-down-prune: ## Stop & remove kafka container + volume
	@read -p "Remove this project kafka container and the volume? [y/n] " answer; \
	if [[ "$$answer" == "y" || "$$answer" == "Y" ]]; then \
		docker-compose -f ./containers/kafka/compose.yml down -v; \
	fi

.PHONY: kafka-start
kafka-start: ## Start kafka container
	docker-compose -f ./containers/kafka/compose.yml start;

.PHONY: kafka-stop
kafka-stop: ## Stop kafka container
	docker-compose -f ./containers/kafka/compose.yml stop;

.PHONY: kafka-restart
kafka-restart: ## Restart kafka container
	docker-compose -f ./containers/kafka/compose.yml restart;

.PHONY: kafka-logs
kafka-logs: ## Tail kafka logs
	docker-compose -f ./containers/kafka/compose.yml logs;

# --------------------------------------------------------- #

##@ Gen

.PHONY: gen-dummies
gen-dummies: ## Generate sql dummies for this project
	go run ./cmd/devtools generate dummies
