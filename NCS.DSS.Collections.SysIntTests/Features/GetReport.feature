Feature: GetReport


Scenario: Get a report for invalid collection
		Given I have an invalid collection id
		When I get the report
		Then there should be a 204 response

Scenario: Get a report which isnt ready
		Given I post a report request for ukprn 12345678
		When I get the report
		Then there should be a 204 response

Scenario: Get a report which is ready
		Given I post a report request for ukprn 12345678
		And a report is loaded into storage
		When I get the report
		Then there should be a 200 response