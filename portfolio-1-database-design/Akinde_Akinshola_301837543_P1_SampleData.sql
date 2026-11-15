-- Fictional sample records for Baggage Service Claim Tracker.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."passenger" ("passenger_id", "passenger_label", "contact_email") VALUES (101, 'Passenger Alpha', 'alpha@example.test');
INSERT INTO portfolio."passenger" ("passenger_id", "passenger_label", "contact_email") VALUES (102, 'Passenger Beta', NULL);
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "departure_date", "origin_code", "destination_code") VALUES (201, 'ZX101', '2026-10-12', 'JFK', 'LAX');
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "departure_date", "origin_code", "destination_code") VALUES (202, 'ZX202', '2026-10-13', 'SEA', 'ORD');
INSERT INTO portfolio."claim_type" ("claim_type_id", "type_code", "description") VALUES (301, 'DELAYED', 'Delayed baggage');
INSERT INTO portfolio."claim_type" ("claim_type_id", "type_code", "description") VALUES (302, 'DAMAGED', 'Damaged baggage');
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at") VALUES (401, 'CLM-2026-001', 101, 201, 301, 1, '2026-10-12T14:30:00Z');
INSERT INTO portfolio."baggage_claim" ("claim_id", "claim_reference", "passenger_id", "flight_id", "claim_type_id", "claimed_bag_count", "submitted_at") VALUES (402, 'CLM-2026-002', 102, 202, 302, 2, '2026-10-13T09:15:00+00:00');
COMMIT;
