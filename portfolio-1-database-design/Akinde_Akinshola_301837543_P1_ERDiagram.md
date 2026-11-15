# Baggage Service Claim Tracker — ER diagram

```mermaid
erDiagram
    direction LR
    passenger {
        bigint passenger_id PK
        text passenger_label
        text contact_email "Optional"
    }
    flight {
        bigint flight_id PK
        text flight_code
        date departure_date
        text origin_code
        text destination_code
    }
    claim_type {
        bigint claim_type_id PK
        text type_code UK
        text description
    }
    baggage_claim {
        bigint claim_id PK
        text claim_reference UK
        bigint passenger_id FK
        bigint flight_id FK
        bigint claim_type_id FK
        integer claimed_bag_count
        timestamptz submitted_at
    }
    passenger ||--o{ baggage_claim : "passenger_id"
    flight ||--o{ baggage_claim : "flight_id"
    claim_type ||--o{ baggage_claim : "claim_type_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Akinde_Akinshola_301837543_ERDiagram.png)
