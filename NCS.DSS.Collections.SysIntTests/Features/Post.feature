Feature: Post


Scenario: Post a new report request with valid fields
		Given I post a report request for ukprn 12345678
		Then there should be a 201 response
##		And a document should exist in cosmosDb


Scenario: Post a new report request with invalid data
		Given I post a report request for ukprn 12345
		Then there should be a 422 response
		
Scenario: Post a new report request with missing data
		Given I post a report request with missing ukprn
		Then there should be a 422 response

