# Baggage Service Claim Tracker — database design

My case study records passenger, flight, claim_type, baggage_claim.

## Users

- Claims clerks submitting and reviewing baggage claims
- Service managers reviewing claim volumes

## Main operations

- Create a claim and record its submission time in one transaction
- Find claims for a flight, claim type, or submission-date range
- Count claims by flight and claim type

## Entities

| Entity | Information stored |
| --- | --- |
| passenger | A synthetic passenger associated with baggage claims. |
| flight | A scheduled flight associated with baggage claims. |
| claim_type | A category used to classify a baggage claim. |
| baggage_claim | A claim record linking one passenger, one flight, and one claim type with its bag count and submission time. |

## passenger

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| passenger_id | BIGINT | PK | Yes |
| passenger_label | TEXT |  | Yes |
| contact_email | TEXT |  | No |


## flight

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| flight_id | BIGINT | PK | Yes |
| flight_code | TEXT |  | Yes |
| departure_date | DATE |  | Yes |
| origin_code | TEXT |  | Yes |
| destination_code | TEXT |  | Yes |
- Unique key: (flight_code, departure_date).

## claim_type

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| claim_type_id | BIGINT | PK | Yes |
| type_code | TEXT | Unique | Yes |
| description | TEXT |  | Yes |
- Unique key: (type_code).

## baggage_claim

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| claim_id | BIGINT | PK | Yes |
| claim_reference | TEXT | Unique | Yes |
| passenger_id | BIGINT | FK | Yes |
| flight_id | BIGINT | FK | Yes |
| claim_type_id | BIGINT | FK | Yes |
| claimed_bag_count | INTEGER |  | Yes |
| submitted_at | TIMESTAMPTZ |  | Yes |
- passenger_id → passenger.passenger_id
- flight_id → flight.flight_id
- claim_type_id → claim_type.claim_type_id
- Unique key: (claim_reference).

## Relationships and business rules

- Each claim reference identifies at most one baggage claim.
- claimed_bag_count must be greater than or equal to zero, enforced by a single-row CHECK on baggage_claim.
- Every baggage claim must reference an existing passenger.
- Every baggage claim must reference an existing flight.
- Every baggage claim must reference an existing claim type.

## Assumptions

- All primary keys are single-column identifiers generated as globally unique UUIDs.
- A claim reference is generated for each claim and must be unique; concurrent attempts to use the same reference allow only one claim to be recorded.
- A claim references exactly one passenger, flight, and claim type.
- claimed_bag_count is a whole-number count and must be nonnegative; its rule is enforced by a single-row CHECK on BaggageClaim.
- submitted_at records the submission time in UTC and is written with the claim in the same transaction.
- A flight is identified by its flight code and departure date together.
- The MongoDB event document captures the related passenger, flight, and claim type as they were represented when the event was recorded.

