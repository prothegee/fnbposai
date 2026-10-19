# FnB POS AI

A FnB POS AI Powered project.

<br>

# Table of contents

- [Capabilities](/#capabilities)
- [Getting Started](/#getting-started)

<br>

---

## Capabilities

TBA
<!--
[ ] Single tenant with multi branch.
[ ] Offline capability when internet down.
[ ] Multi taxes for branch customer orders.
[ ] Kitchen & Bar monitoring process for orders.
[ ] AI assist for image generation and description.
[ ] Multi registers/cashiers for high trafic store orders.
[ ] Auto deduct stock when order created with items builder.
-->

<br>

---

## Getting Started

TBA

<br>

---

## Backend

### Account

TBA

<br>

---

### AI

__*Project Directory:*__ `fnbposai-be-ai`.

<br>

__*IMPORTANTS:*__

- Don't expose to public facing.
- Stable diffusion server currently don't have allow origin cli args.

<br>

#### Llama Cpp

Repo: https://github.com/ggml-org/llama.cpp

Ports: [9931].

<br>

#### Stable Diffusion Cpp
Repo: https://github.com/leejet/stable-diffusion.cpp

Ports: [1234].

Notes:
- Currently auto generate image is simple prompt,
  in the future, the AI Generate button should show the prompt for the actual input.

<br>

#### MCP SearXNG

Repo: https://github.com/searxng/searxng

Ports: [8080].

<br>

---

### Gateway

TBA

<br>

---

### Media

TBA

<br>

---

### POS

TBA

<br>

---

### Tenant

TBA

<br>

---

## Frontend

### POS Client

TBA

<br>

---

## Database

### SQL

__*Engine:*__ `PostgreSQL 18.x`.

<br>

__*Project Directory:*__ `containers/postgresql`.

<br>

__*Init Container Entries Dir:*__ `containers/postgres-primary/init`.

<br>

__*Verify Dummies Data:*__

Required to run `make gen-dummies` and make sure the postgres primary and replica is up.<br>
[See Makefile](./Makefile) for reference command.

```sql
\pset pager off

select
    pi.name                         as item_name,
    poi.quantity,
    poi.price_at_order,
    pop.method                      as payment_method,
    pop.paid_at
from pos_orders_payments pop
join pos_orders          po  on po.id        = pop.id_order
join pos_orders_items    poi on poi.id_order = pop.id_order
join pos_items           pi  on pi.id        = poi.id_item
where pop.status = 'paid'
  and pop.paid_at >= date_trunc('month', current_date - interval '1 month')
  and pop.paid_at <  now()
  and po.id_tenant         = '01a14e6f-ab53-74d4-af99-f9e541108ba0'
  and po.id_tenant_branch  = '01a14e70-c4b6-70bb-b65a-899d4a53fc9d'
order by pop.paid_at desc;

-- expect 389 rows
```

```sql
select method, count(*), sum(total)
from pos_orders_payments
group by method
order by method;

-- expect 4 rows
```

<br>

__*IMPORTANTS:*__

- Primary for write replica for read.
- All database initialization happen on the the database.
- Don't add complexity handle initialize from backend service/s.
- Never use `select * ...`. Limit your query, pick what's important.
- All service/s that interact with database handle the logic and type checking only.

<br>

---

### NoSQL

__*Engine:*__ `Redis 8.x`.

<br>

__*Project Directory:*__ `containers/redis`.

<br>

__*IMPORTANTS:*__

- TTL always use jitter.

<br>

---

## Broker/Stream

### Kafka

__*Engine:*__ `Kafka 4.x`.

<br>

__*Project Directory:*__ `containers/kafka`.

<br>

__*IMPORTANTS:*__

- Only gateway who consume what produced.

<br>

---

## Systems Flowchart

```mermaid
flowchart LR
    Browser["Browser"]
    Mobile["Mobile"]
    Desktop["Desktop"]

    Gateway{{"Gateway"}}
    Media["Media"]

    Account{{"Account"}}
    Tenant{{"Tenant"}}
    POS{{"POS"}}

    PostgresPrimary[("PostgresSQL Primary")]
    PostgresReplica[("PostgresSQL Replica")]
    Redis[("Redis")]

    Kafka["Kafka"]

    LlamaCppServer["LLama Cpp Server"]
    StableDiffusionServer["Stable Diffusion Server"]
    MCPSearXNG["MCP: SearXNG"]

    %% --------------------------------------------------------- %%

    subgraph Clients["Clients"]
        Browser
        Mobile
        Desktop
    end

    subgraph Services["Services"]
        Account
        Tenant
        POS
    end

    subgraph Databases["Databases"]
        PostgresPrimary
        PostgresReplica
        Redis
    end

    subgraph Streams["Streams"]
        Kafka
    end

    subgraph AIs["AIs"]
        LlamaCppServer
        StableDiffusionServer
        MCPSearXNG
    end


    subgraph Public["Public"]
        Gateway
        Media
    end

    subgraph Internal["Internal"]
        Services
        Databases
        Streams
        AIs
    end

    %% --------------------------------------------------------- %%

    Clients <---> |"HTTP/REST/SSE"| Gateway
    Clients <---> |"HTTP"| Media

    Gateway <---> |"gRPC"| Account
    Gateway <---> |"gRPC"| Tenant
    Gateway <---> |"gRPC"| POS
    Gateway <-.-> |"REST"| LlamaCppServer
    Gateway <-.-> |"REST"| StableDiffusionServer

    Account -.- |"READ"| PostgresReplica
    Account -.- |"WRITE"| PostgresPrimary
    Account -.- |"READ/WRITE"| Redis
    Account -.-> |"gRPC"| Media

    Tenant -.- |"READ"| PostgresReplica
    Tenant -.- |"WRITE"| PostgresPrimary
    Tenant -.-> |"gRPC"| Media

    POS -.- |"READ"| PostgresReplica
    POS -.- |"WRITE"| PostgresPrimary
    POS -.-> |"gRPC"| Media

        Account <-.-> |"gRPC"| Tenant
        Account <-.-> |"gRPC"| POS
        POS <-.-> |"gRPC"| Tenant

    POS -.-> |"Produce"| Kafka

    PostgresPrimary -.-> |"SYNC"| PostgresReplica

    Kafka -.-> |"Consume"| Gateway

    LlamaCppServer <-.-> MCPSearXNG
```

<br>

---

###### end of readme
