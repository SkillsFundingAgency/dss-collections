Feature: ReportData_MultipleOutcomes
	
Background:

Given I load test customer data for this feature:
	#Parent for ADDRESS in CUSTOMER
| LoaderRef                        | TouchPoint | Title | GivenName | FamilyName     | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
| COL1030_OUTCOMES1                |            | 4     | Dan       | tsthirty       |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1031_OUTCOMES2                |            | 4     | Dan       | tsthirtyone    |  Today -21Y       |  Now -3D             | 9999900050          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1032_OUTCOMES3                |            | 4     | Dan       | tsthirtytwo    |  Today -21Y       |  Now -3D             | 9999900051          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1033_OUTCOMES4                |            | 4     | Dan       | tsthirtythree  |  Today -21Y       |  Now -3D             | 9999900051          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1034_OUTCOMES5                |            | 4     | Dan       | tsthirtyfour   |  Today -21Y       |  Now -3D             | 9999900051          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1035_OUTCOMES6                |            | 4     | Dan       | tsthiryfive    |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1036_OUTCOMES7                |            | 4     | Dan       | tsthirtysix    |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1037_OUTCOMES8                |            | 4     | Dan       | tsthirtyseven  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1038_OUTCOMES9                |            | 4     | Dan       | tsthirtyeight  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1039_OUTCOMES10               |            | 4     | Dan       | tsthirtynine   |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1039_OUTCOMES10A              |            | 4     | Dan       | tsthirtyninea  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1039_OUTCOMES10B              |            | 4     | Dan       | tsthirtynineb  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1040_OUTCOMES11               |            | 4     | Dan       | tsforty        |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1042a_OUTCOMES14              |            | 4     | Dan       | tsfortya       |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 

And I load test address data for this feature:
| LoaderRef                      | Address1          | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 

And I load test contact data for this feature:
| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

 And I load test interaction data for this feature
#	#Parent for INTERACTION is CUSTOMER
| LoaderRef                        | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
| COL1030_OUTCOMES1                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1031_OUTCOMES2                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1032_OUTCOMES3                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1033_OUTCOMES4                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1034_OUTCOMES5                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1035_OUTCOMES6                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1036_OUTCOMES7                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1037_OUTCOMES8                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1038_OUTCOMES9                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1039_OUTCOMES10               |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1039_OUTCOMES10A              |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1039_OUTCOMES10A              |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1039_OUTCOMES10B              |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1039_OUTCOMES10B              |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1040_OUTCOMES11               |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1042a_OUTCOMES14              |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |                        | 90000001                   | 
| COL1030_OUTCOMES1                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1031_OUTCOMES2                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1032_OUTCOMES3                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1033_OUTCOMES4                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1034_OUTCOMES5                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1035_OUTCOMES6                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1036_OUTCOMES7                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1037_OUTCOMES8                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1038_OUTCOMES9                |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-02-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1039_OUTCOMES10               |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1040_OUTCOMES11               |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

	And I load test session data for the feature
| LoaderRef           | ParentRef | DateandTimeOfSession | VenuePostCode | SessionAttended | ReasonForNonAttendance | LastModifiedDate | LastModifiedTouchpointId | SubcontractorId |
| COL1030_OUTCOMES1   | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 | 123ABC          |
| COL1031_OUTCOMES2   | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |
| COL1032_OUTCOMES3   | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |
| COL1033_OUTCOMES4   | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |
| COL1034_OUTCOMES5   | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |
| COL1035_OUTCOMES6   | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |
| COL1036_OUTCOMES7   | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | false           |                        |                  | 90000001                 |                 |
| COL1037_OUTCOMES8   | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |
| COL1038_OUTCOMES9   | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |
| COL1039_OUTCOMES10  | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |
| COL1039_OUTCOMES10A | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |
| COL1039_OUTCOMES10A | 2         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |
| COL1039_OUTCOMES10B | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |
| COL1039_OUTCOMES10B | 2         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |
| COL1040_OUTCOMES11  | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |
| COL1042a_OUTCOMES14 | 1         | 2019-04-01T00:00:00Z | NE9 7RG       | true            |                        |                  | 90000001                 |                 |

And I load action plan data for the feature
| LoaderRef                        | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
| COL1030_OUTCOMES1                | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1031_OUTCOMES2                | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1032_OUTCOMES3                | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1033_OUTCOMES4                | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1034_OUTCOMES5                | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1035_OUTCOMES6                | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1036_OUTCOMES7                | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1037_OUTCOMES8                | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1038_OUTCOMES9                | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1039_OUTCOMES10               | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1039_OUTCOMES10A              | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1039_OUTCOMES10A              | 2         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1039_OUTCOMES10B              | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1039_OUTCOMES10B              | 2         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1040_OUTCOMES11               | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1042a_OUTCOMES14              | 1         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 

And I load outcome data for the feature
| LoaderRef           | ParentRef | OutcomeType | TouchPoint | ClaimedPriorityGroup | OutcomeClaimedDate   | OutcomeEffectiveDate | LastModifiedDate     | SUbcontractorId |
| COL1030_OUTCOMES1   | 1         | 1           |            | 1                    | 2019-12-03T00:00:00Z | 2019-04-03T00:00:00Z |                      | 123ABC          |
| COL1030_OUTCOMES1   | 1         | 2           |            | 1                    | 2019-12-03T00:00:00Z | 2019-05-03T00:00:00Z |                      | 123ABC          |
| COL1030_OUTCOMES1   | 1         | 3           |            | 1                    | 2019-12-03T00:00:00Z | 2019-06-03T00:00:00Z |                      | 123ABC          |
| COL1031_OUTCOMES2   | 1         | 1           |            | 2                    | 2019-12-03T00:00:00Z | 2019-04-03T00:00:00Z |                      | 123ABC          |
| COL1031_OUTCOMES2   | 1         | 2           |            | 2                    | 2019-12-03T00:00:00Z | 2019-05-03T00:00:00Z |                      |                 |
| COL1031_OUTCOMES2   | 1         | 4           |            | 99                   | 2019-12-03T00:00:00Z | 2019-06-03T00:00:00Z |                      |                 |
| COL1032_OUTCOMES3   | 1         | 1           |            | 1                    | 2019-12-03T00:00:00Z | 2019-04-03T00:00:00Z |                      |                 |
| COL1032_OUTCOMES3   | 1         | 2           |            | 99                   | 2019-12-03T00:00:00Z | 2019-05-03T00:00:00Z |                      |                 |
| COL1032_OUTCOMES3   | 1         | 5           |            | 99                   | 2019-12-03T00:00:00Z | 2019-06-03T00:00:00Z |                      |                 |
| COL1034_OUTCOMES5   | 1         | 2           |            | 2                    | 2019-12-03T00:00:00Z | 2019-04-03T00:00:00Z |                      |                 |
| COL1034_OUTCOMES5   | 1         | 1           |            | 2                    | 2019-12-03T00:00:00Z | 2019-05-03T00:00:00Z |                      |                 |
| COL1034_OUTCOMES5   | 1         | 2           |            | 2                    | 2019-12-03T00:00:00Z | 2019-06-03T00:00:00Z |                      |                 |
| COL1034_OUTCOMES5   | 1         | 3           |            | 2                    | 2019-12-03T00:00:00Z | 2019-07-03T00:00:00Z |                      |                 |
| COL1035_OUTCOMES6   | 1         | 1           |            | 99                   | 2019-12-03T00:00:00Z | 2019-04-03T00:00:00Z |                      |                 |
| COL1035_OUTCOMES6   | 1         | 2           |            | 99                   | 2019-12-03T00:00:00Z | 2019-05-03T00:00:00Z |                      |                 |
| COL1035_OUTCOMES6   | 1         | 3           |            | 99                   | 2019-12-03T00:00:00Z | 2019-06-03T00:00:00Z |                      |                 |
| COL1035_OUTCOMES6   | 1         | 5           |            | 99                   | 2019-08-03T00:00:00Z | 2019-08-03T00:00:00Z |                      |                 |
| COL1035_OUTCOMES6   | 1         | 5           |            | 99                   | 2019-08-03T00:00:00Z | 2019-08-03T00:00:00Z |                      |                 |
| COL1036_OUTCOMES7   | 1         | 1           |            | 1                    | 2019-12-03T00:00:00Z | 2019-04-03T00:00:00Z |                      |                 |
| COL1036_OUTCOMES7   | 1         | 2           |            | 1                    | 2019-12-03T00:00:00Z | 2019-05-03T00:00:00Z |                      |                 |
| COL1036_OUTCOMES7   | 1         | 4           |            | 1                    | 2019-12-03T00:00:00Z | 2019-06-03T00:00:00Z |                      |                 |
| COL1036_OUTCOMES7   | 1         | 3           |            | 1                    | 2019-12-03T00:00:00Z | 2019-07-03T00:00:00Z |                      |                 |
| COL1036_OUTCOMES7   | 1         | 5           |            | 1                    | 2019-08-03T00:00:00Z | 2019-08-03T00:00:00Z |                      |                 |
| COL1037_OUTCOMES8   | 1         | 5           |            | 2                    | 2019-12-03T00:00:00Z | 2019-04-03T00:00:00Z |                      |                 |
| COL1037_OUTCOMES8   | 1         | 3           |            | 2                    | 2019-12-03T00:00:00Z | 2019-05-03T00:00:00Z |                      |                 |
| COL1037_OUTCOMES8   | 1         | 4           |            | 2                    | 2019-12-03T00:00:00Z | 2019-06-03T00:00:00Z |                      |                 |
| COL1037_OUTCOMES8   | 1         | 2           |            | 2                    | 2019-12-03T00:00:00Z | 2019-07-03T00:00:00Z |                      |                 |
| COL1037_OUTCOMES8   | 1         | 1           |            | 2                    | 2019-08-03T00:00:00Z | 2019-08-03T00:00:00Z |                      |                 |
| COL1038_OUTCOMES9   | 1         | 1           | 0000000999 | 99                   | 2019-12-03T00:00:00Z | 2019-04-03T00:00:00Z |                      |                 |
| COL1038_OUTCOMES9   | 1         | 1           |            | 99                   | 2019-12-03T00:00:00Z | 2019-05-03T00:00:00Z |                      |                 |
| COL1039_OUTCOMES10  | 1         | 1           | 9999999999 | 1                    | 2019-12-03T00:00:00Z | 2019-06-03T00:00:00Z |                      |                 |
| COL1039_OUTCOMES10  | 1         | 1           |            | 1                    | 2019-12-03T00:00:00Z | 2019-07-03T00:00:00Z |                      |                 |
| COL1039_OUTCOMES10A | 1         | 1           | 9999999999 | 1                    | 2019-12-03T00:00:00Z | 2019-06-03T09:00:00Z |                      |                 |
| COL1039_OUTCOMES10A | 2         | 1           |            | 1                    | 2019-12-03T00:00:00Z | 2019-06-03T09:00:01Z |                      |                 |
| COL1039_OUTCOMES10B | 1         | 1           |            | 1                    | 2019-12-03T00:00:00Z | 2019-06-03T09:00:00Z |                      |                 |
| COL1039_OUTCOMES10B | 2         | 1           | 9999999999 | 1                    | 2019-12-03T00:00:00Z | 2019-06-03T09:00:01Z |                      |                 |
| COL1040_OUTCOMES11  | 1         | 1           |            | 1                    | 2019-12-03T00:00:00Z | 2019-06-03T00:00:00Z |                      |                 |
| COL1040_OUTCOMES11  | 1         | 1           | 9999999999 | 1                    | 2019-12-03T00:00:00Z | 2019-07-03T00:00:00Z |                      |                 |
| COL1042a_OUTCOMES14 | 1         | 1           |            | 99                   | 2019-05-04T00:00:00Z | 2019-05-04T00:00:00Z | 2019-05-04T00:00:00Z |                 |
| COL1042a_OUTCOMES14 | 1         | 1           |            | 99                   | 2019-05-04T00:00:00Z | 2019-05-04T00:00:00Z | 2019-05-04T00:00:00Z |                 |

And I update the following sessions
| LoaderRef                        | SessionRef | DateandTimeOfSession   | 



And I have made any data fudging updates required
And I have confirmed all test data is now in the backup data store
And the report period start date is "2019-04-01"
And the report period end date is "2020-03-31"
And a request has been made and the report data is available
And I have completed loading data and don't want to repeat for each test

Scenario: All submitted outcomes are valid
		When I check the report data
		Then Outcome 1 for test customer "COL1030_OUTCOMES1" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  | 123ABC          | Billy Adviser | 1           | 2019-04-03           | 1                       |
		Then Outcome 2 for test customer "COL1030_OUTCOMES1" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  | 123ABC          | Billy Adviser | 2           | 2019-05-03           | 1                       |
		Then Outcome 3 for test customer "COL1030_OUTCOMES1" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  | 123ABC          | Billy Adviser | 3           | 2019-06-03           | 1                       |
		Then Outcome 1 for test customer "COL1031_OUTCOMES2" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  | 123ABC          | Billy Adviser | 1           | 2019-04-03           | 1                       |
		Then Outcome 2 for test customer "COL1031_OUTCOMES2" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 2           | 2019-05-03           | 1                       |
		Then Outcome 3 for test customer "COL1031_OUTCOMES2" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 4           | 2019-06-03           | 0                       |
		Then Outcome 1 for test customer "COL1032_OUTCOMES3" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 1           | 2019-04-03           | 1                       |
		Then Outcome 2 for test customer "COL1032_OUTCOMES3" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 2           | 2019-05-03           | 0                       |
		Then Outcome 3 for test customer "COL1032_OUTCOMES3" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 5           | 2019-06-03           | 0                       |


Scenario: Invalid Outcome are submitted where another of the same type is already present
		When I check the report data
		#OUTCOMES6
		Then Outcome 1 for test customer "COL1034_OUTCOMES5" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 2           | 2019-04-03           | 1                       |
		Then Outcome 2 for test customer "COL1034_OUTCOMES5" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 1           | 2019-05-03           | 1                       |
		Then Outcome 3 for test customer "COL1034_OUTCOMES5" is not included in the report
		Then Outcome 4 for test customer "COL1034_OUTCOMES5" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 3           | 2019-07-03           | 1                       |
		#OUTCOMES6
		Then Outcome 1 for test customer "COL1035_OUTCOMES6" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 1           | 2019-04-03           | 0                       |
		Then Outcome 2 for test customer "COL1035_OUTCOMES6" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 2           | 2019-05-03           | 0                       |
		Then Outcome 3 for test customer "COL1035_OUTCOMES6" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 3           | 2019-06-03           | 0                       |
		Then Outcome 4 for test customer "COL1035_OUTCOMES6" is not included in the report
		Then Outcome 5 for test customer "COL1035_OUTCOMES6" is not included in the report
		#OUTCOME7
		Then Outcome 1 for test customer "COL1036_OUTCOMES7" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 1           | 2019-04-03           | 1                       |
		Then Outcome 2 for test customer "COL1036_OUTCOMES7" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 2           | 2019-05-03           | 1                       |
		Then Outcome 3 for test customer "COL1036_OUTCOMES7" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 4           | 2019-06-03           | 1                       |
		Then Outcome 4 for test customer "COL1036_OUTCOMES7" is not included in the report
		Then Outcome 5 for test customer "COL1036_OUTCOMES7" is not included in the report
		#OUTCOME8
		Then Outcome 1 for test customer "COL1037_OUTCOMES8" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 5           | 2019-04-03           | 1                       |
		Then Outcome 2 for test customer "COL1037_OUTCOMES8" is not included in the report
		Then Outcome 3 for test customer "COL1037_OUTCOMES8" is not included in the report
		Then Outcome 4 for test customer "COL1037_OUTCOMES8" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 2           | 2019-07-03           | 1                       |
		Then Outcome 5 for test customer "COL1037_OUTCOMES8" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 1           | 2019-08-03           | 1                       |


Scenario:  Outcomes submitted by another party
		When I check the report data
		#outcomes9 earlier session submitted by helpline
		Then Outcome 1 for test customer "COL1038_OUTCOMES9" is not included in the report
		Then Outcome 2 for test customer "COL1038_OUTCOMES9" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 1           | 2019-05-03           | 0                       |
		#outcomes10 ealier session submitted by other touchpoint
		Then Outcome 1 for test customer "COL1039_OUTCOMES10" is not included in the report
		Then Outcome 2 for test customer "COL1039_OUTCOMES10" is not included in the report
		#outcomes10A ealier outcome submitted by other touchpoint on same day
		Then Outcome 1 for test customer "COL1039_OUTCOMES10A" is not included in the report
		Then Outcome 2 for test customer "COL1039_OUTCOMES10A" is not included in the report
		#outcomes10B later session submitted by other touchpoint on same day
		Then Outcome 1 for test customer "COL1039_OUTCOMES10B" is included in the report
		Then Outcome 2 for test customer "COL1039_OUTCOMES10B" is not included in the report
		#outcomes11 later session submitted by other touchpoint
		Then Outcome 1 for test customer "COL1040_OUTCOMES11" is included in the report with the following values
			| DateOfBirth | HomePostCode | SessionDate | SubContractorId | AdviserName   | OutcomeType | OutcomeEffectiveDate | OutcomePriorityCustomer |
			| Today -21Y  |              | 2019-04-01  |                 | Billy Adviser | 1           | 2019-06-03           | 1                       |
		Then Outcome 2 for test customer "COL1040_OUTCOMES11" is not included in the report


Scenario:  Duplicate outcomes
		When I check the report data
		#outcomes14 - duplicate outcome is submitted with same timestamp
		Then Either Outcome 1 or 2 for test customer "COL1042a_OUTCOMES14" is included in the report
		


