# Baggage Service Claim Tracker — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| passenger_id | baggage_claim records (list) |
| --- | --- |
| 101 | [401] |
| 102 | [402] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| baggage_claim.claim_id | baggage_claim.claim_reference | baggage_claim.passenger_id | baggage_claim.flight_id | baggage_claim.claim_type_id | passenger.passenger_id | passenger.passenger_label | flight.flight_id |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 401 | CLM-2026-001 | 101 | 201 | 301 | 101 | Passenger Alpha | 201 |
| 402 | CLM-2026-002 | 102 | 202 | 302 | 102 | Passenger Beta | 202 |

Key: claim_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## baggage_claim_example

| baggage_claim.claim_id | baggage_claim.claim_reference | baggage_claim.passenger_id | baggage_claim.flight_id | baggage_claim.claim_type_id | passenger.passenger_id | passenger.passenger_label | flight.flight_id |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 401 | CLM-2026-001 | 101 | 201 | 301 | 101 | Passenger Alpha | 201 |
| 402 | CLM-2026-002 | 102 | 202 | 302 | 102 | Passenger Beta | 202 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## passenger

| passenger_id | passenger_label | contact_email |
| --- | --- | --- |
| 101 | Passenger Alpha | alpha@example.test |
| 102 | Passenger Beta | NULL |

## flight

| flight_id | flight_code | departure_date | origin_code | destination_code |
| --- | --- | --- | --- | --- |
| 201 | ZX101 | 2026-10-12 | JFK | LAX |
| 202 | ZX202 | 2026-10-13 | SEA | ORD |

## claim_type

| claim_type_id | type_code | description |
| --- | --- | --- |
| 301 | DELAYED | Delayed baggage |
| 302 | DAMAGED | Damaged baggage |

## baggage_claim

| claim_id | claim_reference | passenger_id | flight_id | claim_type_id | claimed_bag_count | submitted_at |
| --- | --- | --- | --- | --- | --- | --- |
| 401 | CLM-2026-001 | 101 | 201 | 301 | 1 | 2026-10-12T14:30:00+00:00 |
| 402 | CLM-2026-002 | 102 | 202 | 302 | 2 | 2026-10-13T09:15:00+00:00 |

## Dependencies

- passenger: (passenger_id) → passenger_label, contact_email
- flight: (flight_id) → flight_code, departure_date, origin_code, destination_code
- claim_type: (claim_type_id) → type_code, description
- baggage_claim: (claim_id) → claim_reference, passenger_id, flight_id, claim_type_id, claimed_bag_count, submitted_at

Joining the decomposed sample tables reproduces the original 2 example rows. The design assumes the declared keys describe the relevant business dependencies.
