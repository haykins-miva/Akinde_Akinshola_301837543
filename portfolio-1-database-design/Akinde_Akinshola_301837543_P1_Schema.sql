-- Baggage Service Claim Tracker: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."passenger" (
  "passenger_id" bigint NOT NULL,
  "passenger_label" text NOT NULL,
  "contact_email" text,
  CONSTRAINT "pk_passenger" PRIMARY KEY ("passenger_id")
);
CREATE TABLE portfolio."flight" (
  "flight_id" bigint NOT NULL,
  "flight_code" text NOT NULL,
  "departure_date" date NOT NULL,
  "origin_code" text NOT NULL,
  "destination_code" text NOT NULL,
  CONSTRAINT "pk_flight" PRIMARY KEY ("flight_id"),
  CONSTRAINT "uq_flight_0" UNIQUE ("flight_code", "departure_date")
);
CREATE TABLE portfolio."claim_type" (
  "claim_type_id" bigint NOT NULL,
  "type_code" text NOT NULL,
  "description" text NOT NULL,
  CONSTRAINT "pk_claim_type" PRIMARY KEY ("claim_type_id"),
  CONSTRAINT "uq_claim_type_0" UNIQUE ("type_code")
);
CREATE TABLE portfolio."baggage_claim" (
  "claim_id" bigint NOT NULL,
  "claim_reference" text NOT NULL,
  "passenger_id" bigint NOT NULL,
  "flight_id" bigint NOT NULL,
  "claim_type_id" bigint NOT NULL,
  "claimed_bag_count" bigint NOT NULL,
  "submitted_at" timestamptz NOT NULL,
  CONSTRAINT "pk_baggage_claim" PRIMARY KEY ("claim_id"),
  CONSTRAINT "uq_baggage_claim_0" UNIQUE ("claim_reference")
);
ALTER TABLE portfolio."baggage_claim" ADD CONSTRAINT "fk_baggage_claim_0" FOREIGN KEY ("passenger_id") REFERENCES portfolio."passenger" ("passenger_id");
ALTER TABLE portfolio."baggage_claim" ADD CONSTRAINT "fk_baggage_claim_1" FOREIGN KEY ("flight_id") REFERENCES portfolio."flight" ("flight_id");
ALTER TABLE portfolio."baggage_claim" ADD CONSTRAINT "fk_baggage_claim_2" FOREIGN KEY ("claim_type_id") REFERENCES portfolio."claim_type" ("claim_type_id");
ALTER TABLE portfolio."baggage_claim" ADD CONSTRAINT "bag_count_nonnegative" CHECK ("claimed_bag_count" >= 0);
COMMIT;
