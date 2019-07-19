Feature: ReportData_SessionClose
	In order to avoid silly mistakes
	As a math idiot
	I want to be told the sum of two numbers


Background:

Given I load test customer data for this feature:
	#Parent for ADDRESS in CUSTOMER
| LoaderRef                        | TouchPoint | Title | GivenName | FamilyName    | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
| COL1015_SESSIONWITHIN12MONTHS1   |            | 4     | Carter    | tsfifteen     |  Today -21Y       |  Now -3D             | 9999900044          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| COL1016_SESSIONWITHIN12MONTHS2   |            | 4     | Lil       | tssixteen     |  Today -21Y       |  Now -3D             | 9999900045          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| COL1017_SESSIONWITHIN13MONTHS3   |            | 4     | Marge     | tsseventeen   |  Today -21Y       |  Now -3D             | 9999900046          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| COL1018_SESSIONWITHIN12MONTHS4   |            | 4     | Sarah     | tseighteen    |  Today -21Y       |  Now -3D             | 9999900047          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| COL1019_SESSIONWITHIN12MONTHS5   |            | 4     | Dan       | tsnineteen    |  Today -21Y       |  Now -3D             | 9999900048          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| COL1020_SESSIONEXACTLY12MONTHS1  |            | 4     | Dan       | tstwenty      |  Today -21Y       |  Now -3D             | 9999900049          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| COL1021_SESSIONEXACTLY12MONTHS2  |            | 4     | Dan       | tstwentyone   |  Today -21Y       |  Now -3D             | 9999900050          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| COL1022_SESSIONEXACTLY13MONTHS3  |            | 4     | Dan       | tstwentytwo   |  Today -21Y       |  Now -3D             | 9999900051          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| COL1023_SESSIONEXACTLY12MONTHS4  |            | 4     | Dan       | tstwentythree |  Today -21Y       |  Now -3D             | 9999900052          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| COL1024_SESSIONEXACTLY12MONTHS5  |            | 4     | Dan       | tstwentyfour  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| COL1025_SESSIONMORETHAN12MONTHS1 |            | 4     | Dan       | tstwentyfive  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1026_SESSIONMORETHAN12MONTHS2 |            | 4     | Dan       | tstwentysix   |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1027_SESSIONMORETHAN13MONTHS3 |            | 4     | Dan       | tstwentyseven |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1028_SESSIONMORETHAN12MONTHS4 |            | 4     | Dan       | tstwentyeight |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1029_SESSIONMORETHAN12MONTHS5 |            | 4     | Dan       | tstwentynine  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 

And I load test address data for this feature:
| LoaderRef                  | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 

And I load test contact data for this feature:
| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

 And I load test interaction data for this feature
#	#Parent for INTERACTION is CUSTOMER
| LoaderRef                        | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
| COL1015_SESSIONWITHIN12MONTHS1   |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1016_SESSIONWITHIN12MONTHS2   |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1017_SESSIONWITHIN13MONTHS3   |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1018_SESSIONWITHIN12MONTHS4   |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1019_SESSIONWITHIN12MONTHS5   |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1020_SESSIONEXACTLY12MONTHS1  |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1021_SESSIONEXACTLY12MONTHS2  |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1022_SESSIONEXACTLY13MONTHS3  |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1023_SESSIONEXACTLY12MONTHS4  |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1024_SESSIONEXACTLY12MONTHS5  |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1025_SESSIONMORETHAN12MONTHS1 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1026_SESSIONMORETHAN12MONTHS2 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1027_SESSIONMORETHAN13MONTHS3 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1028_SESSIONMORETHAN12MONTHS4 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1029_SESSIONMORETHAN12MONTHS5 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 

	And I load test session data for the feature
| LoaderRef                        | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended    | ReasonForNonAttendance   | LastModifiedDate       | LastModifiedTouchpointId | 
| COL1015_SESSIONWITHIN12MONTHS1   | 1         |  2018-04-30T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1016_SESSIONWITHIN12MONTHS2   | 1         |  2018-04-30T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1017_SESSIONWITHIN13MONTHS3   | 1         |  2018-04-30T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1018_SESSIONWITHIN12MONTHS4   | 1         |  2018-04-30T23:59:59Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1019_SESSIONWITHIN12MONTHS5   | 1         |  2018-04-30T23:59:59Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1020_SESSIONEXACTLY12MONTHS1  | 1         |  2018-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1021_SESSIONEXACTLY12MONTHS2  | 1         |  2018-05-01T23:59:59Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1022_SESSIONEXACTLY13MONTHS3  | 1         |  2018-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1023_SESSIONEXACTLY12MONTHS4  | 1         |  2018-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1024_SESSIONEXACTLY12MONTHS5  | 1         |  2018-05-01T23:59:59Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1025_SESSIONMORETHAN12MONTHS1 | 1         |  2018-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1026_SESSIONMORETHAN12MONTHS2 | 1         |  2018-05-01T23:59:59Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1027_SESSIONMORETHAN13MONTHS3 | 1         |  2018-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1028_SESSIONMORETHAN12MONTHS4 | 1         |  2018-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1029_SESSIONMORETHAN12MONTHS5 | 1         |  2018-05-01T23:59:59Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 

And I load action plan data for the feature
| LoaderRef                        | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
| COL1015_SESSIONWITHIN12MONTHS1   | 1         |  2018-05-01T00:00:00Z  |  true                            |  2018-05-01T00:00:00Z   |  2018-05-01T00:00:00Z        | 1                        |  2018-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1016_SESSIONWITHIN12MONTHS2   | 1         |  2018-05-01T00:00:00Z  |  true                            |  2018-05-01T00:00:00Z   |  2018-05-01T00:00:00Z        | 1                        |  2018-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1017_SESSIONWITHIN13MONTHS3   | 1         |  2018-05-01T00:00:00Z  |  true                            |  2018-05-01T00:00:00Z   |  2018-05-01T00:00:00Z        | 1                        |  2018-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1018_SESSIONWITHIN12MONTHS4   | 1         |  2018-05-01T23:59:59Z  |  true                            |  2018-05-01T23:59:59Z   |  2018-05-01T23:59:59Z        | 1                        |  2018-05-01T23:59:59Z      | 1                |  looking for work26 | 
| COL1019_SESSIONWITHIN12MONTHS5   | 1         |  2018-05-01T23:59:59Z  |  true                            |  2018-05-01T23:59:59Z   |  2018-05-01T23:59:59Z        | 1                        |  2018-05-01T23:59:59Z      | 1                |  looking for work26 | 
| COL1020_SESSIONEXACTLY12MONTHS1  | 1         |  2018-05-01T00:00:00Z  |  true                            |  2018-05-01T00:00:00Z   |  2018-05-01T00:00:00Z        | 1                        |  2018-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1021_SESSIONEXACTLY12MONTHS2  | 1         |  2018-05-01T23:59:59Z  |  true                            |  2018-05-01T23:59:59Z   |  2018-05-01T23:59:59Z        | 1                        |  2018-05-01T23:59:59Z      | 1                |  looking for work26 | 
| COL1022_SESSIONEXACTLY13MONTHS3  | 1         |  2018-05-01T00:00:00Z  |  true                            |  2018-05-01T00:00:00Z   |  2018-05-01T00:00:00Z        | 1                        |  2018-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1023_SESSIONEXACTLY12MONTHS4  | 1         |  2018-05-01T00:00:00Z  |  true                            |  2018-05-01T00:00:00Z   |  2018-05-01T00:00:00Z        | 1                        |  2018-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1024_SESSIONEXACTLY12MONTHS5  | 1         |  2018-05-01T23:59:59Z  |  true                            |  2018-05-01T23:59:59Z   |  2018-05-01T23:59:59Z        | 1                        |  2018-05-01T23:59:59Z      | 1                |  looking for work26 | 
| COL1025_SESSIONMORETHAN12MONTHS1 | 1         |  2018-05-01T00:00:00Z  |  true                            |  2018-05-01T00:00:00Z   |  2018-05-01T00:00:00Z        | 1                        |  2018-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1026_SESSIONMORETHAN12MONTHS2 | 1         |  2018-05-01T23:59:59Z  |  true                            |  2018-05-01T23:59:59Z   |  2018-05-01T23:59:59Z        | 1                        |  2018-05-01T23:59:59Z      | 1                |  looking for work26 | 
| COL1027_SESSIONMORETHAN13MONTHS3 | 1         |  2018-05-01T00:00:00Z  |  true                            |  2018-05-01T00:00:00Z   |  2018-05-01T00:00:00Z        | 1                        |  2018-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1028_SESSIONMORETHAN12MONTHS4 | 1         |  2018-05-01T00:00:00Z  |  true                            |  2018-05-01T00:00:00Z   |  2018-05-01T00:00:00Z        | 1                        |  2018-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1029_SESSIONMORETHAN12MONTHS5 | 1         |  2018-05-01T23:59:59Z  |  true                            |  2018-05-01T23:59:59Z   |  2018-05-01T23:59:59Z        | 1                        |  2018-05-01T23:59:59Z      | 1                |  looking for work26 | 

And I load outcome data for the feature
| LoaderRef                        | ParentRef | OutcomeType | TouchPoint | ClaimedPriorityGroup | OutcomeClaimedDate     | OutcomeEffectiveDate   | 
| COL1015_SESSIONWITHIN12MONTHS1   | 1         | 1           |            | 1                    |  2019-04-29T23:59:00Z  |  2019-04-29T23:59:00Z  | 
| COL1016_SESSIONWITHIN12MONTHS2   | 1         | 2           |            | 2                    |  2019-04-29T23:59:00Z  |  2019-04-29T23:59:00Z  | 
| COL1017_SESSIONWITHIN13MONTHS3   | 1         | 3           |            | 3                    |  2019-05-29T23:59:00Z  |  2019-05-29T23:59:00Z  | 
| COL1018_SESSIONWITHIN12MONTHS4   | 1         | 4           |            | 4                    |  2019-04-29T23:59:00Z  |  2019-04-29T23:59:00Z  | 
| COL1019_SESSIONWITHIN12MONTHS5   | 1         | 5           |            | 99                   |  2019-04-29T23:59:00Z  |  2019-04-29T23:59:00Z  | 
| COL1020_SESSIONEXACTLY12MONTHS1  | 1         | 1           |            | 1                    |  2019-04-30T23:59:00Z  |  2019-04-30T23:59:00Z  | 
| COL1021_SESSIONEXACTLY12MONTHS2  | 1         | 2           |            | 2                    |  2019-04-30T23:59:00Z  |  2019-04-30T23:59:00Z  | 
| COL1022_SESSIONEXACTLY13MONTHS3  | 1         | 3           |            | 3                    |  2019-05-30T23:59:00Z  |  2019-05-30T23:59:00Z  | 
| COL1023_SESSIONEXACTLY12MONTHS4  | 1         | 4           |            | 4                    |  2019-04-30T23:59:00Z  |  2019-04-30T23:59:00Z  | 
| COL1024_SESSIONEXACTLY12MONTHS5  | 1         | 5           |            | 99                   |  2019-04-30T23:59:00Z  |  2019-04-30T23:59:00Z  | 
| COL1025_SESSIONMORETHAN12MONTHS1 | 1         | 1           |            | 1                    |  2019-04-30T23:59:00Z  |  2019-04-30T23:59:00Z  | 
| COL1026_SESSIONMORETHAN12MONTHS2 | 1         | 2           |            | 2                    |  2019-04-30T23:59:00Z  |  2019-04-30T23:59:00Z  | 
| COL1027_SESSIONMORETHAN13MONTHS3 | 1         | 3           |            | 3                    |  2019-05-30T23:59:00Z  |  2019-05-30T23:59:00Z  | 
| COL1028_SESSIONMORETHAN12MONTHS4 | 1         | 4           |            | 4                    |  2019-04-30T23:59:00Z  |  2019-04-30T23:59:00Z  | 
| COL1029_SESSIONMORETHAN12MONTHS5 | 1         | 5           |            | 99                   |  2019-04-30T23:59:00Z  |  2019-04-30T23:59:00Z  | 

And I update the following sessions
| LoaderRef                        | SessionRef | DateandTimeOfSession   | 
| COL1020_SESSIONEXACTLY12MONTHS1  | 1          |  2018-04-30T00:00:00Z  | 
| COL1021_SESSIONEXACTLY12MONTHS2  | 1          |  2018-04-30T00:00:00Z  | 
| COL1022_SESSIONEXACTLY13MONTHS3  | 1          |  2018-04-30T00:00:00Z  | 
| COL1023_SESSIONEXACTLY12MONTHS4  | 1          |  2018-04-30T23:59:59Z  | 
| COL1024_SESSIONEXACTLY12MONTHS5  | 1          |  2018-04-30T23:59:59Z  | 
| COL1025_SESSIONMORETHAN12MONTHS1 | 1          |  2018-04-29T00:00:00Z  | 
| COL1026_SESSIONMORETHAN12MONTHS2 | 1          |  2018-04-29T00:00:00Z  | 
| COL1027_SESSIONMORETHAN13MONTHS3 | 1          |  2018-04-29T00:00:00Z  | 
| COL1028_SESSIONMORETHAN12MONTHS4 | 1          |  2018-04-29T23:59:59Z  | 
| COL1029_SESSIONMORETHAN12MONTHS5 | 1          |  2018-04-29T23:59:59Z  | 



And I have made any data fudging updates required
And I have confirmed all test data is now in the backup data store
And the report period start date is "2019-04-01"
And the report period end date is "2020-03-31"
And a request has been made and the report data is available
And I have completed loading data and don't want to repeat for each test
@mytag

Scenario:  Session closure checks
		When I check the report data
		Then Outcome 1 for test customer "COL1015_SESSIONWITHIN12MONTHS1" is included in the report
		Then Outcome 1 for test customer "COL1016_SESSIONWITHIN12MONTHS2" is included in the report
		Then Outcome 1 for test customer "COL1017_SESSIONWITHIN13MONTHS3" is included in the report
		Then Outcome 1 for test customer "COL1018_SESSIONWITHIN12MONTHS4" is included in the report
		Then Outcome 1 for test customer "COL1019_SESSIONWITHIN12MONTHS5" is included in the report
		Then Outcome 1 for test customer "COL1020_SESSIONEXACTLY12MONTHS1" is included in the report
		Then Outcome 1 for test customer "COL1021_SESSIONEXACTLY12MONTHS2" is included in the report
		Then Outcome 1 for test customer "COL1022_SESSIONEXACTLY13MONTHS3" is included in the report
		Then Outcome 1 for test customer "COL1023_SESSIONEXACTLY12MONTHS4" is included in the report
		Then Outcome 1 for test customer "COL1024_SESSIONEXACTLY12MONTHS5" is included in the report
		Then Outcome 1 for test customer "COL1025_SESSIONMORETHAN12MONTHS1" is not included in the report
		Then Outcome 1 for test customer "COL1026_SESSIONMORETHAN12MONTHS2" is not included in the report
		Then Outcome 1 for test customer "COL1027_SESSIONMORETHAN13MONTHS3" is not included in the report
		Then Outcome 1 for test customer "COL1028_SESSIONMORETHAN12MONTHS4" is not included in the report
		Then Outcome 1 for test customer "COL1029_SESSIONMORETHAN12MONTHS5" is not included in the report

