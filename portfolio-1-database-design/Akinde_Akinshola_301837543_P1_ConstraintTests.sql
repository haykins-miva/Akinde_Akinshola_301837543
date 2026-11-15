-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. passenger pk. Expected: pk_passenger, SQLSTATE 23505.
INSERT INTO portfolio."passenger" ("passenger_id", "passenger_label", "contact_email")
VALUES (101, 'Duplicate passenger ID', 'duplicate-passenger@example.test');

-- 2. passenger id not null. Expected: passenger_id, SQLSTATE 23502.
INSERT INTO portfolio."passenger" ("passenger_id", "passenger_label", "contact_email")
VALUES (NULL, 'Passenger Null ID', 'null-id@example.test');

-- 3. passenger label not null. Expected: passenger_label, SQLSTATE 23502.
INSERT INTO portfolio."passenger" ("passenger_id", "passenger_label", "contact_email")
VALUES (9001, NULL, 'null-label@example.test');

-- 4. flight pk. Expected: pk_flight, SQLSTATE 23505.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "departure_date", "origin_code", "destination_code")
VALUES (201, 'ZX303', '2026-10-14', 'BOS', 'MIA');

-- 5. flight unique. Expected: uq_flight_0, SQLSTATE 23505.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "departure_date", "origin_code", "destination_code")
VALUES (9002, 'ZX101', '2026-10-12', 'BOS', 'MIA');

-- 6. flight id not null. Expected: flight_id, SQLSTATE 23502.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "departure_date", "origin_code", "destination_code")
VALUES (NULL, 'ZX304', '2026-10-14', 'BOS', 'MIA');

-- 7. flight code not null. Expected: flight_code, SQLSTATE 23502.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "departure_date", "origin_code", "destination_code")
VALUES (9003, NULL, '2026-10-14', 'BOS', 'MIA');

-- 8. flight date not null. Expected: departure_date, SQLSTATE 23502.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "departure_date", "origin_code", "destination_code")
VALUES (9004, 'ZX305', NULL, 'BOS', 'MIA');

-- 9. flight origin not null. Expected: origin_code, SQLSTATE 23502.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "departure_date", "origin_code", "destination_code")
VALUES (9005, 'ZX306', '2026-10-14', NULL, 'MIA');

-- 10. flight destination not null. Expected: destination_code, SQLSTATE 23502.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "departure_date", "origin_code", "destination_code")
VALUES (9006, 'ZX307', '2026-10-14', 'BOS', NULL);

-- 11. claim type pk. Expected: pk_claim_type, SQLSTATE 23505.
INSERT INTO portfolio."claim_type" ("claim_type_id", "type_code", "description")
VALUES (301, 'OTHER', 'Other baggage claim');

-- 12. claim type unique. Expected: uq_claim_type_0, SQLSTATE 23505.
INSERT INTO portfolio."claim_type" ("claim_type_id", "type_code", "description")
VALUES (9007, 'DELAYED', 'Alternate delayed baggage description');

-- 13. claim type id not null. Expected: claim_type_id, SQLSTATE 23502.
INSERT INTO portfolio."claim_type" ("claim_type_id", "type_code", "description")
VALUES (NULL, 'OTHER', 'Other baggage claim');

-- 14. claim type code not null. Expected: type_code, SQLSTATE 23502.
INSERT INTO portfolio."claim_type" ("claim_type_id", "type_code", "description")
VALUES (9008, NULL, 'Other baggage claim');

-- 15. claim type description not null. Expected: description, SQLSTATE 23502.
INSERT INTO portfolio."claim_type" ("claim_type_id", "type_code", "description")
VALUES (9009, 'OTHER', NULL);

-- 16. baggage claim pk. Expected: pk_baggage_claim, SQLSTATE 23505.
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at")
VALUES (401, 'CLM-2026-003', 101, 201, 301, 1, '2026-10-14T10:00:00Z');

-- 17. baggage claim unique. Expected: uq_baggage_claim_0, SQLSTATE 23505.
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at")
VALUES (9010, 'CLM-2026-001', 101, 201, 301, 1, '2026-10-14T10:05:00Z');

-- 18. baggage claim passenger fk. Expected: fk_baggage_claim_0, SQLSTATE 23503.
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at")
VALUES (9011, 'CLM-2026-011', 9901, 201, 301, 1, '2026-10-14T10:10:00Z');

-- 19. baggage claim flight fk. Expected: fk_baggage_claim_1, SQLSTATE 23503.
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at")
VALUES (9012, 'CLM-2026-012', 101, 9902, 301, 1, '2026-10-14T10:15:00Z');

-- 20. baggage claim type fk. Expected: fk_baggage_claim_2, SQLSTATE 23503.
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at")
VALUES (9013, 'CLM-2026-013', 101, 201, 9903, 1, '2026-10-14T10:20:00Z');

-- 21. claim id not null. Expected: claim_id, SQLSTATE 23502.
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at")
VALUES (NULL, 'CLM-2026-014', 101, 201, 301, 1, '2026-10-14T10:25:00Z');

-- 22. claim reference not null. Expected: claim_reference, SQLSTATE 23502.
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at")
VALUES (9015, NULL, 101, 201, 301, 1, '2026-10-14T10:30:00Z');

-- 23. claim passenger not null. Expected: passenger_id, SQLSTATE 23502.
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at")
VALUES (9016, 'CLM-2026-016', NULL, 201, 301, 1, '2026-10-14T10:35:00Z');

-- 24. claim flight not null. Expected: flight_id, SQLSTATE 23502.
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at")
VALUES (9017, 'CLM-2026-017', 101, NULL, 301, 1, '2026-10-14T10:40:00Z');

-- 25. claim type not null. Expected: claim_type_id, SQLSTATE 23502.
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at")
VALUES (9018, 'CLM-2026-018', 101, 201, NULL, 1, '2026-10-14T10:45:00Z');

-- 26. claim bag count not null. Expected: claimed_bag_count, SQLSTATE 23502.
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at")
VALUES (9019, 'CLM-2026-019', 101, 201, 301, NULL, '2026-10-14T10:50:00Z');

-- 27. claim submitted at not null. Expected: submitted_at, SQLSTATE 23502.
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at")
VALUES (9020, 'CLM-2026-020', 101, 201, 301, 1, NULL);

-- 28. baggage claim check. Expected: bag_count_nonnegative, SQLSTATE 23514.
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at")
VALUES (9021, 'CLM-2026-021', 101, 201, 301, -1, '2026-10-14T10:55:00Z');
