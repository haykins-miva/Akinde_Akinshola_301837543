# Portfolio 1 — Database Design and Modelling

I organised the data into passenger, flight, claim_type, baggage_claim. The design document explains the fields, keys, relationships and business rules. The normalisation document shows the sample tables at 1NF, 2NF and 3NF.

## Database checks

| Table | Rows |
| --- | --- |
| passenger | 2 |
| flight | 2 |
| claim_type | 2 |
| baggage_claim | 2 |

The 28 invalid inserts were rejected at their expected constraints, and the valid sample rows remained unchanged.

## Files

- [Design](Akinde_Akinshola_301837543_P1_Design.md)
- [ER diagram](Akinde_Akinshola_301837543_P1_ERDiagram.md)
- [Normalisation](Akinde_Akinshola_301837543_P1_Normalisation.md)
- [Schema](Akinde_Akinshola_301837543_P1_Schema.sql)
- [Sample data](Akinde_Akinshola_301837543_P1_SampleData.sql)
- [Constraint tests](Akinde_Akinshola_301837543_P1_ConstraintTests.sql)
- [Table and constraint evidence](screenshots/Akinde_Akinshola_301837543_P1_DatabaseResults.png)

## Run the SQL

Create a fresh PostgreSQL database. Run the schema first, then the sample data. Run the deliberately invalid statements in ConstraintTests.sql individually outside a transaction; each is expected to produce an error.

## References

- [PostgreSQL — constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)

