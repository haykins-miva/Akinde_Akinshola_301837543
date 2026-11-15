# Baggage Service Claim Tracker — SQL queries

## 1. Show related baggage_claim, passenger, flight, claim_type records (up to 20).

```sql
SELECT t0."claim_id" AS "baggage_claim_claim_id",
       t0."claim_reference" AS "baggage_claim_claim_reference",
       t1."passenger_id" AS "passenger_passenger_id",
       t1."passenger_label" AS "passenger_passenger_label",
       t2."flight_id" AS "flight_flight_id",
       t2."flight_code" AS "flight_flight_code",
       t3."claim_type_id" AS "claim_type_claim_type_id",
       t3."type_code" AS "claim_type_type_code"
FROM portfolio."baggage_claim" t0
JOIN portfolio."passenger" t1 ON t0."passenger_id" = t1."passenger_id"
JOIN portfolio."flight" t2 ON t0."flight_id" = t2."flight_id"
JOIN portfolio."claim_type" t3 ON t0."claim_type_id" = t3."claim_type_id"
ORDER BY t0."claim_id", t1."passenger_id", t2."flight_id", t3."claim_type_id"
LIMIT 20;
```

| baggage_claim_claim_id | baggage_claim_claim_reference | passenger_passenger_id | passenger_passenger_label | flight_flight_id | flight_flight_code | claim_type_claim_type_id | claim_type_type_code |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 401 | CLM-2026-001 | 101 | Passenger Alpha | 201 | ZX101 | 301 | DELAYED |
| 402 | CLM-2026-002 | 102 | Passenger Beta | 202 | ZX202 | 302 | DAMAGED |

## 2. Find baggage_claim records where submitted_at matches "2026-10-12T14:30:00Z" (up to 20).

```sql
SELECT * FROM portfolio."baggage_claim"
WHERE "submitted_at" IS NOT DISTINCT FROM '2026-10-12T14:30:00Z'
ORDER BY "claim_id"
LIMIT 20;
```

| claim_id | claim_reference | passenger_id | flight_id | claim_type_id | claimed_bag_count | submitted_at |
| --- | --- | --- | --- | --- | --- | --- |
| 401 | CLM-2026-001 | 101 | 201 | 301 | 1 | 2026-10-12T14:30:00+00:00 |

## 3. Count baggage_claim records for each passenger_id (up to 20 groups).

```sql
SELECT "passenger_id", count(*) AS record_count
FROM portfolio."baggage_claim"
GROUP BY "passenger_id"
ORDER BY record_count DESC, "passenger_id" NULLS LAST
LIMIT 20;
```

| passenger_id | record_count |
| --- | --- |
| 101 | 1 |
| 102 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 1.229 | 1.229, 1.828, 1.199 | Sort → Seq Scan | 139 |
| After index | 0.197 | 0.197, 0.212, 0.194 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 30 |

The median execution time changed from 1.229 ms to 0.197 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=1.2..1.202 rows=25 loops=1)
  Seq Scan on baggage_claim (actual time=0.016..1.167 rows=25 loops=1)
Planning Time: 0.322 ms
Execution Time: 1.229 ms
```

### Before index, run 2

```text
Sort (actual time=1.79..1.792 rows=25 loops=1)
  Seq Scan on baggage_claim (actual time=0.019..1.747 rows=25 loops=1)
Planning Time: 0.411 ms
Execution Time: 1.828 ms
```

### Before index, run 3

```text
Sort (actual time=1.171..1.173 rows=25 loops=1)
  Seq Scan on baggage_claim (actual time=0.016..1.138 rows=25 loops=1)
Planning Time: 0.322 ms
Execution Time: 1.199 ms
```

### After index, run 1

```text
Sort (actual time=0.139..0.141 rows=25 loops=1)
  Bitmap Heap Scan on baggage_claim (actual time=0.031..0.105 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.017..0.018 rows=25 loops=1)
Planning Time: 0.502 ms
Execution Time: 0.197 ms
```

### After index, run 2

```text
Sort (actual time=0.152..0.154 rows=25 loops=1)
  Bitmap Heap Scan on baggage_claim (actual time=0.032..0.117 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.018..0.018 rows=25 loops=1)
Planning Time: 0.518 ms
Execution Time: 0.212 ms
```

### After index, run 3

```text
Sort (actual time=0.136..0.138 rows=25 loops=1)
  Bitmap Heap Scan on baggage_claim (actual time=0.031..0.102 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.017..0.017 rows=25 loops=1)
Planning Time: 0.501 ms
Execution Time: 0.194 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Akinde_Akinshola_301837543_P2_Queries.sql, then Akinde_Akinshola_301837543_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Akinde_Akinshola_301837543_P2_QueryResults.png) · [Index comparison](screenshots/Akinde_Akinshola_301837543_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

