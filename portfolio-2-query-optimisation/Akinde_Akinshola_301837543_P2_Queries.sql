-- Show related baggage_claim, passenger, flight, claim_type records (up to 20).
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

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
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

-- Find baggage_claim records where submitted_at matches "2026-10-12T14:30:00Z" (up to 20).
SELECT * FROM portfolio."baggage_claim"
WHERE "submitted_at" IS NOT DISTINCT FROM '2026-10-12T14:30:00Z'
ORDER BY "claim_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."baggage_claim"
WHERE "submitted_at" IS NOT DISTINCT FROM '2026-10-12T14:30:00Z'
ORDER BY "claim_id"
LIMIT 20;

-- Count baggage_claim records for each passenger_id (up to 20 groups).
SELECT "passenger_id", count(*) AS record_count
FROM portfolio."baggage_claim"
GROUP BY "passenger_id"
ORDER BY record_count DESC, "passenger_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "passenger_id", count(*) AS record_count
FROM portfolio."baggage_claim"
GROUP BY "passenger_id"
ORDER BY record_count DESC, "passenger_id" NULLS LAST
LIMIT 20;
