@Collections
Feature: Post
	The ABCs will request a year to day report via a POST to an Rest API service
Background:

Given I load test customer data for this feature:
	#Parent for ADDRESS in CUSTOMER
| LoaderRef                   | TouchPoint | Title | GivenName          | FamilyName       | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
| TS_001_SIMPLECASE1          | 9000000001 | 4     | Barry              | tsone            |  Today -21Y       |  Now -3D             | 9999900030          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_002_SIMPLECASE2          | 9000000001 | 4     | Terry              | tstwo            |  Today -21Y       |  Now -3D             | 9999900031          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_003_SIMPLECASE3          | 9000000001 | 4     | Quest              | tsthree          |  Today -21Y       |  Now -3D             | 9999900032          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_004_TOOMANY1             | 9000000001 | 4     | Sam                | tsfour           |  Today -21Y       |  Now -3D             | 9999900033          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_005_TOOMANY2             | 9000000001 | 4     | Gerry              | tsfive           |  Today -21Y       |  Now -3D             | 9999900034          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_006_PREVSESSLT12MNTHS1   | 9000000001 | 4     | Flat               | tssix            |  Today -21Y       |  Now -3D             | 9999900035          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_007_PREVSESSLT12MNTHS2   | 9000000001 | 4     | Chop               | tsseven          |  Today -21Y       |  Now -3D             | 9999900036          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_008_PREVSESSLT12MNTHS3   | 9000000001 | 4     | Harry              | tseight          |  Today -21Y       |  Now -3D             | 9999900037          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_009_PREVSESSGT12MNTHS1   | 9000000001 | 4     | Garry              | tsnine           |  Today -21Y       |  Now -3D             | 9999900038          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_010_PREVSESSGT12MNTHS2   | 9000000001 | 4     | Shim               | tsten            |  Today -21Y       |  Now -3D             | 9999900039          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_011_PREVSESSGT12MNTHS3   | 9000000001 | 4     | Connie             | tseleven         |  Today -21Y       |  Now -3D             | 9999900040          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4   | 9000000001 | 4     | Bas                | tstwelve         |  Today -21Y       |  Now -3D             | 9999900041          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_013_B4CONTRACTSTART      | 9000000001 | 4     | Tim                | tsthirteen       |  Today -21Y       |  Now -3D             | 9999900041          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_014_AFTERREPORTEND       | 9000000001 | 4     | Gray               | tsfourteen       |  Today -21Y       |  Now -3D             | 9999900041          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_015_OUTCOMEGT12MNTHS1    | 9000000001 | 4     | Carter             | tsfifteen        |  Today -21Y       |  Now -3D             | 9999900041          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_016_OUTCOMEGT12MNTHS2    | 9000000001 | 4     | Lil                | tssixteen        |  Today -21Y       |  Now -3D             | 9999900041          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_017_OUTCOMEGT12MNTHS3    | 9000000001 | 4     | Marge              | tsseventeen      |  Today -21Y       |  Now -3D             | 9999900041          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_018_OUTCOMEGT12MNTHS4    | 9000000001 | 4     | Sarah              | tseighteen       |  Today -21Y       |  Now -3D             | 9999900041          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_019_OUTCOMEGT13MNTHS1    | 9000000001 | 4     | Dan                | tsnineteen       |  Today -21Y       |  Now -3D             | 9999900041          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 

And I load test address data for this feature:
| LoaderRef                 | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom | EffectiveTo | LastModifiedDate     | LastModifiedTouchpointId | 
| TS_001_SIMPLECASE1        |  1 Lake Street   |  North Walsham  |          |          |          |  B30 9UX   |  EC2P 2AG           |           |          |               |             | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_002_SIMPLECASE2        |  2 Lake Street   |  North Walsham  |          |          |          |  B31 9UX   |  EC2P 2AG           |           |          |               |             | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_003_SIMPLECASE3        |  3 Lake Street   |  North Walsham  |          |          |          |  B32 9UX   |  EC2P 2AG           |           |          |               |             | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_004_TOOMANY1           |  4 Lake Street   |  North Walsham  |          |          |          |  B33 9UX   |  EC2P 2AG           |           |          |               |             | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_005_TOOMANY2           |  5 Lake Street   |  North Walsham  |          |          |          |  B34 9UX   |  EC2P 2AG           |           |          |               |             | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_006_PREVSESSLT12MNTHS1 |  6 Lake Street   |  North Walsham  |          |          |          |  B35 9UX   |  EC2P 2AG           |           |          |               |             | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_007_PREVSESSLT12MNTHS2 |  7 Lake Street   |  North Walsham  |          |          |          |  B36 9UX   |  EC2P 2AG           |           |          |               |             | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_008_PREVSESSLT12MNTHS3 |  8 Lake Street   |  North Walsham  |          |          |          |  B37 9UX   |  EC2P 2AG           |           |          |               |             | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_009_PREVSESSGT12MNTHS1 |  9 Lake Street   |  North Walsham  |          |          |          |  B38 9UX   |  EC2P 2AG           |           |          |               |             | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_010_PREVSESSGT12MNTHS2 |  10 Lake Street  |  North Walsham  |          |          |          |  B39 9UX   |  EC2P 2AG           |           |          |               |             | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_011_PREVSESSGT12MNTHS3 |  11 Lake Street  |  North Walsham  |          |          |          |  B40 9UX   |  EC2P 2AG           |           |          |               |             | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_012_PREVSESSGT12MNTHS4 |  12 Lake Street  |  North Walsham  |          |          |          |  B41 9UX   |  EC2P 2AG           |           |          |               |             | 2019-01-23T00:00:00Z | 90000001                 | 

And I load test contact data for this feature:
| LoaderRef    | PreferredContactMethod | MobileNumber | HomeNumber   | AlternativeNumber | EmailAddress        | LastModifiedDate     | LastModifiedTouchpointId | 

 And I load test interaction data for this feature
#	#Parent for INTERACTION is CUSTOMER
| LoaderRef                   |  TouchpointId  |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
| TS_001_SIMPLECASE1          | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_002_SIMPLECASE2          | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_003_SIMPLECASE3          | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-02-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_004_TOOMANY1             | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_005_TOOMANY2             | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_006_PREVSESSLT12MNTHS1   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_006_PREVSESSLT12MNTHS1   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-04T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_007_PREVSESSLT12MNTHS2   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_007_PREVSESSLT12MNTHS2   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-04T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_008_PREVSESSLT12MNTHS3   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_008_PREVSESSLT12MNTHS3   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-04T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_009_PREVSESSGT12MNTHS1   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_009_PREVSESSGT12MNTHS1   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_010_PREVSESSGT12MNTHS2   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_010_PREVSESSGT12MNTHS2   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-06T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_011_PREVSESSGT12MNTHS3   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_011_PREVSESSGT12MNTHS3   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-06T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_012_PREVSESSGT12MNTHS4   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_012_PREVSESSGT12MNTHS4   | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-06T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_013_B4CONTRACTSTART      | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-09-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_014_AFTERREPORTEND       | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-05-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_015_OUTCOMEGT12MNTHS1    | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_016_OUTCOMEGT12MNTHS2    | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_017_OUTCOMEGT12MNTHS3    | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_018_OUTCOMEGT12MNTHS4    | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_019_OUTCOMEGT13MNTHS1    | 90000001       |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

	And I load test session data for the feature
| LoaderRef                  | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended          | ReasonForNonAttendance   | LastModifiedDate           | LastModifiedTouchpointId | 
| TS_001_SIMPLECASE1         | 1         |  2019-04-05T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-04-05T00:00:00Z      | 90000001                 | 
| TS_002_SIMPLECASE2         | 1         |  2019-04-05T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-04-05T00:00:00Z      | 90000001                 | 
| TS_003_SIMPLECASE3         | 1         |  2019-02-05T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-02-05T00:00:00Z      | 90000001                 | 
| TS_004_TOOMANY1            | 1         |  2019-04-05T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-04-05T00:00:00Z      | 90000001                 | 
| TS_005_TOOMANY2            | 1         |  2019-04-05T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-04-05T00:00:00Z      | 90000001                 | 
| TS_006_PREVSESSLT12MNTHS1  | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2018-10-05T00:00:00Z      | 90000001                 | 
| TS_006_PREVSESSLT12MNTHS1  | 2         |  2019-10-04T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-10-04T00:00:00Z      | 90000001                 | 
| TS_007_PREVSESSLT12MNTHS2  | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2018-10-05T00:00:00Z      | 90000001                 | 
| TS_007_PREVSESSLT12MNTHS2  | 2         |  2019-10-04T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-10-04T00:00:00Z      | 90000001                 | 
| TS_008_PREVSESSLT12MNTHS3  | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2018-10-05T00:00:00Z      | 90000001                 | 
| TS_008_PREVSESSLT12MNTHS3  | 2         |  2019-10-04T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-10-04T00:00:00Z      | 90000001                 | 
| TS_009_PREVSESSGT12MNTHS1  | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2018-10-05T00:00:00Z      | 90000001                 | 
| TS_009_PREVSESSGT12MNTHS1  | 2         |  2019-10-05T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-10-05T00:00:00Z      | 90000001                 | 
| TS_010_PREVSESSGT12MNTHS2  | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2018-10-05T00:00:00Z      | 90000001                 | 
| TS_010_PREVSESSGT12MNTHS2  | 2         |  2019-10-06T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-10-06T00:00:00Z      | 90000001                 | 
| TS_011_PREVSESSGT12MNTHS3  | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2018-10-05T00:00:00Z      | 90000001                 | 
| TS_011_PREVSESSGT12MNTHS3  | 2         |  2019-10-06T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-10-06T00:00:00Z      | 90000001                 | 
| TS_012_PREVSESSGT12MNTHS4  | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2018-10-05T00:00:00Z      | 90000001                 | 
| TS_012_PREVSESSGT12MNTHS4  | 2         |  2019-10-06T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-10-06T00:00:00Z      | 90000001                 | 
| TS_013_B4CONTRACTSTART     | 1         |  2018-09-01T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2018-09-01T00:00:00Z      | 90000001                 | 
| TS_014_AFTERREPORTEND      | 1         |  2019-05-01T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-05-01T00:00:00Z      | 90000001                 | 
| TS_015_OUTCOMEGT12MNTHS1   | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-03-01T00:00:00Z      | 90000001                 | 
| TS_016_OUTCOMEGT12MNTHS2   | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-03-01T00:00:00Z      | 90000001                 | 
| TS_017_OUTCOMEGT12MNTHS3   | 1         |  2019-03-02T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-03-02T00:00:00Z      | 90000001                 | 
| TS_018_OUTCOMEGT12MNTHS4   | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-03-01T00:00:00Z      | 90000001                 | 
| TS_019_OUTCOMEGT13MNTHS1   | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true                    |                          |  2019-03-01T00:00:00Z      | 90000001                 | 

And I load action plan data for the feature
| LoaderRef                  | ParentRef | DateActionPlanCreated     | CustomerCharterShownToCustomer   | DateAndTimeCharterShown   | DateActionPlanSentToCustomer   | ActionPlanDeliveryMethod | DateActionPlanAcknowledged   | PriorityCustomer | CurrentSituation     | 
| TS_001_SIMPLECASE1         | 1         |  2019-04-05T00:00:00Z     |  true                            |  2019-04-05T00:00:00Z     |  2019-04-05T00:00:00Z          | 1                        |  2019-04-05T00:00:00Z        | 1                |  looking for work26  | 
| TS_002_SIMPLECASE2         | 1         |  2019-04-05T00:00:00Z     |  true                            |  2019-04-05T00:00:00Z     |  2019-04-05T00:00:00Z          | 1                        |  2019-04-05T00:00:00Z        | 1                |  looking for work26  | 
| TS_003_SIMPLECASE3         | 1         |  2019-02-05T00:00:00Z     |  true                            |  2019-02-05T00:00:00Z     |  2019-02-05T00:00:00Z          | 1                        |  2019-02-05T00:00:00Z        | 1                |  looking for work26  | 
| TS_004_TOOMANY1            | 1         |  2019-04-05T00:00:00Z     |  true                            |  2019-04-05T00:00:00Z     |  2019-04-05T00:00:00Z          | 1                        |  2019-04-05T00:00:00Z        | 1                |  looking for work26  | 
| TS_005_TOOMANY2            | 1         |  2019-04-05T00:00:00Z     |  true                            |  2019-04-05T00:00:00Z     |  2019-04-05T00:00:00Z          | 1                        |  2019-04-05T00:00:00Z        | 1                |  looking for work26  | 
| TS_006_PREVSESSLT12MNTHS1  | 1         |  2018-10-05T00:00:00Z     |  true                            |  2018-10-05T00:00:00Z     |  2018-10-05T00:00:00Z          | 1                        |  2018-10-05T00:00:00Z        | 1                |  looking for work26  | 
| TS_006_PREVSESSLT12MNTHS1  | 2         |  2019-10-04T00:00:00Z     |  true                            |  2019-10-04T00:00:00Z     |  2019-10-04T00:00:00Z          | 1                        |  2019-10-04T00:00:00Z        | 1                |  looking for work26  | 
| TS_007_PREVSESSLT12MNTHS2  | 1         |  2018-10-05T00:00:00Z     |  true                            |  2018-10-05T00:00:00Z     |  2018-10-05T00:00:00Z          | 1                        |  2018-10-05T00:00:00Z        | 1                |  looking for work26  | 
| TS_007_PREVSESSLT12MNTHS2  | 2         |  2019-10-04T00:00:00Z     |  true                            |  2019-10-04T00:00:00Z     |  2019-10-04T00:00:00Z          | 1                        |  2019-10-04T00:00:00Z        | 1                |  looking for work26  | 
| TS_008_PREVSESSLT12MNTHS3  | 1         |  2018-10-05T00:00:00Z     |  true                            |  2018-10-05T00:00:00Z     |  2018-10-05T00:00:00Z          | 1                        |  2018-10-05T00:00:00Z        | 1                |  looking for work26  | 
| TS_008_PREVSESSLT12MNTHS3  | 2         |  2019-10-04T00:00:00Z     |  true                            |  2019-10-04T00:00:00Z     |  2019-10-04T00:00:00Z          | 1                        |  2019-10-04T00:00:00Z        | 1                |  looking for work26  | 
| TS_009_PREVSESSGT12MNTHS1  | 1         |  2018-10-05T00:00:00Z     |  true                            |  2018-10-05T00:00:00Z     |  2018-10-05T00:00:00Z          | 1                        |  2018-10-05T00:00:00Z        | 1                |  looking for work26  | 
| TS_009_PREVSESSGT12MNTHS1  | 2         |  2019-10-05T00:00:00Z     |  true                            |  2019-10-05T00:00:00Z     |  2019-10-05T00:00:00Z          | 1                        |  2019-10-05T00:00:00Z        | 1                |  looking for work26  | 
| TS_010_PREVSESSGT12MNTHS2  | 1         |  2018-10-05T00:00:00Z     |  true                            |  2018-10-05T00:00:00Z     |  2018-10-05T00:00:00Z          | 1                        |  2018-10-05T00:00:00Z        | 1                |  looking for work26  | 
| TS_010_PREVSESSGT12MNTHS2  | 2         |  2019-10-06T00:00:00Z     |  true                            |  2019-10-06T00:00:00Z     |  2019-10-06T00:00:00Z          | 1                        |  2019-10-06T00:00:00Z        | 1                |  looking for work26  | 
| TS_011_PREVSESSGT12MNTHS3  | 1         |  2018-10-05T00:00:00Z     |  true                            |  2018-10-05T00:00:00Z     |  2018-10-05T00:00:00Z          | 1                        |  2018-10-05T00:00:00Z        | 1                |  looking for work26  | 
| TS_011_PREVSESSGT12MNTHS3  | 2         |  2019-10-06T00:00:00Z     |  true                            |  2019-10-06T00:00:00Z     |  2019-10-06T00:00:00Z          | 1                        |  2019-10-06T00:00:00Z        | 1                |  looking for work26  | 
| TS_012_PREVSESSGT12MNTHS4  | 1         |  2018-10-05T00:00:00Z     |  true                            |  2018-10-05T00:00:00Z     |  2018-10-05T00:00:00Z          | 1                        |  2018-10-05T00:00:00Z        | 1                |  looking for work26  | 
| TS_012_PREVSESSGT12MNTHS4  | 2         |  2019-10-06T00:00:00Z     |  true                            |  2019-10-06T00:00:00Z     |  2019-10-06T00:00:00Z          | 1                        |  2019-10-06T00:00:00Z        | 1                |  looking for work26  | 

And I load outcome data for the feature
| LoaderRef                  | ParentRef | OutcomeType | TouchPointId | ClaimedPriorityGroup | OutcomeClaimedDate     | OutcomeEffectiveDate   | 
| TS_001_SIMPLECASE1         | 1         | 1           | 9000000090   | 99                   |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
| TS_001_SIMPLECASE1         | 1         | 2           | 9000000090   | 1                    |  2019-08-09T00:00:00Z  |  2019-08-09T00:00:00Z  | 
| TS_001_SIMPLECASE1         | 1         | 3           | 9000000090   | 2                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_002_SIMPLECASE2         | 1         | 4           | 9000000090   | 5                    |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
| TS_002_SIMPLECASE2         | 1         | 1           | 9000000090   | 99                   |  2019-08-09T00:00:00Z  |  2019-08-09T00:00:00Z  | 
| TS_002_SIMPLECASE2         | 1         | 2           | 9000000090   | 2                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_003_SIMPLECASE3         | 1         | 5           | 9000000090   | 99                   |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
| TS_003_SIMPLECASE3         | 1         | 2           | 9000000090   | 3                    |  2019-08-09T00:00:00Z  |  2019-08-09T00:00:00Z  | 
| TS_003_SIMPLECASE3         | 1         | 1           | 9000000090   | 6                    |  2020-02-03T00:00:00Z  |  2020-02-03T00:00:00Z  | 
| TS_004_TOOMANY1            | 1         | 1           | 9000000090   | 4                    |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
| TS_004_TOOMANY1            | 1         | 1           | 9000000090   | 99                   |  2019-08-09T00:00:00Z  |  2019-08-09T00:00:00Z  | 
| TS_004_TOOMANY1            | 1         | 2           | 9000000090   | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_005_TOOMANY2            | 1         | 3           | 9000000090   | 4                    |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
| TS_005_TOOMANY2            | 1         | 4           | 9000000090   | 99                   |  2019-08-09T00:00:00Z  |  2019-08-09T00:00:00Z  | 
| TS_005_TOOMANY2            | 1         | 5           | 9000000090   | 6                    |  2020-02-03T00:00:00Z  |  2020-02-03T00:00:00Z  | 
| TS_005_TOOMANY2            | 1         | 2           | 9000000090   | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_006_PREVSESSLT12MNTHS1  | 2         | 1           | 9000000090   | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_006_PREVSESSLT12MNTHS1  | 2         | 2           | 9000000090   | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_006_PREVSESSLT12MNTHS1  | 2         | 3           | 9000000090   | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_007_PREVSESSLT12MNTHS2  | 1         | 3           | 9000000090   | 99                   |  2019-03-03T00:00:00Z  |  2019-03-03T00:00:00Z  | 
| TS_007_PREVSESSLT12MNTHS2  | 2         | 1           | 9000000090   | 99                   |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
| TS_007_PREVSESSLT12MNTHS2  | 2         | 2           | 9000000090   | 99                   |  2019-06-03T00:00:00Z  |  2019-06-03T00:00:00Z  | 
| TS_008_PREVSESSLT12MNTHS3  | 1         | 1           | 9000000090   | 99                   |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
| TS_008_PREVSESSLT12MNTHS3  | 2         | 2           | 9000000090   | 99                   |  2019-06-03T00:00:00Z  |  2019-06-03T00:00:00Z  | 
| TS_008_PREVSESSLT12MNTHS3  | 2         | 3           | 9000000090   | 99                   |  2019-07-03T00:00:00Z  |  2019-07-03T00:00:00Z  | 
| TS_009_PREVSESSGT12MNTHS1  | 1         | 1           | 9000000090   | 1                    |  2019-12-03T00:00:00Z  |  2019-12-03T00:00:00Z  | 
| TS_009_PREVSESSGT12MNTHS1  | 2         | 2           | 9000000090   | 2                    |  2020-01-03T00:00:00Z  |  2020-01-03T00:00:00Z  | 
| TS_009_PREVSESSGT12MNTHS1  | 2         | 3           | 9000000090   | 99                   |  2020-02-03T00:00:00Z  |  2020-02-03T00:00:00Z  | 
| TS_010_PREVSESSGT12MNTHS2  | 1         | 2           | 9000000090   | 99                   |  2019-03-03T00:00:00Z  |  2019-03-03T00:00:00Z  | 
| TS_010_PREVSESSGT12MNTHS2  | 2         | 1           | 9000000090   | 1                    |  2019-12-03T00:00:00Z  |  2019-12-03T00:00:00Z  | 
| TS_010_PREVSESSGT12MNTHS2  | 2         | 2           | 9000000090   | 2                    |  2020-01-03T00:00:00Z  |  2020-01-03T00:00:00Z  | 
| TS_010_PREVSESSGT12MNTHS2  | 2         | 3           | 9000000090   | 99                   |  2020-02-03T00:00:00Z  |  2020-02-03T00:00:00Z  | 
| TS_011_PREVSESSGT12MNTHS3  | 1         | 1           | 9000000090   | 1                    |  2019-07-03T00:00:00Z  |  2019-07-03T00:00:00Z  | 
| TS_011_PREVSESSGT12MNTHS3  | 2         | 2           | 9000000090   | 2                    |  2020-01-03T00:00:00Z  |  2020-01-03T00:00:00Z  | 
| TS_011_PREVSESSGT12MNTHS3  | 2         | 3           | 9000000090   | 99                   |  2020-02-03T00:00:00Z  |  2020-02-03T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4  | 1         | 1           | 9000000090   | 1                    |  2019-07-03T00:00:00Z  |  2019-07-03T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4  | 1         | 2           | 9000000090   | 2                    |  2019-08-03T00:00:00Z  |  2019-08-03T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4  | 1         | 3           | 9000000090   | 99                   |  2019-09-03T00:00:00Z  |  2019-09-03T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4  | 2         | 1           | 9000000090   | 1                    |  2019-11-03T00:00:00Z  |  2019-11-03T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4  | 2         | 2           | 9000000090   | 2                    |  2020-01-03T00:00:00Z  |  2020-01-03T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4  | 2         | 4           | 9000000090   | 99                   |  2020-02-03T00:00:00Z  |  2020-02-03T00:00:00Z  | 
| TS_013_B4CONTRACTSTART     | 1         | 2           | 9000000090   | 99                   |  2018-09-03T00:00:00Z  |  2018-09-03T00:00:00Z  | 
| TS_014_AFTERREPORTEND      | 1         | 2           | 9000000090   | 99                   |  2020-04-03T00:00:00Z  |  2020-04-03T00:00:00Z  | 
| TS_015_OUTCOMEGT12MNTHS1   | 1         | 2           | 9000000090   | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
| TS_015_OUTCOMEGT12MNTHS1   | 1         | 1           | 9000000090   | 99                   |  2020-03-02T00:00:00Z  |  2020-03-02T00:00:00Z  | 
| TS_016_OUTCOMEGT12MNTHS2   | 1         | 1           | 9000000090   | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
| TS_016_OUTCOMEGT12MNTHS2   | 1         | 2           | 9000000090   | 99                   |  2020-03-02T00:00:00Z  |  2020-03-02T00:00:00Z  | 
| TS_017_OUTCOMEGT12MNTHS3   | 1         | 5           | 9000000090   | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
| TS_018_OUTCOMEGT12MNTHS4   | 1         | 5           | 9000000090   | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
| TS_018_OUTCOMEGT12MNTHS4   | 1         | 4           | 9000000090   | 99                   |  2020-02-28T00:00:00Z  |  2020-02-28T00:00:00Z  | 
| TS_019_OUTCOMEGT13MNTHS1   | 1         | 5           | 9000000090   | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
| TS_019_OUTCOMEGT13MNTHS1   | 1         | 3           | 9000000090   | 99                   |  2020-04-02T00:00:00Z  |  2020-04-02T00:00:00Z  | 

And I update the following sessions
| LoaderRef | SessionRef | DateandTimeOfSession | 



And I have made any data fudging updates required
And I have confirmed all test data is now in the backup data store
And the report period start date is "2019-04-01"
And the report period end date is "2020-03-31"
And a request has been made and the report data is available
And I have completed loading data and don't want to repeat for each test

Scenario: An earlier session was held less that 12 months earlier
		When I check the report data
		Then Outcome 1 for test customer "TS_006_PREVSESSLT12MNTHS1" is not included in the report
		Then Outcome 2 for test customer "TS_006_PREVSESSLT12MNTHS1" is not included in the report
		Then Outcome 3 for test customer "TS_006_PREVSESSLT12MNTHS1" is not included in the report
		Then Outcome 1 for test customer "TS_007_PREVSESSLT12MNTHS2" is not included in the report
		Then Outcome 2 for test customer "TS_007_PREVSESSLT12MNTHS2" is not included in the report
		Then Outcome 3 for test customer "TS_007_PREVSESSLT12MNTHS2" is not included in the report
		Then Outcome 1 for test customer "TS_008_PREVSESSLT12MNTHS3" is included in the report
		Then Outcome 2 for test customer "TS_008_PREVSESSLT12MNTHS3" is not included in the report
		Then Outcome 3 for test customer "TS_008_PREVSESSLT12MNTHS3" is not included in the report
		Then Outcome 1 for test customer "TS_009_PREVSESSGT12MNTHS1" is included in the report
		Then Outcome 2 for test customer "TS_009_PREVSESSGT12MNTHS1" is included in the report
		Then Outcome 3 for test customer "TS_009_PREVSESSGT12MNTHS1" is included in the report
		Then Outcome 1 for test customer "TS_010_PREVSESSGT12MNTHS2" is not included in the report
		Then Outcome 2 for test customer "TS_010_PREVSESSGT12MNTHS2" is included in the report
		Then Outcome 3 for test customer "TS_010_PREVSESSGT12MNTHS2" is included in the report
		Then Outcome 4 for test customer "TS_010_PREVSESSGT12MNTHS2" is included in the report
		Then Outcome 1 for test customer "TS_011_PREVSESSGT12MNTHS3" is included in the report
		Then Outcome 2 for test customer "TS_011_PREVSESSGT12MNTHS3" is included in the report
		Then Outcome 3 for test customer "TS_011_PREVSESSGT12MNTHS3" is included in the report
		Then Outcome 1 for test customer "TS_012_PREVSESSGT12MNTHS4" is included in the report
		Then Outcome 2 for test customer "TS_012_PREVSESSGT12MNTHS4" is included in the report
		Then Outcome 3 for test customer "TS_012_PREVSESSGT12MNTHS4" is included in the report
		Then Outcome 4 for test customer "TS_012_PREVSESSGT12MNTHS4" is included in the report
		Then Outcome 5 for test customer "TS_012_PREVSESSGT12MNTHS4" is included in the report
		Then Outcome 6 for test customer "TS_012_PREVSESSGT12MNTHS4" is included in the report

Scenario: Simple cases 
		When I check the report data
		Then Outcome 1 for test customer "TS_001_SIMPLECASE1" is included in the report       
		Then Outcome 2 for test customer "TS_001_SIMPLECASE1" is included in the report
		Then Outcome 1 for test customer "TS_002_SIMPLECASE2" is included in the report
		Then Outcome 2 for test customer "TS_002_SIMPLECASE2" is included in the report
		Then Outcome 3 for test customer "TS_002_SIMPLECASE2" is included in the report
		Then Outcome 1 for test customer "TS_003_SIMPLECASE3" is included in the report
		Then Outcome 2 for test customer "TS_003_SIMPLECASE3" is included in the report
		Then Outcome 3 for test customer "TS_003_SIMPLECASE3" is included in the report

Scenario: Too many outcomes are submitted
		When I check the report data
		Then Outcome 1 for test customer "TS_004_TOOMANY1" is included in the report
		Then Outcome 2 for test customer "TS_004_TOOMANY1" is not included in the report
		Then Outcome 3 for test customer "TS_004_TOOMANY1" is included in the report
		Then Outcome 1 for test customer "TS_005_TOOMANY2" is included in the report
		Then Outcome 2 for test customer "TS_005_TOOMANY2" is not included in the report
		Then Outcome 3 for test customer "TS_005_TOOMANY2" is not included in the report
		Then Outcome 4 for test customer "TS_005_TOOMANY2" is included in the report

Scenario: Outcome is submitted before the contract start date
		When I check the report data
		Then Outcome 1 for test customer "TS_013_B4CONTRACTSTART" is not included in the report

Scenario: Outcome effective date is later than the report period end
		When I check the report data
		Then Outcome 1 for test customer "TS_014_AFTERREPORTEND" is not included in the report

Scenario: An outcome is submitted more that 12 months after the session date
		When I check the report data
		Then Outcome 1 for test customer "TS_015_OUTCOMEGT12MNTHS1" is included in the report
		Then Outcome 2 for test customer "TS_015_OUTCOMEGT12MNTHS1" is not included in the report
		Then Outcome 1 for test customer "TS_016_OUTCOMEGT12MNTHS2" is included in the report
		Then Outcome 2 for test customer "TS_016_OUTCOMEGT12MNTHS2" is not included in the report
		Then Outcome 1 for test customer "TS_017_OUTCOMEGT12MNTHS3" is included in the report
		Then Outcome 1 for test customer "TS_018_OUTCOMEGT12MNTHS4" is not included in the report
		Then Outcome 2 for test customer "TS_018_OUTCOMEGT12MNTHS4" is included in the report

Scenario: An outcome is submitted more that 13 months after the session date
		When I check the report data
		Then Outcome 1 for test customer "TS_019_OUTCOMEGT13MNTHS1" is included in the report
		Then Outcome 2 for test customer "TS_019_OUTCOMEGT13MNTHS1" is not included in the report
		

Scenario: Customer is more than 100 years old
		Given a request has been made and the report data is available
		Then test customer "100TMRW" is included in the report
		And test customer "100TODAY" is included in the report
		And test customer "100YESTERDAY" is not included in the report


#Scenario: Customer date of birth is not known

Scenario: Customer DOB is not known
		Given a request has been made and the report data is available
		Then test customer "DOB_UNKNOWN" is not included in the report

Scenario: A session exists which is dated before the contract start date
		Given a request has been made and the report data is available
		Then test customer "SESSION_ON_CONTRACT_START" is included in the report
		And test customer "SESSION_B4_CONTRACT_START" is not included in the report

Scenario: A session exists which is dated in the future
		Given a request has been made and the report data is available
		Then test customer "SESSION_HAS_CURRENT_DATE" is included in the report
        And test customer "SESSION_NOW" is included in the report
		And test customer "SESSION_HAS_FUTURE_DATE" is not included in the report

Scenario: More than one sessions exist which relate to the current financial year
		Given a request has been made and the report data is available
		#2 sessions in same interaction
		Then test customer "MULTIPLE_SESSIONS_THIS_YR" is included in the report
		And outcome 1 is included for customer "MULTIPLE_SESSIONS_THIS_YR"
		And outcome 2 is included for customer "MULTIPLE_SESSIONS_THIS_YR"
		And outcome 3 is NOT included for customer "MULTIPLE_SESSIONS_THIS_YR"
		#2 sessions in different interactions
##		Then test customer "MULTIPLE_SESSIONS_THIS_YR_2" is included in the report
##		And outcome 1 is included for customer "MULTIPLE_SESSIONS_THIS_YR_2"
##		And outcome 2 is NOT included for customer "MULTIPLE_SESSIONS_THIS_YR_2"
##		And outcome 3 is NOT included for customer "MULTIPLE_SESSIONS_THIS_YR_2"
		#		And The following outcomes are include
#		| OutcomeType | OutcomeEffectiveDate |
#		| 1           | Today -50D           |
#		| 2           | Today -60D           |

#Scenario: Session date holds date only

#Scenario Outline: Multiple Customer Satisfaction outcomes exist with 12 month period
#12/13 months must start from the first Session with an ActionPlan 


#Scenario: One valid outcome exists with a 12 month period

#Scenario: Two valid outcome exists with a 12 month period

#Scenario Outline: Three valid outcome exists with a 12 month period
#12/13 months must start from the first Session with an ActionPlan 


#Scenario Outline: Multiple Career Management outcomes exist with 12 month period
#12/13 months must start from the first Session with an ActionPlan 

#Scenario Outline: Multiple Career Management outcomes exist with 12 month period
#12/13 months must start from the first Session with an ActionPlan 

#Scenario Outline: Multiple Sustainable Employment, Accredited Learning or Career Progression outcomes exist with 12/13 month period
#12/13 months must start from the first Session with an ActionPlan 

#Scenario: Outcome effective date is < 01/04/2019

#Scenario: Outcome effective date is in previous financial year

#Scenario: Outcome effective date is in a later collection period
#. if submitting in October's collection, the value must not be later than 31 October, even though the collection is open until 8th working day of November.


#Scenario: Outcome claimed date is blank

#Scenario: Career Progression outcome with at effective date < the session date

#Scenario: Career Progression outcome with at effective date > session date + 12 months

#Scenario: Sustainable Employment outcome with at effective date < the session date

#Scenario: Sustainable Employment with at effective date > session date + 13 months

#Scenario: OutcomeEffectiveDate date holds date only

#Scenario Outline: Priority Group Combinations



