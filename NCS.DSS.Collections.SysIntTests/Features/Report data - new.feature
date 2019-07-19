@Collections
Feature: Report Data 2
	The ABCs will request a year to day report via a POST to an Rest API service

Background: 
		Given I am creating data in scenario context


Scenario:  Outcomes 12 or 13 months earlier

		Given I load test customer data for this feature:
			#Parent for ADDRESS in CUSTOMER
		| LoaderRef                       | TouchPoint | Title | GivenName | FamilyName    | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
		| TS_035_OUTCOME12MONTHEARLIER1   |            | 4     | Dan       | tsthiryfive   |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
		| TS_036_OUTCOME12MONTHEARLIER2   |            | 4     | Dan       | tsthirtysix   |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
		| TS_037_OUTCOME13MONTHEARLIER3   |            | 4     | Dan       | tsthirtyseven |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 

		And I load test address data for this feature:
		| LoaderRef                  | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 

		And I load test contact data for this feature:
		| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

		 And I load test interaction data for this feature
		#	#Parent for INTERACTION is CUSTOMER
		| LoaderRef                       | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
		| TS_035_OUTCOME12MONTHEARLIER1   |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_036_OUTCOME12MONTHEARLIER2   |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_037_OUTCOME13MONTHEARLIER3   |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

			And I load test session data for the feature
		| LoaderRef                       | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended    | ReasonForNonAttendance   | LastModifiedDate       | LastModifiedTouchpointId | 
		| TS_035_OUTCOME12MONTHEARLIER1   | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_036_OUTCOME12MONTHEARLIER2   | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_037_OUTCOME13MONTHEARLIER3   | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 

		And I load action plan data for the feature
		| LoaderRef                       | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
		| TS_035_OUTCOME12MONTHEARLIER1   | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
		| TS_036_OUTCOME12MONTHEARLIER2   | 1         |  2019-03-02T00:00:00Z  |  true                            |  2019-03-02T00:00:00Z   |  2019-03-02T00:00:00Z        | 1                        |  2019-03-02T00:00:00Z      | 1                |  looking for work26 | 
		| TS_037_OUTCOME13MONTHEARLIER3   | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 

		And I load outcome data for the feature
		| LoaderRef                       | ParentRef | OutcomeType | TouchPoint | ClaimedPriorityGroup | OutcomeClaimedDate     | OutcomeEffectiveDate   | 
		| TS_035_OUTCOME12MONTHEARLIER1   | 1         | 1           |            | 99                   |  2019-03-01T00:00:00Z  |  2019-03-01T00:00:00Z  | 
		| TS_035_OUTCOME12MONTHEARLIER1   | 1         | 1           |            | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
		| TS_036_OUTCOME12MONTHEARLIER2   | 1         | 2           |            | 1                    |  2019-03-02T00:00:00Z  |  2019-03-02T00:00:00Z  | 
		| TS_036_OUTCOME12MONTHEARLIER2   | 1         | 2           |            | 1                    |  2020-03-03T00:00:00Z  |  2020-03-02T00:00:00Z  | 
		| TS_037_OUTCOME13MONTHEARLIER3   | 1         | 3           |            | 2                    |  2019-03-03T00:00:00Z  |  2019-03-03T00:00:00Z  | 
		| TS_037_OUTCOME13MONTHEARLIER3   | 1         | 3           |            | 2                    |  2020-04-03T00:00:00Z  |  2020-04-03T00:00:00Z  | 



		And I have made any data fudging updates required
		And I have confirmed all test data is now in the backup data store
		And the report period start date is "2019-04-01"
		And the report period end date is "2020-03-31"
		And a request has been made and the report data is available

		When I check the report data
		Then Outcome 1 for test customer "TS_035_OUTCOME12MONTHEARLIER1" is not included in the report
		Then Outcome 2 for test customer "TS_035_OUTCOME12MONTHEARLIER1" is not included in the report
		Then Outcome 1 for test customer "TS_036_OUTCOME12MONTHEARLIER2" is not included in the report
		Then Outcome 2 for test customer "TS_036_OUTCOME12MONTHEARLIER2" is not included in the report
		Then Outcome 1 for test customer "TS_037_OUTCOME13MONTHEARLIER3" is not included in the report
		Then Outcome 2 for test customer "TS_037_OUTCOME13MONTHEARLIER3" is not included in the report
		
Scenario:  Outcomes less than 12 or 13 months earlier

		Given I load test customer data for this feature:
			#Parent for ADDRESS in CUSTOMER
		| LoaderRef                       | TouchPoint | Title | GivenName | FamilyName    | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
		| TS_038_OUTCOMELT12MONTHEARLIER1 |            | 4     | Dan       | tsthirtyeight |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
		| TS_039_OUTCOMELT12MONTHEARLIER2 |            | 4     | Dan       | tsthirtynine  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
		| TS_040_OUTCOMELT13MONTHEARLIER2 |            | 4     | Dan       | tsforty       |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 

		And I load test address data for this feature:
		| LoaderRef                  | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 

		And I load test contact data for this feature:
		| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

		 And I load test interaction data for this feature
		#	#Parent for INTERACTION is CUSTOMER
		| LoaderRef                       | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
		| TS_038_OUTCOMELT12MONTHEARLIER1 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_039_OUTCOMELT12MONTHEARLIER2 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_040_OUTCOMELT13MONTHEARLIER2 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-02-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

			And I load test session data for the feature
		| LoaderRef                       | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended    | ReasonForNonAttendance   | LastModifiedDate       | LastModifiedTouchpointId | 
		| TS_038_OUTCOMELT12MONTHEARLIER1 | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_039_OUTCOMELT12MONTHEARLIER2 | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_040_OUTCOMELT13MONTHEARLIER2 | 1         |  2019-02-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 

		And I load action plan data for the feature
		| LoaderRef                       | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
		| TS_038_OUTCOMELT12MONTHEARLIER1 | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
		| TS_039_OUTCOMELT12MONTHEARLIER2 | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
		| TS_040_OUTCOMELT13MONTHEARLIER2 | 1         |  2019-02-01T00:00:00Z  |  true                            |  2019-02-01T00:00:00Z   |  2019-02-01T00:00:00Z        | 1                        |  2019-02-01T00:00:00Z      | 1                |  looking for work26 | 

		And I load outcome data for the feature
		| LoaderRef                       | ParentRef | OutcomeType | TouchPoint | ClaimedPriorityGroup | OutcomeClaimedDate     | OutcomeEffectiveDate   | 
		| TS_038_OUTCOMELT12MONTHEARLIER1 | 1         | 1           |            | 99                   |  2019-03-02T00:00:00Z  |  2019-03-02T00:00:00Z  | 
		| TS_038_OUTCOMELT12MONTHEARLIER1 | 1         | 1           |            | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
		| TS_039_OUTCOMELT12MONTHEARLIER2 | 1         | 2           |            | 1                    |  2019-03-03T00:00:00Z  |  2019-03-03T00:00:00Z  | 
		| TS_039_OUTCOMELT12MONTHEARLIER2 | 1         | 2           |            | 1                    |  2020-03-03T00:00:00Z  |  2020-03-02T00:00:00Z  | 
		| TS_039_OUTCOMELT12MONTHEARLIER2 | 1         | 1           |            | 1                    |                        |                        | 
		| TS_039_OUTCOMELT12MONTHEARLIER2 | 1         | 1           |            | 1                    |  2020-03-02T00:00:00Z  |  2020-03-02T00:00:00Z  | 
		| TS_040_OUTCOMELT13MONTHEARLIER2 | 1         | 3           |            | 2                    |  2019-02-03T00:00:00Z  |  2019-02-03T00:00:00Z  | 
		| TS_040_OUTCOMELT13MONTHEARLIER2 | 1         | 3           |            | 2                    |  2020-03-03T00:00:00Z  |  2020-03-02T00:00:00Z  | 

		And I have made any data fudging updates required
		And I have confirmed all test data is now in the backup data store
		And the report period start date is "2019-04-01"
		And the report period end date is "2020-03-31"
		And a request has been made and the report data is available

		When I check the report data
		Then Outcome 1 for test customer "TS_038_OUTCOMELT12MONTHEARLIER1" is not included in the report
		Then Outcome 2 for test customer "TS_038_OUTCOMELT12MONTHEARLIER1" is not included in the report
		Then Outcome 1 for test customer "TS_039_OUTCOMELT12MONTHEARLIER2" is not included in the report
		Then Outcome 2 for test customer "TS_039_OUTCOMELT12MONTHEARLIER2" is not included in the report
		Then Outcome 1 for test customer "TS_040_OUTCOMELT13MONTHEARLIER2" is not included in the report
		Then Outcome 2 for test customer "TS_040_OUTCOMELT13MONTHEARLIER2" is not included in the report

Scenario:  Outcomes more than than 12 or 13 months earlier

		Given I load test customer data for this feature:
			#Parent for ADDRESS in CUSTOMER
		| LoaderRef                       | TouchPoint | Title | GivenName | FamilyName    | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
		| TS_041_OUTCOMEGT12MONTHEARLIER1 |            | 4     | Dan       | tsfortyone    |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
		| TS_042_OUTCOMEGT12MONTHEARLIER2 |            | 4     | Dan       | tsfortytwo    |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
		| TS_043_OUTCOMEGT13MONTHEARLIER3 |            | 4     | Dan       | tsfortythree  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 

		And I load test address data for this feature:
		| LoaderRef                  | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 

		And I load test contact data for this feature:
		| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

		 And I load test interaction data for this feature
		#	#Parent for INTERACTION is CUSTOMER
		| LoaderRef                       | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
		| TS_041_OUTCOMEGT12MONTHEARLIER1 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_042_OUTCOMEGT12MONTHEARLIER2 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_043_OUTCOMEGT13MONTHEARLIER3 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-01-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

			And I load test session data for the feature
		| LoaderRef                       | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended    | ReasonForNonAttendance   | LastModifiedDate       | LastModifiedTouchpointId | 
		| TS_041_OUTCOMEGT12MONTHEARLIER1 | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_042_OUTCOMEGT12MONTHEARLIER2 | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_043_OUTCOMEGT13MONTHEARLIER3 | 1         |  2019-01-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-01-01T00:00:00Z  | 90000001                 | 

		And I load action plan data for the feature
		| LoaderRef                       | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
		| TS_041_OUTCOMEGT12MONTHEARLIER1 | 1         |  2019-03-02T00:00:00Z  |  true                            |  2019-03-02T00:00:00Z   |  2019-03-02T00:00:00Z        | 1                        |  2019-03-02T00:00:00Z      | 1                |  looking for work26 | 
		| TS_042_OUTCOMEGT12MONTHEARLIER2 | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
		| TS_043_OUTCOMEGT13MONTHEARLIER3 | 1         |  2019-01-01T00:00:00Z  |  true                            |  2019-01-01T00:00:00Z   |  2019-01-01T00:00:00Z        | 1                        |  2019-01-01T00:00:00Z      | 1                |  looking for work26 | 

		And I load outcome data for the feature
		| LoaderRef                       | ParentRef | OutcomeType | TouchPoint | ClaimedPriorityGroup | OutcomeClaimedDate     | OutcomeEffectiveDate   | 
		| TS_041_OUTCOMEGT12MONTHEARLIER1 | 1         | 1           |            | 99                   |  2019-03-02T00:00:00Z  |  2019-03-02T00:00:00Z  | 
		| TS_041_OUTCOMEGT12MONTHEARLIER1 | 1         | 1           |            | 99                   |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
		| TS_042_OUTCOMEGT12MONTHEARLIER2 | 1         | 2           |            | 1                    |  2019-03-02T00:00:00Z  |  2019-03-02T00:00:00Z  | 
		| TS_042_OUTCOMEGT12MONTHEARLIER2 | 1         | 2           |            | 1                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
		| TS_043_OUTCOMEGT13MONTHEARLIER3 | 1         | 5           |            | 2                    |  2019-02-03T00:00:00Z  |  2019-02-02T00:00:00Z  | 
		| TS_043_OUTCOMEGT13MONTHEARLIER3 | 1         | 2           |            | 2                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 

		And I have made any data fudging updates required
		And I have confirmed all test data is now in the backup data store
		And the report period start date is "2019-04-01"
		And the report period end date is "2020-03-31"
		And a request has been made and the report data is available

		When I check the report data
		Then Outcome 1 for test customer "TS_041_OUTCOMEGT12MONTHEARLIER1" is not included in the report
		Then Outcome 2 for test customer "TS_041_OUTCOMEGT12MONTHEARLIER1" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-03-01  |                 | Billy Adviser | 1           | 2020-03-03           | 0                       |
		Then Outcome 1 for test customer "TS_042_OUTCOMEGT12MONTHEARLIER2" is not included in the report
		Then Outcome 2 for test customer "TS_042_OUTCOMEGT12MONTHEARLIER2" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-03-01  |                 | Billy Adviser | 2           | 2020-03-03           | 1                       |
		Then Outcome 1 for test customer "TS_043_OUTCOMEGT13MONTHEARLIER3" is not included in the report
		Then Outcome 2 for test customer "TS_043_OUTCOMEGT13MONTHEARLIER3" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-01-01  |                 | Billy Adviser | 2           | 2020-03-03           | 1                       |

		
Scenario:  Outcomes claimed again later in the period

		Given I load test customer data for this feature:
			#Parent for ADDRESS in CUSTOMER
		| LoaderRef                       | TouchPoint | Title | GivenName | FamilyName    | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
		| TS_044_LATEROUTCOMECLAIMED1     |            | 4     | Dan       | tsfortyfour   |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 

		And I load test address data for this feature:
		| LoaderRef                  | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 

		And I load test contact data for this feature:
		| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

		 And I load test interaction data for this feature
		#	#Parent for INTERACTION is CUSTOMER
		| LoaderRef                       | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
		| TS_044_LATEROUTCOMECLAIMED1     |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

			And I load test session data for the feature
		| LoaderRef                       | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended    | ReasonForNonAttendance   | LastModifiedDate       | LastModifiedTouchpointId | 
		| TS_044_LATEROUTCOMECLAIMED1     | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 

		And I load action plan data for the feature
		| LoaderRef                       | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
		| TS_044_LATEROUTCOMECLAIMED1     | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 

		And I load outcome data for the feature
		| LoaderRef                       | ParentRef | OutcomeType | TouchPoint | ClaimedPriorityGroup | OutcomeClaimedDate     | OutcomeEffectiveDate   | 
		| TS_044_LATEROUTCOMECLAIMED1     | 1         | 1           |            | 2                    |  2019-04-10T00:00:00Z  |  2019-04-10T00:00:00Z  | 
		| TS_044_LATEROUTCOMECLAIMED1     | 1         | 1           |            | 2                    |  2019-05-10T00:00:00Z  |  2019-05-10T00:00:00Z  | 



		And I have made any data fudging updates required
		And I have confirmed all test data is now in the backup data store
		And the report period start date is "2019-04-01"
		And the report period end date is "2020-03-31"
		And a request has been made and the report data is available

		When I check the report data
		Then Outcome 1 for test customer "TS_044_LATEROUTCOMECLAIMED1" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-03-01  |                 | Billy Adviser | 1           | 2019-04-10           | 1                       |

		Then Outcome 2 for test customer "TS_044_LATEROUTCOMECLAIMED1" is not included in the report
		
Scenario:  Outcomes are submitted at beginning and end of the report period

		Given I load test customer data for this feature:
			#Parent for ADDRESS in CUSTOMER
		| LoaderRef                       | TouchPoint | Title | GivenName | FamilyName    | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
		| TS_020_STARTOFYRBOUNDARY        |            | 4     | Dan       | tstwenty      |  Today -21Y       |  Now -3D             | 9999900049          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
		| TS_021_STARTOFYRBOUNDARY        |            | 4     | Dan       | tstwentyone   |  Today -21Y       |  Now -3D             | 9999900050          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
		| TS_022_STARTOFYRBOUNDARY        |            | 4     | Dan       | tstwentytwo   |  Today -21Y       |  Now -3D             | 9999900051          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
		| TS_023_STARTOFYRBOUNDARY        |            | 4     | Dan       | tstwentythree |  Today -21Y       |  Now -3D             | 9999900052          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
		| TS_024_STARTOFYRBOUNDARY        |            | 4     | Dan       | tstwentyfour  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
		| TS_031_ENDOFYRBOUNDARY          |            | 4     | Dan       | tsthirtyone   |  Today -21Y       |  Now -3D             | 9999900050          |  true               |  false                |                     |                        |              |                              |                        | 
		| TS_032_ENDOFYRBOUNDARY          |            | 4     | Dan       | tsthirtytwo   |  Today -21Y       |  Now -3D             | 9999900051          |  true               |  false                |                     |                        |              |                              |                        | 
		| TS_033_ENDOFYRBOUNDARY          |            | 4     | Dan       | tsthirtythree |  Today -21Y       |  Now -3D             | 9999900051          |  true               |  false                |                     |                        |              |                              |                        | 

		And I load test address data for this feature:
		| LoaderRef                  | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 

		And I load test contact data for this feature:
		| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

			And I load test interaction data for this feature
		#	#Parent for INTERACTION is CUSTOMER
		| LoaderRef                       | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
		| TS_020_STARTOFYRBOUNDARY        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_021_STARTOFYRBOUNDARY        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_022_STARTOFYRBOUNDARY        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_023_STARTOFYRBOUNDARY        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_024_STARTOFYRBOUNDARY        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_031_ENDOFYRBOUNDARY          |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_032_ENDOFYRBOUNDARY          |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_033_ENDOFYRBOUNDARY          |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

			And I load test session data for the feature
		| LoaderRef                       | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended    | ReasonForNonAttendance   | LastModifiedDate       | LastModifiedTouchpointId | 
		| TS_020_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_021_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_022_STARTOFYRBOUNDARY        | 1         |  2019-03-02T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-02T00:00:00Z  | 90000001                 | 
		| TS_023_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_024_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_031_ENDOFYRBOUNDARY          | 1         |  2020-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2020-03-01T00:00:00Z  | 90000001                 | 
		| TS_032_ENDOFYRBOUNDARY          | 1         |  2020-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2020-03-01T00:00:00Z  | 90000001                 | 
		| TS_033_ENDOFYRBOUNDARY          | 1         |  2020-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2020-03-01T00:00:00Z  | 90000001                 | 

		And I load action plan data for the feature
		| LoaderRef                       | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
		| TS_020_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
		| TS_021_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
		| TS_022_STARTOFYRBOUNDARY        | 1         |  2019-03-02T00:00:00Z  |  true                            |  2019-03-02T00:00:00Z   |  2019-03-02T00:00:00Z        | 1                        |  2019-03-02T00:00:00Z      | 1                |  looking for work26 | 
		| TS_023_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
		| TS_024_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
		| TS_031_ENDOFYRBOUNDARY          | 1         |  2020-03-01T00:00:00Z  |  true                            |  2020-03-01T00:00:00Z   |  2020-03-01T00:00:00Z        | 1                        |  2020-03-01T00:00:00Z      | 1                |  looking for work26 | 
		| TS_032_ENDOFYRBOUNDARY          | 1         |  2020-03-01T00:00:00Z  |  true                            |  2020-03-01T00:00:00Z   |  2020-03-01T00:00:00Z        | 1                        |  2020-03-01T00:00:00Z      | 1                |  looking for work26 | 
		| TS_033_ENDOFYRBOUNDARY          | 1         |  2020-03-01T00:00:00Z  |  true                            |  2020-03-01T00:00:00Z   |  2020-03-01T00:00:00Z        | 1                        |  2020-03-01T00:00:00Z      | 1                |  looking for work26 | 

		And I load outcome data for the feature
		| LoaderRef                | ParentRef | OutcomeType | TouchPoint | ClaimedPriorityGroup | OutcomeClaimedDate   | OutcomeEffectiveDate |
		| TS_020_STARTOFYRBOUNDARY | 1         | 1           |            | 99                   | 2019-03-31T00:00:00Z | 2019-03-31T00:00:00Z |
		| TS_020_STARTOFYRBOUNDARY | 1         | 2           |            | 1                    | 2019-04-01T00:00:00Z | 2019-04-01T00:00:00Z |
		| TS_020_STARTOFYRBOUNDARY | 1         | 1           |            | 2                    | 2019-04-01T00:00:00Z | 2019-04-01T00:00:00Z |
		| TS_021_STARTOFYRBOUNDARY | 1         | 3           |            | 3                    | 2019-04-02T00:00:00Z | 2019-04-02T00:00:00Z |
		| TS_022_STARTOFYRBOUNDARY | 1         | 5           |            | 4                    | 2019-04-01T00:00:00Z | 2019-04-01T00:00:00Z |
		| TS_023_STARTOFYRBOUNDARY | 1         | 5           |            | 5                    | 2019-04-02T00:00:00Z | 2019-04-02T00:00:00Z |
		| TS_024_STARTOFYRBOUNDARY | 1         | 3           |            | 6                    | 2019-04-01T00:00:00Z | 2019-04-01T00:00:00Z |
		| TS_031_ENDOFYRBOUNDARY   | 1         | 2           |            | 1                    | 2020-03-31T00:00:00Z | 2020-03-31T00:00:00Z |
		| TS_032_ENDOFYRBOUNDARY   | 1         | 1           |            | 2                    | 2020-03-31T11:59:00Z | 2020-03-31T11:59:00Z |
		| TS_033_ENDOFYRBOUNDARY   | 1         | 1           |            | 2                    | 2020-04-01T00:00:00Z | 2020-03-31T11:59:00Z |
		| TS_033_ENDOFYRBOUNDARY   | 1         | 1           |            | 3                    | 2020-03-31T11:59:00Z | 2020-04-01T00:00:00Z |
		| TS_033_ENDOFYRBOUNDARY   | 1         | 1           |            | 99                   | 2020-03-31T11:59:00Z | 2020-03-31T11:59:00Z |

		And I have made any data fudging updates required
		And I have confirmed all test data is now in the backup data store
		And the report period start date is "2019-04-01"
		And the report period end date is "2020-03-31"
		And a request has been made and the report data is available

		When I check the report data
		Then Outcome 1 for test customer "TS_020_STARTOFYRBOUNDARY" is not included in the report
		Then Outcome 2 for test customer "TS_020_STARTOFYRBOUNDARY" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-03-01  |                 | Billy Adviser | 2           | 2019-04-01           | 1                       |

		Then Outcome 3 for test customer "TS_020_STARTOFYRBOUNDARY" is not included in the report

		Then Outcome 1 for test customer "TS_021_STARTOFYRBOUNDARY" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-03-01  |                 | Billy Adviser | 3           | 2019-04-02           | 1                       |

		Then Outcome 1 for test customer "TS_022_STARTOFYRBOUNDARY" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-03-02  |                 | Billy Adviser | 5           | 2019-04-01           | 1                       |

		Then Outcome 1 for test customer "TS_023_STARTOFYRBOUNDARY" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-03-01  |                 | Billy Adviser | 5           | 2019-04-02           | 1                       |

		Then Outcome 1 for test customer "TS_024_STARTOFYRBOUNDARY" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-03-01  |                 | Billy Adviser | 3           | 2019-04-01           | 1                       |

		Then Outcome 1 for test customer "TS_031_ENDOFYRBOUNDARY" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2020-03-01  |                 | Billy Adviser | 2           | 2020-03-31           | 1                       |

		Then Outcome 1 for test customer "TS_032_ENDOFYRBOUNDARY" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2020-03-01  |                 | Billy Adviser | 1           | 2020-03-31           | 1                       |

		Then Outcome 1 for test customer "TS_033_ENDOFYRBOUNDARY" is not included in the report
		Then Outcome 2 for test customer "TS_033_ENDOFYRBOUNDARY" is not included in the report

		Then Outcome 3 for test customer "TS_033_ENDOFYRBOUNDARY" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2020-03-01  |                 | Billy Adviser | 1           | 2020-03-31           | 0                       |


Scenario: Simple cases 

		Given I load test customer data for this feature:
			#Parent for ADDRESS in CUSTOMER
		| LoaderRef                       | TouchPoint | Title | GivenName | FamilyName    | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
		| TS_001_SIMPLECASE1              |            | 4     | Barry     | tsone         |  Today -21Y       |  Now -3D             | 9999900030          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
		| TS_002_SIMPLECASE2              |            | 4     | Terry     | tstwo         |  Today -21Y       |  Now -3D             | 9999900031          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
		| TS_003_SIMPLECASE3              |            | 4     | Quest     | tsthree       |  Today -21Y       |  Now -3D             | 9999900032          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 

		And I load test address data for this feature:
		| LoaderRef                  | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 
		| TS_001_SIMPLECASE1         |  1 Lake Street   |  North Walsham  |          |          |          |  P01 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
		| TS_002_SIMPLECASE2         |  2 Lake Street   |  North Walsham  |          |          |          |  P02 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
		| TS_003_SIMPLECASE3         |  3 Lake Street   |  North Walsham  |          |          |          |  P03 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 

		And I load test contact data for this feature:
		| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

			And I load test interaction data for this feature
		#	#Parent for INTERACTION is CUSTOMER
		| LoaderRef                       | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
		| TS_001_SIMPLECASE1              |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_002_SIMPLECASE2              |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_003_SIMPLECASE3              |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

			And I load test session data for the feature
		| LoaderRef                       | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended    | ReasonForNonAttendance   | LastModifiedDate       | LastModifiedTouchpointId | 
		| TS_001_SIMPLECASE1              | 1         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-04-05T00:00:00Z  | 90000001                 | 
		| TS_002_SIMPLECASE2              | 1         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-04-05T00:00:00Z  | 90000001                 | 
		| TS_003_SIMPLECASE3              | 1         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-04-05T00:00:00Z  | 90000001                 | 

		And I load action plan data for the feature
		| LoaderRef                       | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
		| TS_001_SIMPLECASE1              | 1         |  2019-04-05T00:00:00Z  |  true                            |  2019-04-05T00:00:00Z   |  2019-04-05T00:00:00Z        | 1                        |  2019-04-05T00:00:00Z      | 1                |  looking for work26 | 
		| TS_002_SIMPLECASE2              | 1         |  2019-04-05T00:00:00Z  |  true                            |  2019-04-05T00:00:00Z   |  2019-04-05T00:00:00Z        | 1                        |  2019-04-05T00:00:00Z      | 1                |  looking for work26 | 
		| TS_003_SIMPLECASE3              | 1         |  2019-04-05T00:00:00Z  |  true                            |  2019-04-05T00:00:00Z   |  2019-04-05T00:00:00Z        | 1                        |  2019-04-05T00:00:00Z      | 1                |  looking for work26 | 

		And I load outcome data for the feature
		| LoaderRef                       | ParentRef | OutcomeType | TouchPoint | ClaimedPriorityGroup | OutcomeClaimedDate     | OutcomeEffectiveDate   | 
		| TS_001_SIMPLECASE1              | 1         | 1           | 9000000090 | 99                   |  2019-04-03T00:00:00Z  |  2019-04-03T00:00:00Z  | 
		| TS_001_SIMPLECASE1              | 1         | 2           |            | 1                    |  2019-05-09T00:00:00Z  |  2019-05-09T00:00:00Z  | 
		| TS_001_SIMPLECASE1              | 1         | 3           |            | 2                    |  2019-06-03T00:00:00Z  |  2019-06-03T00:00:00Z  | 
		| TS_002_SIMPLECASE2              | 1         | 4           |            | 5                    |  2019-04-03T00:00:00Z  |  2019-04-03T00:00:00Z  | 
		| TS_002_SIMPLECASE2              | 1         | 1           |            | 99                   |  2019-05-09T00:00:00Z  |  2019-05-09T00:00:00Z  | 
		| TS_002_SIMPLECASE2              | 1         | 2           |            | 2                    |  2019-06-03T00:00:00Z  |  2019-06-03T00:00:00Z  | 
		| TS_003_SIMPLECASE3              | 1         | 5           |            | 99                   |  2019-04-03T00:00:00Z  |  2019-04-03T00:00:00Z  | 
		| TS_003_SIMPLECASE3              | 1         | 2           |            | 3                    |  2019-05-09T00:00:00Z  |  2019-05-09T00:00:00Z  | 
		| TS_003_SIMPLECASE3              | 1         | 1           |            | 6                    |  2019-06-03T00:00:00Z  |  2019-06-03T00:00:00Z  | 



		And I have made any data fudging updates required
		And I have confirmed all test data is now in the backup data store
		And the report period start date is "2019-04-01"
		And the report period end date is "2020-03-31"
		And a request has been made and the report data is available

		When I check the report data
		Then Outcome 1 for test customer "TS_001_SIMPLECASE1" is not included in the report  
		# ^because the touchpoint doesnt match
		Then Outcome 2 for test customer "TS_001_SIMPLECASE1" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  | P01 9UX      | 2019-04-01  |                 | Billy Adviser | 2           | 2019-05-09           | 1                       |
		
		Then Outcome 3 for test customer "TS_001_SIMPLECASE1" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |  P01 9UX     | 2019-04-01  |                 | Billy Adviser | 3           | 2019-06-03           | 1                       |
		
		Then Outcome 1 for test customer "TS_002_SIMPLECASE2" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |  P02 9UX     | 2019-04-01  |                 | Billy Adviser | 4           | 2019-04-03           | 1                       |
		
		Then Outcome 2 for test customer "TS_002_SIMPLECASE2" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |  P02 9UX     | 2019-04-01  |                 | Billy Adviser | 1           | 2019-05-09           | 0                       |
		
		Then Outcome 3 for test customer "TS_002_SIMPLECASE2" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |  P02 9UX     | 2019-04-01  |                 | Billy Adviser | 2           | 2019-06-03           | 1                       |
		
		Then Outcome 1 for test customer "TS_003_SIMPLECASE3" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |  P03 9UX     | 2019-04-01  |                 | Billy Adviser | 5           | 2019-04-03           | 0                       |
		
		Then Outcome 2 for test customer "TS_003_SIMPLECASE3" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  | P03 9UX      | 2019-04-01  |                 | Billy Adviser | 2           | 2019-05-09           | 1                       |
		
		Then Outcome 3 for test customer "TS_003_SIMPLECASE3" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  | P03 9UX      | 2019-04-01  |                 | Billy Adviser | 1           | 2019-06-03           | 1                       |

Scenario: Too many outcomes are submitted

		Given I load test customer data for this feature:
			#Parent for ADDRESS in CUSTOMER
		| LoaderRef                       | TouchPoint | Title | GivenName | FamilyName    | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
		| TS_004_TOOMANY1                 |            | 4     | Sam       | tsfour        |  Today -21Y       |  Now -3D             | 9999900033          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
		| TS_005_TOOMANY2                 |            | 4     | Gerry     | tsfive        |  Today -21Y       |  Now -3D             | 9999900034          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 

		And I load test address data for this feature:
		| LoaderRef                  | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 
		| TS_004_TOOMANY1            |  4 Lake Street   |  North Walsham  |          |          |          |  B33 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
		| TS_005_TOOMANY2            |  5 Lake Street   |  North Walsham  |          |          |          |  B34 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 

		And I load test contact data for this feature:
		| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

		 And I load test interaction data for this feature
		#	#Parent for INTERACTION is CUSTOMER
		| LoaderRef                       | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
		| TS_004_TOOMANY1                 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_005_TOOMANY2                 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

			And I load test session data for the feature
		| LoaderRef                       | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended    | ReasonForNonAttendance   | LastModifiedDate       | LastModifiedTouchpointId | 
		| TS_004_TOOMANY1                 | 1         |  2019-04-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-04-05T00:00:00Z  | 90000001                 | 
		| TS_005_TOOMANY2                 | 1         |  2019-04-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-04-05T00:00:00Z  | 90000001                 | 

		And I load action plan data for the feature
		| LoaderRef                       | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
		| TS_004_TOOMANY1                 | 1         |  2019-04-05T00:00:00Z  |  true                            |  2019-04-05T00:00:00Z   |  2019-04-05T00:00:00Z        | 1                        |  2019-04-05T00:00:00Z      | 1                |  looking for work26 | 
		| TS_005_TOOMANY2                 | 1         |  2019-04-05T00:00:00Z  |  true                            |  2019-04-05T00:00:00Z   |  2019-04-05T00:00:00Z        | 1                        |  2019-04-05T00:00:00Z      | 1                |  looking for work26 | 

		And I load outcome data for the feature
		| LoaderRef                       | ParentRef | OutcomeType | TouchPoint | ClaimedPriorityGroup | OutcomeClaimedDate     | OutcomeEffectiveDate   | 
		| TS_004_TOOMANY1                 | 1         | 1           |            | 4                    |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
		| TS_004_TOOMANY1                 | 1         | 1           |            | 99                   |  2019-08-09T00:00:00Z  |  2019-08-09T00:00:00Z  | 
		| TS_004_TOOMANY1                 | 1         | 2           |            | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
		| TS_005_TOOMANY2                 | 1         | 3           |            | 4                    |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
		| TS_005_TOOMANY2                 | 1         | 4           |            | 99                   |  2019-08-09T00:00:00Z  |  2019-08-09T00:00:00Z  | 
		| TS_005_TOOMANY2                 | 1         | 5           |            | 6                    |  2020-02-03T00:00:00Z  |  2020-02-03T00:00:00Z  | 
		| TS_005_TOOMANY2                 | 1         | 2           |            | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 

		And I have made any data fudging updates required
		And I have confirmed all test data is now in the backup data store
		And the report period start date is "2019-04-01"
		And the report period end date is "2020-03-31"
		And a request has been made and the report data is available

		Given I load test customer data for this feature:
			#Parent for ADDRESS in CUSTOMER
		| LoaderRef                       | TouchPoint | Title | GivenName | FamilyName    | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
		| TS_004_TOOMANY1                 |            | 4     | Sam       | tsfour        |  Today -21Y       |  Now -3D             | 9999900033          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
		| TS_005_TOOMANY2                 |            | 4     | Gerry     | tsfive        |  Today -21Y       |  Now -3D             | 9999900034          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 

		And I load test address data for this feature:
		| LoaderRef                  | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 
		| TS_004_TOOMANY1            |  4 Lake Street   |  North Walsham  |          |          |          |  B33 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
		| TS_005_TOOMANY2            |  5 Lake Street   |  North Walsham  |          |          |          |  B34 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 

		And I load test contact data for this feature:
		| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

		 And I load test interaction data for this feature
		#	#Parent for INTERACTION is CUSTOMER
		| LoaderRef                       | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
		| TS_004_TOOMANY1                 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_005_TOOMANY2                 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

			And I load test session data for the feature
		| LoaderRef                       | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended    | ReasonForNonAttendance   | LastModifiedDate       | LastModifiedTouchpointId | 
		| TS_004_TOOMANY1                 | 1         |  2019-04-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-04-05T00:00:00Z  | 90000001                 | 
		| TS_005_TOOMANY2                 | 1         |  2019-04-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-04-05T00:00:00Z  | 90000001                 | 

		And I load action plan data for the feature
		| LoaderRef                       | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
		| TS_004_TOOMANY1                 | 1         |  2019-04-05T00:00:00Z  |  true                            |  2019-04-05T00:00:00Z   |  2019-04-05T00:00:00Z        | 1                        |  2019-04-05T00:00:00Z      | 1                |  looking for work26 | 
		| TS_005_TOOMANY2                 | 1         |  2019-04-05T00:00:00Z  |  true                            |  2019-04-05T00:00:00Z   |  2019-04-05T00:00:00Z        | 1                        |  2019-04-05T00:00:00Z      | 1                |  looking for work26 | 

		And I load outcome data for the feature
		| LoaderRef                       | ParentRef | OutcomeType | TouchPoint | ClaimedPriorityGroup | OutcomeClaimedDate     | OutcomeEffectiveDate   | 
		| TS_004_TOOMANY1                 | 1         | 1           |            | 4                    |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
		| TS_004_TOOMANY1                 | 1         | 1           |            | 99                   |  2019-08-09T00:00:00Z  |  2019-08-09T00:00:00Z  | 
		| TS_004_TOOMANY1                 | 1         | 2           |            | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
		| TS_005_TOOMANY2                 | 1         | 3           |            | 4                    |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
		| TS_005_TOOMANY2                 | 1         | 4           |            | 99                   |  2019-08-09T00:00:00Z  |  2019-08-09T00:00:00Z  | 
		| TS_005_TOOMANY2                 | 1         | 5           |            | 6                    |  2020-02-03T00:00:00Z  |  2020-02-03T00:00:00Z  | 
		| TS_005_TOOMANY2                 | 1         | 2           |            | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 

		And I have made any data fudging updates required
		And I have confirmed all test data is now in the backup data store
		And the report period start date is "2019-04-01"
		And the report period end date is "2020-03-31"
		And a request has been made and the report data is available

		When I check the report data
		Then Outcome 1 for test customer "TS_004_TOOMANY1" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |  B33 9UX     | 2019-04-05  |                 | Billy Adviser | 1           | 2019-05-03           | 1                       |

		Then Outcome 2 for test customer "TS_004_TOOMANY1" is not included in the report

		Then Outcome 3 for test customer "TS_004_TOOMANY1" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |  B33 9UX     | 2019-04-05  |                 | Billy Adviser | 2           | 2020-03-03           | 1                       |

		Then Outcome 1 for test customer "TS_005_TOOMANY2" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |   B34 9UX    | 2019-04-05  |                 | Billy Adviser | 3           | 2019-05-03           | 1                       |

		Then Outcome 2 for test customer "TS_005_TOOMANY2" is not included in the report
		Then Outcome 3 for test customer "TS_005_TOOMANY2" is not included in the report

		Then Outcome 4 for test customer "TS_005_TOOMANY2" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |   B34 9UX    | 2019-04-05  |                 | Billy Adviser | 2           | 2020-03-03           | 1                       |

Scenario: Multiple Addresses

		Given I load test customer data for this feature:
			#Parent for ADDRESS in CUSTOMER
		| LoaderRef                       | TouchPoint | Title | GivenName | FamilyName    | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
		| TS_025_ADDRESS_DUPLICATE        |            | 4     | Dan       | tstwentyfive  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
		| TS_026_ADDRESS_MULTIPLE         |            | 4     | Dan       | tstwentysix   |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
		| TS_027_ADDRESS_ENDED            |            | 4     | Dan       | tstwentyseven |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
		| TS_028_ADDRESS_HISTORY          |            | 4     | Dan       | tstwentyeight |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 

		And I load test address data for this feature:
		| LoaderRef                  | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 
		| TS_025_ADDRESS_DUPLICATE   |  13 Lake Street  |  North Walsham  |          |          |          |  B41 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
		| TS_025_ADDRESS_DUPLICATE   |  13 Lake Street  |  North Walsham  |          |          |          |  B41 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
		| TS_026_ADDRESS_MULTIPLE    |  14 Lake Street  |  North Walsham  |          |          |          |  B42 9UX   |                     |           |          |                      |                      | 2019-01-23T00:00:00Z |                          | 
		| TS_026_ADDRESS_MULTIPLE    |  15 Lake Street  |  North Walsham  |          |          |          |  B43 9UX   |                     |           |          |                      |                      | 2019-01-23T00:00:01Z |                          | 
		| TS_026_ADDRESS_MULTIPLE    |  16 Lake Street  |  North Walsham  |          |          |          |  B44 9UX   |                     |           |          |                      |                      | 2019-01-23T00:00:02Z |                          | 
		| TS_027_ADDRESS_ENDED       |  17 Lake Street  |  North Walsham  |          |          |          |  B44 8UX   |                     |           |          | 2019-01-23T00:00:01Z | 2019-02-23T00:00:01Z |                      |                          | 
		| TS_028_ADDRESS_HISTORY     |  17 Lake Street  |  North Walsham  |          |          |          |  B46 8UX   |                     |           |          | 2019-01-23T00:00:01Z | 2019-02-23T00:00:01Z |                      |                          | 
		| TS_028_ADDRESS_HISTORY     |  18 Lake Street  |  North Walsham  |          |          |          |  B45 8UX   |                     |           |          | 2019-02-23T00:00:01Z | 2019-03-23T00:00:01Z |                      |                          | 
		| TS_028_ADDRESS_HISTORY     |  19 Lake Street  |  North Walsham  |          |          |          |  B47 8UX   |                     |           |          | 2019-03-24T00:00:01Z |                      |                      |                          | 

		And I load test contact data for this feature:
		| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

		 And I load test interaction data for this feature
		#	#Parent for INTERACTION is CUSTOMER
		| LoaderRef                       | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
		| TS_025_ADDRESS_DUPLICATE        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_026_ADDRESS_MULTIPLE         |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_027_ADDRESS_ENDED            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_028_ADDRESS_HISTORY          |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

			And I load test session data for the feature
		| LoaderRef                       | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended    | ReasonForNonAttendance   | LastModifiedDate       | LastModifiedTouchpointId | 
		| TS_025_ADDRESS_DUPLICATE        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_026_ADDRESS_MULTIPLE         | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_027_ADDRESS_ENDED            | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_028_ADDRESS_HISTORY          | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 

		And I load action plan data for the feature
		| LoaderRef                       | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
		| TS_025_ADDRESS_DUPLICATE        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
		| TS_026_ADDRESS_MULTIPLE         | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
		| TS_027_ADDRESS_ENDED            | 1         |  2019-03-02T00:00:00Z  |  true                            |  2019-03-02T00:00:00Z   |  2019-03-02T00:00:00Z        | 1                        |  2019-03-02T00:00:00Z      | 1                |  looking for work26 | 
		| TS_028_ADDRESS_HISTORY          | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 

		And I load outcome data for the feature
		| LoaderRef                       | ParentRef | OutcomeType | TouchPoint | ClaimedPriorityGroup | OutcomeClaimedDate     | OutcomeEffectiveDate   | 
		| TS_025_ADDRESS_DUPLICATE        | 1         | 1           |            | 99                   |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
		| TS_026_ADDRESS_MULTIPLE         | 1         | 2           |            | 1                    |  2019-04-02T00:00:00Z  |  2019-04-02T00:00:00Z  | 
		| TS_027_ADDRESS_ENDED            | 1         | 3           |            | 2                    |  2019-04-03T00:00:00Z  |  2019-04-03T00:00:00Z  | 
		| TS_028_ADDRESS_HISTORY          | 1         | 1           |            | 3                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 

		And I have made any data fudging updates required
		And I have confirmed all test data is now in the backup data store
		And the report period start date is "2019-04-01"
		And the report period end date is "2020-03-31"
		And a request has been made and the report data is available

		When I check the report data
		Then Outcome 1 for test customer "TS_025_ADDRESS_DUPLICATE" is included in the report
		Then Outcome 1 for test customer "TS_026_ADDRESS_MULTIPLE" is included in the report
		Then Outcome 1 for test customer "TS_027_ADDRESS_ENDED" is included in the report
		Then Outcome 1 for test customer "TS_028_ADDRESS_HISTORY" is included in the report


Scenario: Earlier outcomes that do not cause exclusion

		Given I load test customer data for this feature:
			#Parent for ADDRESS in CUSTOMER
		| LoaderRef                       | TouchPoint | Title | GivenName | FamilyName    | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
		| TS_045_EARLIEROUTCOMEHELPLINE   |            | 4     | Dan       | tsfortyfive   |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
		| TS_046_EARLIEROUTCOMENOTCLAIMED |            | 4     | Dan       | tsfortysix    |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 

		And I load test address data for this feature:
		| LoaderRef                  | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 

		And I load test contact data for this feature:
		| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

		 And I load test interaction data for this feature
		#	#Parent for INTERACTION is CUSTOMER
		| LoaderRef                       | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
		| TS_045_EARLIEROUTCOMEHELPLINE   |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
		| TS_046_EARLIEROUTCOMENOTCLAIMED |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

			And I load test session data for the feature
		| LoaderRef                       | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended    | ReasonForNonAttendance   | LastModifiedDate       | LastModifiedTouchpointId | 
		| TS_045_EARLIEROUTCOMEHELPLINE   | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
		| TS_046_EARLIEROUTCOMENOTCLAIMED | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 

		And I load action plan data for the feature
		| LoaderRef                       | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
		| TS_045_EARLIEROUTCOMEHELPLINE   | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
		| TS_046_EARLIEROUTCOMENOTCLAIMED | 1         |  2019-03-02T00:00:00Z  |  true                            |  2019-03-02T00:00:00Z   |  2019-03-02T00:00:00Z        | 1                        |  2019-03-02T00:00:00Z      | 1                |  looking for work26 | 

		And I load outcome data for the feature
		| LoaderRef                       | ParentRef | OutcomeType | TouchPoint | ClaimedPriorityGroup | OutcomeClaimedDate     | OutcomeEffectiveDate   | 
		| TS_045_EARLIEROUTCOMEHELPLINE   | 1         | 1           | 0000000999 | 4                    |  2019-04-10T00:00:00Z  |  2019-04-10T00:00:00Z  | 
		| TS_045_EARLIEROUTCOMEHELPLINE   | 1         | 1           |            | 4                    |  2019-05-12T00:00:00Z  |  2019-05-12T00:00:00Z  | 
		| TS_046_EARLIEROUTCOMENOTCLAIMED | 1         | 2           |            | 1                    |                        |  2019-04-16T00:00:00Z  | 
		| TS_046_EARLIEROUTCOMENOTCLAIMED | 1         | 2           |            | 2                    |  2019-04-17T00:00:00Z  |  2019-04-17T00:00:00Z  | 
		| TS_046_EARLIEROUTCOMENOTCLAIMED | 1         | 3           |            | 3                    |                        |                        | 
		| TS_046_EARLIEROUTCOMENOTCLAIMED | 1         | 3           |            | 4                    |  2019-04-19T00:00:00Z  |  2019-04-19T00:00:00Z  | 



		And I have made any data fudging updates required
		And I have confirmed all test data is now in the backup data store
		And the report period start date is "2019-04-01"
		And the report period end date is "2020-03-31"
		And a request has been made and the report data is available

		When I check the report data
		Then Outcome 1 for test customer "TS_045_EARLIEROUTCOMEHELPLINE" is not included in the report
		Then Outcome 2 for test customer "TS_045_EARLIEROUTCOMEHELPLINE" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-03-01  |                 | Billy Adviser | 1           | 2019-05-12           | 1                       |
		Then Outcome 1 for test customer "TS_046_EARLIEROUTCOMENOTCLAIMED" is not included in the report
		Then Outcome 2 for test customer "TS_046_EARLIEROUTCOMENOTCLAIMED" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-03-01  |                 | Billy Adviser | 2           | 2019-04-17           | 1                       |
		Then Outcome 3 for test customer "TS_046_EARLIEROUTCOMENOTCLAIMED" is not included in the report
		Then Outcome 4 for test customer "TS_046_EARLIEROUTCOMENOTCLAIMED" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-03-01  |                 | Billy Adviser | 3           | 2019-04-19           | 1                       |
