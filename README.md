# license_changer
A simple license changer script for FiveM.

# Usage
`/change <fromId> <toId> <*tableName> ...`

Passing a table name is optional.
Any number of table names can be passed.
If no table name is passed, all of the configured `DB_SCHEMA` will be used.

# Examples
`/change license:1234 license:2345`
`/change license:1234 license:2345 players`
`/change license:1234 license:2345 players characters owned_vehicles`

# Dependencies
- oxmysql