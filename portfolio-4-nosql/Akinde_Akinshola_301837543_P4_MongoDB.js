// Run once in mongosh against a fresh exercise database.
// These records are fictional events for the case study.
(async function () {
  db = db.getSiblingDB('portfolio_nosql');
  if ((await db.getCollectionNames()).includes("claim_events")) {
    throw new Error('The exercise collection already exists. Use a fresh database.');
  }

  // The validator checks the stable event fields while details can vary.
  await db.createCollection("claim_events", {
    validator: {
    "$jsonSchema": {
        "bsonType": "object",
        "required": [
            "_id",
            "schemaVersion",
            "simulation",
            "eventType",
            "occurredAt",
            "source",
            "embedded",
            "references",
            "details"
        ],
        "properties": {
            "_id": {
                "bsonType": "string",
                "minLength": 1
            },
            "schemaVersion": {
                "enum": [
                    1
                ]
            },
            "simulation": {
                "enum": [
                    true
                ]
            },
            "eventType": {
                "bsonType": "string",
                "enum": [
                    "claim_submitted",
                    "claim_amended"
                ]
            },
            "occurredAt": {
                "bsonType": "date"
            },
            "source": {
                "bsonType": "object",
                "required": [
                    "entity",
                    "key",
                    "snapshot"
                ],
                "properties": {
                    "entity": {
                        "enum": [
                            "baggage_claim"
                        ]
                    },
                    "key": {
                        "bsonType": "object",
                        "required": [
                            "claim_id"
                        ]
                    },
                    "snapshot": {
                        "bsonType": "object"
                    }
                }
            },
            "embedded": {
                "bsonType": "object"
            },
            "references": {
                "bsonType": "object"
            },
            "details": {
                "bsonType": "object"
            }
        }
    }
},
    validationLevel: 'strict', validationAction: 'error'
  });

  // Insert the four example events and show their IDs.
  printjson(await db.getCollection("claim_events").insertMany([
    {
        "_id": "event_000001",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "claim_submitted",
        "occurredAt": ISODate("2030-01-01T10:00:00Z"),
        "source": {
            "entity": "baggage_claim",
            "key": {
                "claim_id": 401
            },
            "snapshot": {
                "claim_id": 401,
                "claim_reference": "CLM-2026-001",
                "passenger_id": 101,
                "flight_id": 201,
                "claim_type_id": 301,
                "claimed_bag_count": 1,
                "submitted_at": "2026-10-12T14:30:00Z"
            }
        },
        "embedded": {
            "passenger": [
                {
                    "key": {
                        "passenger_id": 101
                    },
                    "snapshot": {
                        "passenger_id": 101,
                        "passenger_label": "Passenger Alpha",
                        "contact_email": "alpha@example.test"
                    },
                    "via": [
                        "baggage_claim.passenger_id → passenger"
                    ]
                }
            ],
            "flight": [
                {
                    "key": {
                        "flight_id": 201
                    },
                    "snapshot": {
                        "flight_id": 201,
                        "flight_code": "ZX101",
                        "departure_date": "2026-10-12",
                        "origin_code": "JFK",
                        "destination_code": "LAX"
                    },
                    "via": [
                        "baggage_claim.flight_id → flight"
                    ]
                }
            ],
            "claim_type": [
                {
                    "key": {
                        "claim_type_id": 301
                    },
                    "snapshot": {
                        "claim_type_id": 301,
                        "type_code": "DELAYED",
                        "description": "Delayed baggage"
                    },
                    "via": [
                        "baggage_claim.claim_type_id → claim_type"
                    ]
                }
            ]
        },
        "references": {},
        "details": {
            "channel": "web"
        }
    },
    {
        "_id": "event_000002",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "claim_amended",
        "occurredAt": ISODate("2030-01-01T10:01:00Z"),
        "source": {
            "entity": "baggage_claim",
            "key": {
                "claim_id": 401
            },
            "snapshot": {
                "claim_id": 401,
                "claim_reference": "CLM-2026-001",
                "passenger_id": 101,
                "flight_id": 201,
                "claim_type_id": 301,
                "claimed_bag_count": 1,
                "submitted_at": "2026-10-12T14:30:00Z"
            }
        },
        "embedded": {
            "passenger": [
                {
                    "key": {
                        "passenger_id": 101
                    },
                    "snapshot": {
                        "passenger_id": 101,
                        "passenger_label": "Passenger Alpha",
                        "contact_email": "alpha@example.test"
                    },
                    "via": [
                        "baggage_claim.passenger_id → passenger"
                    ]
                }
            ],
            "flight": [
                {
                    "key": {
                        "flight_id": 201
                    },
                    "snapshot": {
                        "flight_id": 201,
                        "flight_code": "ZX101",
                        "departure_date": "2026-10-12",
                        "origin_code": "JFK",
                        "destination_code": "LAX"
                    },
                    "via": [
                        "baggage_claim.flight_id → flight"
                    ]
                }
            ],
            "claim_type": [
                {
                    "key": {
                        "claim_type_id": 301
                    },
                    "snapshot": {
                        "claim_type_id": 301,
                        "type_code": "DELAYED",
                        "description": "Delayed baggage"
                    },
                    "via": [
                        "baggage_claim.claim_type_id → claim_type"
                    ]
                }
            ]
        },
        "references": {},
        "details": {
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "change_reason": "illustrative change_reason",
                "agent_note": "illustrative agent_note"
            }
        }
    },
    {
        "_id": "event_000003",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "claim_submitted",
        "occurredAt": ISODate("2030-01-01T10:02:00Z"),
        "source": {
            "entity": "baggage_claim",
            "key": {
                "claim_id": 402
            },
            "snapshot": {
                "claim_id": 402,
                "claim_reference": "CLM-2026-002",
                "passenger_id": 102,
                "flight_id": 202,
                "claim_type_id": 302,
                "claimed_bag_count": 2,
                "submitted_at": "2026-10-13T09:15:00+00:00"
            }
        },
        "embedded": {
            "passenger": [
                {
                    "key": {
                        "passenger_id": 102
                    },
                    "snapshot": {
                        "passenger_id": 102,
                        "passenger_label": "Passenger Beta",
                        "contact_email": null
                    },
                    "via": [
                        "baggage_claim.passenger_id → passenger"
                    ]
                }
            ],
            "flight": [
                {
                    "key": {
                        "flight_id": 202
                    },
                    "snapshot": {
                        "flight_id": 202,
                        "flight_code": "ZX202",
                        "departure_date": "2026-10-13",
                        "origin_code": "SEA",
                        "destination_code": "ORD"
                    },
                    "via": [
                        "baggage_claim.flight_id → flight"
                    ]
                }
            ],
            "claim_type": [
                {
                    "key": {
                        "claim_type_id": 302
                    },
                    "snapshot": {
                        "claim_type_id": 302,
                        "type_code": "DAMAGED",
                        "description": "Damaged baggage"
                    },
                    "via": [
                        "baggage_claim.claim_type_id → claim_type"
                    ]
                }
            ]
        },
        "references": {},
        "details": {
            "channel": "web"
        }
    },
    {
        "_id": "event_000004",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "claim_amended",
        "occurredAt": ISODate("2030-01-01T10:03:00Z"),
        "source": {
            "entity": "baggage_claim",
            "key": {
                "claim_id": 402
            },
            "snapshot": {
                "claim_id": 402,
                "claim_reference": "CLM-2026-002",
                "passenger_id": 102,
                "flight_id": 202,
                "claim_type_id": 302,
                "claimed_bag_count": 2,
                "submitted_at": "2026-10-13T09:15:00+00:00"
            }
        },
        "embedded": {
            "passenger": [
                {
                    "key": {
                        "passenger_id": 102
                    },
                    "snapshot": {
                        "passenger_id": 102,
                        "passenger_label": "Passenger Beta",
                        "contact_email": null
                    },
                    "via": [
                        "baggage_claim.passenger_id → passenger"
                    ]
                }
            ],
            "flight": [
                {
                    "key": {
                        "flight_id": 202
                    },
                    "snapshot": {
                        "flight_id": 202,
                        "flight_code": "ZX202",
                        "departure_date": "2026-10-13",
                        "origin_code": "SEA",
                        "destination_code": "ORD"
                    },
                    "via": [
                        "baggage_claim.flight_id → flight"
                    ]
                }
            ],
            "claim_type": [
                {
                    "key": {
                        "claim_type_id": 302
                    },
                    "snapshot": {
                        "claim_type_id": 302,
                        "type_code": "DAMAGED",
                        "description": "Damaged baggage"
                    },
                    "via": [
                        "baggage_claim.claim_type_id → claim_type"
                    ]
                }
            ]
        },
        "references": {},
        "details": {
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "change_reason": "illustrative change_reason",
                "agent_note": "illustrative agent_note"
            }
        }
    }
]));
  await db.getCollection("claim_events").createIndex({eventType: 1, occurredAt: -1}, {name: 'event_type_time'});

  // 1. Find the first sample event type (up to five documents).
  printjson(await db.getCollection("claim_events").find({"eventType":"claim_submitted"}).sort({_id:1}).limit(5).toArray());

  // 2. Find events for the first source record using nested key fields (up to five).
  printjson(await db.getCollection("claim_events").find({"source.key.claim_id":401}).sort({_id:1}).limit(5).toArray());

  // 3. Find events in the sample time range using a MongoDB Date filter (up to five).
  printjson(await db.getCollection("claim_events").find({"occurredAt":{"$gte":ISODate("2030-01-01T10:00:00Z"), "$lt":ISODate("2030-01-01T11:00:00Z")}}).sort({_id:1}).limit(5).toArray());

  // 4. Count documents for each event type.
  printjson(await db.getCollection("claim_events").aggregate([{"$group":{"_id":"$eventType", "documentCount":{"$sum":1}}}, {"$sort":{"_id":1}}]).toArray());

  // A date stored as text should be rejected by the validator.
  try {
    await db.getCollection("claim_events").insertOne({...{
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "claim_submitted",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "baggage_claim",
        "key": {
            "claim_id": 401
        },
        "snapshot": {
            "claim_id": 401,
            "claim_reference": "CLM-2026-001",
            "passenger_id": 101,
            "flight_id": 201,
            "claim_type_id": 301,
            "claimed_bag_count": 1,
            "submitted_at": "2026-10-12T14:30:00Z"
        }
    },
    "embedded": {
        "passenger": [
            {
                "key": {
                    "passenger_id": 101
                },
                "snapshot": {
                    "passenger_id": 101,
                    "passenger_label": "Passenger Alpha",
                    "contact_email": "alpha@example.test"
                },
                "via": [
                    "baggage_claim.passenger_id → passenger"
                ]
            }
        ],
        "flight": [
            {
                "key": {
                    "flight_id": 201
                },
                "snapshot": {
                    "flight_id": 201,
                    "flight_code": "ZX101",
                    "departure_date": "2026-10-12",
                    "origin_code": "JFK",
                    "destination_code": "LAX"
                },
                "via": [
                    "baggage_claim.flight_id → flight"
                ]
            }
        ],
        "claim_type": [
            {
                "key": {
                    "claim_type_id": 301
                },
                "snapshot": {
                    "claim_type_id": 301,
                    "type_code": "DELAYED",
                    "description": "Delayed baggage"
                },
                "via": [
                    "baggage_claim.claim_type_id → claim_type"
                ]
            }
        ]
    },
    "references": {},
    "details": {
        "channel": "web"
    }
}, _id: 'invalid_date_example', occurredAt: 'not-a-date'});
  } catch (error) { print('Invalid date error: ' + error.code); }

  // Reusing an event ID should be rejected by the unique _id index.
  try { await db.getCollection("claim_events").insertOne({
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "claim_submitted",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "baggage_claim",
        "key": {
            "claim_id": 401
        },
        "snapshot": {
            "claim_id": 401,
            "claim_reference": "CLM-2026-001",
            "passenger_id": 101,
            "flight_id": 201,
            "claim_type_id": 301,
            "claimed_bag_count": 1,
            "submitted_at": "2026-10-12T14:30:00Z"
        }
    },
    "embedded": {
        "passenger": [
            {
                "key": {
                    "passenger_id": 101
                },
                "snapshot": {
                    "passenger_id": 101,
                    "passenger_label": "Passenger Alpha",
                    "contact_email": "alpha@example.test"
                },
                "via": [
                    "baggage_claim.passenger_id → passenger"
                ]
            }
        ],
        "flight": [
            {
                "key": {
                    "flight_id": 201
                },
                "snapshot": {
                    "flight_id": 201,
                    "flight_code": "ZX101",
                    "departure_date": "2026-10-12",
                    "origin_code": "JFK",
                    "destination_code": "LAX"
                },
                "via": [
                    "baggage_claim.flight_id → flight"
                ]
            }
        ],
        "claim_type": [
            {
                "key": {
                    "claim_type_id": 301
                },
                "snapshot": {
                    "claim_type_id": 301,
                    "type_code": "DELAYED",
                    "description": "Delayed baggage"
                },
                "via": [
                    "baggage_claim.claim_type_id → claim_type"
                ]
            }
        ]
    },
    "references": {},
    "details": {
        "channel": "web"
    }
}); }
  catch (error) { print('Duplicate ID error: ' + error.code); }

  print('Document count: ' + await db.getCollection("claim_events").countDocuments());
})().catch(error => { print(error.stack || String(error)); quit(1); });
