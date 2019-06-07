@Collections
Feature: Report Data
	The ABCs will request a year to day report via a POST to an Rest API service

Background:

Given I load test customer data for this feature:
	#Parent for ADDRESS in CUSTOMER
| LoaderRef                       | TouchPoint | Title | GivenName | FamilyName    | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
| TS_001_SIMPLECASE1              |            | 4     | Barry     | tsone         |  Today -21Y       |  Now -3D             | 9999900030          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_002_SIMPLECASE2              |            | 4     | Terry     | tstwo         |  Today -21Y       |  Now -3D             | 9999900031          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_003_SIMPLECASE3              |            | 4     | Quest     | tsthree       |  Today -21Y       |  Now -3D             | 9999900032          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_004_TOOMANY1                 |            | 4     | Sam       | tsfour        |  Today -21Y       |  Now -3D             | 9999900033          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_005_TOOMANY2                 |            | 4     | Gerry     | tsfive        |  Today -21Y       |  Now -3D             | 9999900034          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_006_PREVSESSLT12MNTHS1       |            | 4     | Flat      | tssix         |  Today -21Y       |  Now -3D             | 9999900035          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_007_PREVSESSLT12MNTHS2       |            | 4     | Chop      | tsseven       |  Today -21Y       |  Now -3D             | 9999900036          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_008_PREVSESSLT12MNTHS3       |            | 4     | Harry     | tseight       |  Today -21Y       |  Now -3D             | 9999900037          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_009_PREVSESSGT12MNTHS1       |            | 4     | Garry     | tsnine        |  Today -21Y       |  Now -3D             | 9999900038          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_010_PREVSESSGT12MNTHS2       |            | 4     | Shim      | tsten         |  Today -21Y       |  Now -3D             | 9999900039          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_011_PREVSESSGT12MNTHS3       |            | 4     | Connie    | tseleven      |  Today -21Y       |  Now -3D             | 9999900040          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4       |            | 4     | Bas       | tstwelve      |  Today -21Y       |  Now -3D             | 9999900041          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_013_B4CONTRACTSTART          |            | 4     | Tim       | tsthirteen    |  Today -21Y       |  Now -3D             | 9999900042          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_014_AFTERREPORTEND           |            | 4     | Gray      | tsfourteen    |  Today -21Y       |  Now -3D             | 9999900043          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_015_OUTCOMEGT12MNTHS1        |            | 4     | Carter    | tsfifteen     |  Today -21Y       |  Now -3D             | 9999900044          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_016_OUTCOMEGT12MNTHS2        |            | 4     | Lil       | tssixteen     |  Today -21Y       |  Now -3D             | 9999900045          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_017_OUTCOMEGT12MNTHS3        |            | 4     | Marge     | tsseventeen   |  Today -21Y       |  Now -3D             | 9999900046          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_018_OUTCOMEGT12MNTHS4        |            | 4     | Sarah     | tseighteen    |  Today -21Y       |  Now -3D             | 9999900047          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_019_OUTCOMEGT13MNTHS1        |            | 4     | Dan       | tsnineteen    |  Today -21Y       |  Now -3D             | 9999900048          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_020_STARTOFYRBOUNDARY        |            | 4     | Dan       | tstwenty      |  Today -21Y       |  Now -3D             | 9999900049          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_021_STARTOFYRBOUNDARY        |            | 4     | Dan       | tstwentyone   |  Today -21Y       |  Now -3D             | 9999900050          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_022_STARTOFYRBOUNDARY        |            | 4     | Dan       | tstwentytwo   |  Today -21Y       |  Now -3D             | 9999900051          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_023_STARTOFYRBOUNDARY        |            | 4     | Dan       | tstwentythree |  Today -21Y       |  Now -3D             | 9999900052          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_024_STARTOFYRBOUNDARY        |            | 4     | Dan       | tstwentyfour  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 
| TS_025_ADDRESS_DUPLICATE        |            | 4     | Dan       | tstwentyfive  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_026_ADDRESS_MULTIPLE         |            | 4     | Dan       | tstwentysix   |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_027_ADDRESS_ENDED            |            | 4     | Dan       | tstwentyseven |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_028_ADDRESS_HISTORY          |            | 4     | Dan       | tstwentyeight |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_029_NONATTENDEDSESSION       |            | 4     | Dan       | tstwentynine  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_030_NULLATTENDEDSESSION      |            | 4     | Dan       | tsthirty      |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_031_ENDOFYRBOUNDARY          |            | 4     | Dan       | tsthirtyone   |  Today -21Y       |  Now -3D             | 9999900050          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_032_ENDOFYRBOUNDARY          |            | 4     | Dan       | tsthirtytwo   |  Today -21Y       |  Now -3D             | 9999900051          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_033_ENDOFYRBOUNDARY          |            | 4     | Dan       | tsthirtythree |  Today -21Y       |  Now -3D             | 9999900051          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_034_SESSIONEARLIERSAMEDAY    |            | 4     | Dan       | tsthirtyfour  |  Today -21Y       |  Now -3D             | 9999900051          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_035_OUTCOME12MONTHEARLIER1   |            | 4     | Dan       | tstwentyfour  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_036_OUTCOME12MONTHEARLIER2   |            | 4     | Dan       | tstwentyfour  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_037_OUTCOME13MONTHEARLIER1   |            | 4     | Dan       | tstwentyfour  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_038_OUTCOMELT12MONTHEARLIER1 |            | 4     | Dan       | tstwentyfour  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_039_OUTCOMELT12MONTHEARLIER2 |            | 4     | Dan       | tstwentyfour  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_040_OUTCOMELT13MONTHEARLIER2 |            | 4     | Dan       | tstwentyfour  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_041_OUTCOMEGT12MONTHEARLIER1 |            | 4     | Dan       | tstwentyfour  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_042_OUTCOMEGT12MONTHEARLIER2 |            | 4     | Dan       | tstwentyfour  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_043_OUTCOMEGT13MONTHEARLIER3 |            | 4     | Dan       | tstwentyfour  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| TS_044_LATEROUTCOMECLAIMED1     |            | 4     | Dan       | tstwentyfour  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 

And I load test address data for this feature:
| LoaderRef                  | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 
| TS_001_SIMPLECASE1         |  1 Lake Street   |  North Walsham  |          |          |          |  P01 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_002_SIMPLECASE2         |  2 Lake Street   |  North Walsham  |          |          |          |  P02 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_003_SIMPLECASE3         |  3 Lake Street   |  North Walsham  |          |          |          |  P03 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_004_TOOMANY1            |  4 Lake Street   |  North Walsham  |          |          |          |  B33 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_005_TOOMANY2            |  5 Lake Street   |  North Walsham  |          |          |          |  B34 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_006_PREVSESSLT12MNTHS1  |  6 Lake Street   |  North Walsham  |          |          |          |  B35 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_007_PREVSESSLT12MNTHS2  |  7 Lake Street   |  North Walsham  |          |          |          |  B36 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_008_PREVSESSLT12MNTHS3  |  8 Lake Street   |  North Walsham  |          |          |          |  B37 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_009_PREVSESSGT12MNTHS1  |  9 Lake Street   |  North Walsham  |          |          |          |  B38 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_010_PREVSESSGT12MNTHS2  |  10 Lake Street  |  North Walsham  |          |          |          |  B39 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_011_PREVSESSGT12MNTHS3  |  11 Lake Street  |  North Walsham  |          |          |          |  B40 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_012_PREVSESSGT12MNTHS4  |  12 Lake Street  |  North Walsham  |          |          |          |  B41 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_025_ADDRESS_DUPLICATE   |  13 Lake Street  |  North Walsham  |          |          |          |  B41 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_025_ADDRESS_DUPLICATE   |  13 Lake Street  |  North Walsham  |          |          |          |  B41 9UX   |  EC2P 2AG           |           |          |                      |                      | 2019-01-23T00:00:00Z | 90000001                 | 
| TS_026_ADDRESS_MULTIPLE    |  14 Lake Street  |  North Walsham  |          |          |          |  B42 9UX   |                     |           |          |                      |                      | 2019-01-23T00:00:00Z |                          | 
| TS_026_ADDRESS_MULTIPLE    |  15 Lake Street  |  North Walsham  |          |          |          |  B43 9UX   |                     |           |          |                      |                      | 2019-01-23T00:00:01Z |                          | 
| TS_026_ADDRESS_MULTIPLE    |  16 Lake Street  |  North Walsham  |          |          |          |  B44 9UX   |                     |           |          |                      |                      | 2019-01-23T00:00:02Z |                          | 
| TS_027_ADDRESS_ENDED       |  17 Lake Street  |  North Walsham  |          |          |          |  B44 8UX   |                     |           |          | 2019-01-23T00:00:01Z | 2019-02-23T00:00:01Z |                      |                          | 
| TS_028_ADDRESS_HISTORY     |  17 Lake Street  |  North Walsham  |          |          |          |  B46 8UX   |                     |           |          | 2019-01-23T00:00:01Z | 2019-02-23T00:00:01Z |                      |                          | 
| TS_028_ADDRESS_HISTORY     |  18 Lake Street  |  North Walsham  |          |          |          |  B45 8UX   |                     |           |          | 2019-02-23T00:00:01Z | 2019-03-23T00:00:01Z |                      |                          | 
| TS_028_ADDRESS_HISTORY     |  19 Lake Street  |  North Walsham  |          |          |          |  B47 8UX   |                     |           |          | 2019-03-24T00:00:01Z |                      |                      |                          | 
| TS_029_NONATTENDEDSESSION  |  20 Lake Street  |  North Walsham  |          |          |          |  B47 8UX   |                     |           |          | 2019-03-24T00:00:01Z |                      |                      |                          | 
| TS_030_NULLATTENDEDSESSION |  21 Lake Street  |  North Walsham  |          |          |          |  B47 8UX   |                     |           |          | 2019-03-24T00:00:01Z |                      |                      |                          | 

And I load test contact data for this feature:
| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

 And I load test interaction data for this feature
#	#Parent for INTERACTION is CUSTOMER
| LoaderRef                       | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
| TS_001_SIMPLECASE1              |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_002_SIMPLECASE2              |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_003_SIMPLECASE3              |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_004_TOOMANY1                 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_005_TOOMANY2                 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-04-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_006_PREVSESSLT12MNTHS1       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_006_PREVSESSLT12MNTHS1       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-04T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_007_PREVSESSLT12MNTHS2       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_007_PREVSESSLT12MNTHS2       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-04T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_008_PREVSESSLT12MNTHS3       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_008_PREVSESSLT12MNTHS3       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-04T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_009_PREVSESSGT12MNTHS1       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_009_PREVSESSGT12MNTHS1       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_010_PREVSESSGT12MNTHS2       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_010_PREVSESSGT12MNTHS2       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-06T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_011_PREVSESSGT12MNTHS3       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_011_PREVSESSGT12MNTHS3       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-06T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_012_PREVSESSGT12MNTHS4       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-10-05T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_012_PREVSESSGT12MNTHS4       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-10-06T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_013_B4CONTRACTSTART          |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2018-09-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_014_AFTERREPORTEND           |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-05-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_015_OUTCOMEGT12MNTHS1        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_016_OUTCOMEGT12MNTHS2        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_017_OUTCOMEGT12MNTHS3        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_018_OUTCOMEGT12MNTHS4        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_019_OUTCOMEGT13MNTHS1        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_020_STARTOFYRBOUNDARY        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_021_STARTOFYRBOUNDARY        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_022_STARTOFYRBOUNDARY        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_023_STARTOFYRBOUNDARY        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_024_STARTOFYRBOUNDARY        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_025_ADDRESS_DUPLICATE        |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_026_ADDRESS_MULTIPLE         |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_027_ADDRESS_ENDED            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_028_ADDRESS_HISTORY          |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_029_NONATTENDEDSESSION       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-02-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_029_NONATTENDEDSESSION       |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_030_NULLATTENDEDSESSION      |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-02-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_030_NULLATTENDEDSESSION      |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_031_ENDOFYRBOUNDARY          |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_032_ENDOFYRBOUNDARY          |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_033_ENDOFYRBOUNDARY          |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_034_SESSIONEARLIERSAMEDAY    |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_035_OUTCOME12MONTHEARLIER1   |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_036_OUTCOME12MONTHEARLIER2   |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_037_OUTCOME13MONTHEARLIER1   |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_038_OUTCOMELT12MONTHEARLIER1 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_039_OUTCOMELT12MONTHEARLIER2 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_040_OUTCOMELT13MONTHEARLIER2 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_041_OUTCOMEGT12MONTHEARLIER1 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_042_OUTCOMEGT12MONTHEARLIER2 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_043_OUTCOMEGT13MONTHEARLIER3 |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| TS_044_LATEROUTCOMECLAIMED1     |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

	And I load test session data for the feature
| LoaderRef                       | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended    | ReasonForNonAttendance   | LastModifiedDate       | LastModifiedTouchpointId | 
| TS_001_SIMPLECASE1              | 1         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-04-05T00:00:00Z  | 90000001                 | 
| TS_002_SIMPLECASE2              | 1         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-04-05T00:00:00Z  | 90000001                 | 
| TS_003_SIMPLECASE3              | 1         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-04-05T00:00:00Z  | 90000001                 | 
| TS_004_TOOMANY1                 | 1         |  2019-04-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-04-05T00:00:00Z  | 90000001                 | 
| TS_005_TOOMANY2                 | 1         |  2019-04-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-04-05T00:00:00Z  | 90000001                 | 
| TS_006_PREVSESSLT12MNTHS1       | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2018-10-05T00:00:00Z  | 90000001                 | 
| TS_006_PREVSESSLT12MNTHS1       | 2         |  2019-10-04T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-10-04T00:00:00Z  | 90000001                 | 
| TS_007_PREVSESSLT12MNTHS2       | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2018-10-05T00:00:00Z  | 90000001                 | 
| TS_007_PREVSESSLT12MNTHS2       | 2         |  2019-10-04T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-10-04T00:00:00Z  | 90000001                 | 
| TS_008_PREVSESSLT12MNTHS3       | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2018-10-05T00:00:00Z  | 90000001                 | 
| TS_008_PREVSESSLT12MNTHS3       | 2         |  2019-10-04T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-10-04T00:00:00Z  | 90000001                 | 
| TS_009_PREVSESSGT12MNTHS1       | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2018-10-05T00:00:00Z  | 90000001                 | 
| TS_009_PREVSESSGT12MNTHS1       | 2         |  2019-10-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-10-05T00:00:00Z  | 90000001                 | 
| TS_010_PREVSESSGT12MNTHS2       | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2018-10-05T00:00:00Z  | 90000001                 | 
| TS_010_PREVSESSGT12MNTHS2       | 2         |  2019-10-06T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-10-06T00:00:00Z  | 90000001                 | 
| TS_011_PREVSESSGT12MNTHS3       | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2018-10-05T00:00:00Z  | 90000001                 | 
| TS_011_PREVSESSGT12MNTHS3       | 2         |  2019-10-06T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-10-06T00:00:00Z  | 90000001                 | 
| TS_012_PREVSESSGT12MNTHS4       | 1         |  2018-10-05T00:00:00Z  |  NE9 7RG               |  true              |                          |  2018-10-05T00:00:00Z  | 90000001                 | 
| TS_012_PREVSESSGT12MNTHS4       | 2         |  2019-10-06T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-10-06T00:00:00Z  | 90000001                 | 
| TS_013_B4CONTRACTSTART          | 1         |  2018-09-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2018-09-01T00:00:00Z  | 90000001                 | 
| TS_014_AFTERREPORTEND           | 1         |  2019-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-05-01T00:00:00Z  | 90000001                 | 
| TS_015_OUTCOMEGT12MNTHS1        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_016_OUTCOMEGT12MNTHS2        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_017_OUTCOMEGT12MNTHS3        | 1         |  2019-03-02T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-02T00:00:00Z  | 90000001                 | 
| TS_018_OUTCOMEGT12MNTHS4        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_019_OUTCOMEGT13MNTHS1        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_020_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_021_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_022_STARTOFYRBOUNDARY        | 1         |  2019-03-02T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-02T00:00:00Z  | 90000001                 | 
| TS_023_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_024_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_025_ADDRESS_DUPLICATE        | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_026_ADDRESS_MULTIPLE         | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_027_ADDRESS_ENDED            | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_028_ADDRESS_HISTORY          | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_029_NONATTENDEDSESSION       | 1         |  2019-02-01T00:00:00Z  |  NE9 7RG               |  false             |                          |  2019-02-01T00:00:00Z  | 90000001                 | 
| TS_029_NONATTENDEDSESSION       | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_030_NULLATTENDEDSESSION      | 1         |  2019-02-01T00:00:00Z  |  NE9 7RG               |                    |                          |  2019-02-01T00:00:00Z  | 90000001                 | 
| TS_030_NULLATTENDEDSESSION      | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_031_ENDOFYRBOUNDARY          | 1         |  2020-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2020-03-01T00:00:00Z  | 90000001                 | 
| TS_032_ENDOFYRBOUNDARY          | 1         |  2020-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2020-03-01T00:00:00Z  | 90000001                 | 
| TS_033_ENDOFYRBOUNDARY          | 1         |  2020-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2020-03-01T00:00:00Z  | 90000001                 | 
| TS_034_SESSIONEARLIERSAMEDAY    | 1         |  2019-04-22T09:12:02Z  |  NE9 7RG               |  false             |                          |  2019-04-22T09:12:02Z  | 90000001                 | 
| TS_034_SESSIONEARLIERSAMEDAY    | 1         |  2019-04-22T10:15:00Z  |  NE9 7RG               |  false             |                          |  2019-04-22T10:15:00Z  | 90000001                 | 
| TS_034_SESSIONEARLIERSAMEDAY    | 1         |  2019-04-22T16:15:00Z  |  NE9 7RG               |  true              |                          |  2019-04-22T10:15:00Z  | 90000001                 | 
| TS_034_SESSIONEARLIERSAMEDAY    | 1         |  2019-04-22T18:15:00Z  |  NE9 7RG               |  true              |                          |  2019-04-22T18:15:00Z  | 90000001                 | 
| TS_035_OUTCOME12MONTHEARLIER1   | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_036_OUTCOME12MONTHEARLIER2   | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_037_OUTCOME13MONTHEARLIER1   | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_038_OUTCOMELT12MONTHEARLIER1 | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_039_OUTCOMELT12MONTHEARLIER2 | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_040_OUTCOMELT13MONTHEARLIER2 | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_041_OUTCOMEGT12MONTHEARLIER1 | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_042_OUTCOMEGT12MONTHEARLIER2 | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_043_OUTCOMEGT13MONTHEARLIER3 | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 
| TS_044_LATEROUTCOMECLAIMED1     | 1         |  2019-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |  2019-03-01T00:00:00Z  | 90000001                 | 

And I load action plan data for the feature
| LoaderRef                       | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
| TS_001_SIMPLECASE1              | 1         |  2019-04-05T00:00:00Z  |  true                            |  2019-04-05T00:00:00Z   |  2019-04-05T00:00:00Z        | 1                        |  2019-04-05T00:00:00Z      | 1                |  looking for work26 | 
| TS_002_SIMPLECASE2              | 1         |  2019-04-05T00:00:00Z  |  true                            |  2019-04-05T00:00:00Z   |  2019-04-05T00:00:00Z        | 1                        |  2019-04-05T00:00:00Z      | 1                |  looking for work26 | 
| TS_003_SIMPLECASE3              | 1         |  2019-04-05T00:00:00Z  |  true                            |  2019-04-05T00:00:00Z   |  2019-04-05T00:00:00Z        | 1                        |  2019-04-05T00:00:00Z      | 1                |  looking for work26 | 
| TS_004_TOOMANY1                 | 1         |  2019-04-05T00:00:00Z  |  true                            |  2019-04-05T00:00:00Z   |  2019-04-05T00:00:00Z        | 1                        |  2019-04-05T00:00:00Z      | 1                |  looking for work26 | 
| TS_005_TOOMANY2                 | 1         |  2019-04-05T00:00:00Z  |  true                            |  2019-04-05T00:00:00Z   |  2019-04-05T00:00:00Z        | 1                        |  2019-04-05T00:00:00Z      | 1                |  looking for work26 | 
| TS_006_PREVSESSLT12MNTHS1       | 1         |  2018-10-05T00:00:00Z  |  true                            |  2018-10-05T00:00:00Z   |  2018-10-05T00:00:00Z        | 1                        |  2018-10-05T00:00:00Z      | 1                |  looking for work26 | 
| TS_006_PREVSESSLT12MNTHS1       | 2         |  2019-10-04T00:00:00Z  |  true                            |  2019-10-04T00:00:00Z   |  2019-10-04T00:00:00Z        | 1                        |  2019-10-04T00:00:00Z      | 1                |  looking for work26 | 
| TS_007_PREVSESSLT12MNTHS2       | 1         |  2018-10-05T00:00:00Z  |  true                            |  2018-10-05T00:00:00Z   |  2018-10-05T00:00:00Z        | 1                        |  2018-10-05T00:00:00Z      | 1                |  looking for work26 | 
| TS_007_PREVSESSLT12MNTHS2       | 2         |  2019-10-04T00:00:00Z  |  true                            |  2019-10-04T00:00:00Z   |  2019-10-04T00:00:00Z        | 1                        |  2019-10-04T00:00:00Z      | 1                |  looking for work26 | 
| TS_008_PREVSESSLT12MNTHS3       | 1         |  2018-10-05T00:00:00Z  |  true                            |  2018-10-05T00:00:00Z   |  2018-10-05T00:00:00Z        | 1                        |  2018-10-05T00:00:00Z      | 1                |  looking for work26 | 
| TS_008_PREVSESSLT12MNTHS3       | 2         |  2019-10-04T00:00:00Z  |  true                            |  2019-10-04T00:00:00Z   |  2019-10-04T00:00:00Z        | 1                        |  2019-10-04T00:00:00Z      | 1                |  looking for work26 | 
| TS_009_PREVSESSGT12MNTHS1       | 1         |  2018-10-05T00:00:00Z  |  true                            |  2018-10-05T00:00:00Z   |  2018-10-05T00:00:00Z        | 1                        |  2018-10-05T00:00:00Z      | 1                |  looking for work26 | 
| TS_009_PREVSESSGT12MNTHS1       | 2         |  2019-10-05T00:00:00Z  |  true                            |  2019-10-05T00:00:00Z   |  2019-10-05T00:00:00Z        | 1                        |  2019-10-05T00:00:00Z      | 1                |  looking for work26 | 
| TS_010_PREVSESSGT12MNTHS2       | 1         |  2018-10-05T00:00:00Z  |  true                            |  2018-10-05T00:00:00Z   |  2018-10-05T00:00:00Z        | 1                        |  2018-10-05T00:00:00Z      | 1                |  looking for work26 | 
| TS_010_PREVSESSGT12MNTHS2       | 2         |  2019-10-06T00:00:00Z  |  true                            |  2019-10-06T00:00:00Z   |  2019-10-06T00:00:00Z        | 1                        |  2019-10-06T00:00:00Z      | 1                |  looking for work26 | 
| TS_011_PREVSESSGT12MNTHS3       | 1         |  2018-10-05T00:00:00Z  |  true                            |  2018-10-05T00:00:00Z   |  2018-10-05T00:00:00Z        | 1                        |  2018-10-05T00:00:00Z      | 1                |  looking for work26 | 
| TS_011_PREVSESSGT12MNTHS3       | 2         |  2019-10-06T00:00:00Z  |  true                            |  2019-10-06T00:00:00Z   |  2019-10-06T00:00:00Z        | 1                        |  2019-10-06T00:00:00Z      | 1                |  looking for work26 | 
| TS_012_PREVSESSGT12MNTHS4       | 1         |  2018-10-05T00:00:00Z  |  true                            |  2018-10-05T00:00:00Z   |  2018-10-05T00:00:00Z        | 1                        |  2018-10-05T00:00:00Z      | 1                |  looking for work26 | 
| TS_012_PREVSESSGT12MNTHS4       | 2         |  2019-10-06T00:00:00Z  |  true                            |  2019-10-06T00:00:00Z   |  2019-10-06T00:00:00Z        | 1                        |  2019-10-06T00:00:00Z      | 1                |  looking for work26 | 
| TS_013_B4CONTRACTSTART          | 1         |  2018-09-01T00:00:00Z  |  true                            |  2018-09-01T00:00:00Z   |  2018-09-01T00:00:00Z        | 1                        |  2018-09-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_014_AFTERREPORTEND           | 1         |  2019-05-01T00:00:00Z  |  true                            |  2019-05-01T00:00:00Z   |  2019-05-01T00:00:00Z        | 1                        |  2019-05-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_015_OUTCOMEGT12MNTHS1        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_016_OUTCOMEGT12MNTHS2        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_017_OUTCOMEGT12MNTHS3        | 1         |  2019-03-02T00:00:00Z  |  true                            |  2019-03-02T00:00:00Z   |  2019-03-02T00:00:00Z        | 1                        |  2019-03-02T00:00:00Z      | 1                |  looking for work26 | 
| TS_018_OUTCOMEGT12MNTHS4        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_019_OUTCOMEGT13MNTHS1        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_020_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_021_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_022_STARTOFYRBOUNDARY        | 1         |  2019-03-02T00:00:00Z  |  true                            |  2019-03-02T00:00:00Z   |  2019-03-02T00:00:00Z        | 1                        |  2019-03-02T00:00:00Z      | 1                |  looking for work26 | 
| TS_023_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_024_STARTOFYRBOUNDARY        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_025_ADDRESS_DUPLICATE        | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_026_ADDRESS_MULTIPLE         | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_027_ADDRESS_ENDED            | 1         |  2019-03-02T00:00:00Z  |  true                            |  2019-03-02T00:00:00Z   |  2019-03-02T00:00:00Z        | 1                        |  2019-03-02T00:00:00Z      | 1                |  looking for work26 | 
| TS_028_ADDRESS_HISTORY          | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_029_NONATTENDEDSESSION       | 2         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_030_NULLATTENDEDSESSION      | 2         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2020-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_031_ENDOFYRBOUNDARY          | 1         |  2020-03-01T00:00:00Z  |  true                            |  2020-03-01T00:00:00Z   |  2020-03-01T00:00:00Z        | 1                        |  2020-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_032_ENDOFYRBOUNDARY          | 1         |  2020-03-01T00:00:00Z  |  true                            |  2020-03-01T00:00:00Z   |  2020-03-01T00:00:00Z        | 1                        |  2020-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_033_ENDOFYRBOUNDARY          | 1         |  2020-03-01T00:00:00Z  |  true                            |  2020-03-01T00:00:00Z   |  2020-03-01T00:00:00Z        | 1                        |  2020-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_034_SESSIONEARLIERSAMEDAY    | 3         |  2019-04-22T16:15:00Z  |  true                            |  2019-04-22T16:15:00Z   |  2019-04-22T16:15:00Z        | 1                        |  2019-04-22T16:15:00Z      | 1                |  looking for work26 | 
| TS_034_SESSIONEARLIERSAMEDAY    | 4         |  2019-04-22T18:15:00Z  |  true                            |  2019-04-22T18:15:00Z   |  2019-04-22T18:15:00Z        | 1                        |  2019-04-22T18:15:00Z      | 1                |  looking for work26 | 
| TS_035_OUTCOME12MONTHEARLIER1   | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_036_OUTCOME12MONTHEARLIER2   | 1         |  2019-03-02T00:00:00Z  |  true                            |  2019-03-02T00:00:00Z   |  2019-03-02T00:00:00Z        | 1                        |  2019-03-02T00:00:00Z      | 1                |  looking for work26 | 
| TS_037_OUTCOME13MONTHEARLIER1   | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_038_OUTCOMELT12MONTHEARLIER1 | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_039_OUTCOMELT12MONTHEARLIER2 | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_040_OUTCOMELT13MONTHEARLIER2 | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_041_OUTCOMEGT12MONTHEARLIER1 | 1         |  2019-03-02T00:00:00Z  |  true                            |  2019-03-02T00:00:00Z   |  2019-03-02T00:00:00Z        | 1                        |  2019-03-02T00:00:00Z      | 1                |  looking for work26 | 
| TS_042_OUTCOMEGT12MONTHEARLIER2 | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_043_OUTCOMEGT13MONTHEARLIER3 | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 
| TS_044_LATEROUTCOMECLAIMED1     | 1         |  2019-03-01T00:00:00Z  |  true                            |  2019-03-01T00:00:00Z   |  2019-03-01T00:00:00Z        | 1                        |  2019-03-01T00:00:00Z      | 1                |  looking for work26 | 

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
| TS_004_TOOMANY1                 | 1         | 1           |            | 4                    |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
| TS_004_TOOMANY1                 | 1         | 1           |            | 99                   |  2019-08-09T00:00:00Z  |  2019-08-09T00:00:00Z  | 
| TS_004_TOOMANY1                 | 1         | 2           |            | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_005_TOOMANY2                 | 1         | 3           |            | 4                    |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
| TS_005_TOOMANY2                 | 1         | 4           |            | 99                   |  2019-08-09T00:00:00Z  |  2019-08-09T00:00:00Z  | 
| TS_005_TOOMANY2                 | 1         | 5           |            | 6                    |  2020-02-03T00:00:00Z  |  2020-02-03T00:00:00Z  | 
| TS_005_TOOMANY2                 | 1         | 2           |            | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_006_PREVSESSLT12MNTHS1       | 2         | 1           |            | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_006_PREVSESSLT12MNTHS1       | 2         | 2           |            | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_006_PREVSESSLT12MNTHS1       | 2         | 3           |            | 6                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_007_PREVSESSLT12MNTHS2       | 1         | 3           |            | 99                   |  2019-03-03T00:00:00Z  |  2019-03-03T00:00:00Z  | 
| TS_007_PREVSESSLT12MNTHS2       | 2         | 1           |            | 99                   |  2020-05-03T00:00:00Z  |  2020-05-03T00:00:00Z  | 
| TS_007_PREVSESSLT12MNTHS2       | 2         | 2           |            | 99                   |  2020-06-03T00:00:00Z  |  2020-06-03T00:00:00Z  | 
| TS_008_PREVSESSLT12MNTHS3       | 1         | 1           |            | 99                   |  2019-05-03T00:00:00Z  |  2019-05-03T00:00:00Z  | 
| TS_008_PREVSESSLT12MNTHS3       | 2         | 2           |            | 99                   |  2020-06-03T00:00:00Z  |  2020-06-03T00:00:00Z  | 
| TS_008_PREVSESSLT12MNTHS3       | 2         | 3           |            | 99                   |                        |                        | 
| TS_009_PREVSESSGT12MNTHS1       | 1         | 1           |            | 1                    |  2019-12-03T00:00:00Z  |  2019-12-03T00:00:00Z  | 
| TS_009_PREVSESSGT12MNTHS1       | 2         | 2           |            | 2                    |  2020-01-03T00:00:00Z  |  2020-01-03T00:00:00Z  | 
| TS_009_PREVSESSGT12MNTHS1       | 2         | 3           |            | 99                   |  2020-02-03T00:00:00Z  |  2020-02-03T00:00:00Z  | 
| TS_010_PREVSESSGT12MNTHS2       | 1         | 2           |            | 99                   |  2019-03-03T00:00:00Z  |  2019-03-03T00:00:00Z  | 
| TS_010_PREVSESSGT12MNTHS2       | 2         | 1           |            | 1                    |  2019-12-03T00:00:00Z  |  2019-12-03T00:00:00Z  | 
| TS_010_PREVSESSGT12MNTHS2       | 2         | 2           |            | 2                    |  2020-01-03T00:00:00Z  |  2020-01-03T00:00:00Z  | 
| TS_010_PREVSESSGT12MNTHS2       | 2         | 3           |            | 99                   |  2020-02-03T00:00:00Z  |  2020-02-03T00:00:00Z  | 
| TS_011_PREVSESSGT12MNTHS3       | 1         | 1           |            | 1                    |  2019-07-03T00:00:00Z  |  2019-07-03T00:00:00Z  | 
| TS_011_PREVSESSGT12MNTHS3       | 2         | 2           |            | 2                    |  2020-01-03T00:00:00Z  |  2020-01-03T00:00:00Z  | 
| TS_011_PREVSESSGT12MNTHS3       | 2         | 3           |            | 99                   |  2020-02-03T00:00:00Z  |  2020-02-03T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4       | 1         | 1           |            | 1                    |  2019-07-03T00:00:00Z  |  2019-07-03T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4       | 1         | 2           |            | 2                    |  2019-08-03T00:00:00Z  |  2019-08-03T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4       | 1         | 3           |            | 99                   |  2019-09-03T00:00:00Z  |  2019-09-03T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4       | 2         | 1           |            | 1                    |  2019-11-03T00:00:00Z  |  2019-11-03T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4       | 2         | 2           |            | 2                    |  2020-01-03T00:00:00Z  |  2020-01-03T00:00:00Z  | 
| TS_012_PREVSESSGT12MNTHS4       | 2         | 4           |            | 99                   |  2020-02-03T00:00:00Z  |  2020-02-03T00:00:00Z  | 
| TS_013_B4CONTRACTSTART          | 1         | 2           |            | 99                   |  2018-09-03T00:00:00Z  |  2018-09-03T00:00:00Z  | 
| TS_014_AFTERREPORTEND           | 1         | 2           |            | 99                   |  2020-04-03T00:00:00Z  |  2020-04-03T00:00:00Z  | 
| TS_015_OUTCOMEGT12MNTHS1        | 1         | 2           |            | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
| TS_015_OUTCOMEGT12MNTHS1        | 1         | 1           |            | 99                   |  2020-03-02T00:00:00Z  |  2020-03-02T00:00:00Z  | 
| TS_016_OUTCOMEGT12MNTHS2        | 1         | 1           |            | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
| TS_016_OUTCOMEGT12MNTHS2        | 1         | 2           |            | 99                   |  2020-03-02T00:00:00Z  |  2020-03-02T00:00:00Z  | 
| TS_017_OUTCOMEGT12MNTHS3        | 1         | 5           |            | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
| TS_018_OUTCOMEGT12MNTHS4        | 1         | 5           |            | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
| TS_018_OUTCOMEGT12MNTHS4        | 1         | 4           |            | 99                   |  2020-02-28T00:00:00Z  |  2020-02-28T00:00:00Z  | 
| TS_019_OUTCOMEGT13MNTHS1        | 1         | 5           |            | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
| TS_019_OUTCOMEGT13MNTHS1        | 1         | 3           |            | 99                   |  2020-04-02T00:00:00Z  |  2020-04-02T00:00:00Z  | 
| TS_020_STARTOFYRBOUNDARY        | 1         | 1           |            | 99                   |  2019-03-31T00:00:00Z  |  2019-03-31T00:00:00Z  | 
| TS_020_STARTOFYRBOUNDARY        | 1         | 2           |            | 1                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| TS_020_STARTOFYRBOUNDARY        | 1         | 1           |            | 2                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| TS_021_STARTOFYRBOUNDARY        | 1         | 3           |            | 3                    |  2019-04-02T00:00:00Z  |  2019-04-02T00:00:00Z  | 
| TS_022_STARTOFYRBOUNDARY        | 1         | 5           |            | 4                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| TS_023_STARTOFYRBOUNDARY        | 1         | 5           |            | 5                    |  2019-04-02T00:00:00Z  |  2019-04-02T00:00:00Z  | 
| TS_024_STARTOFYRBOUNDARY        | 1         | 3           |            | 6                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| TS_025_ADDRESS_DUPLICATE        | 1         | 1           |            | 99                   |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| TS_026_ADDRESS_MULTIPLE         | 1         | 2           |            | 1                    |  2019-04-02T00:00:00Z  |  2019-04-02T00:00:00Z  | 
| TS_027_ADDRESS_ENDED            | 1         | 3           |            | 2                    |  2019-04-03T00:00:00Z  |  2019-04-03T00:00:00Z  | 
| TS_028_ADDRESS_HISTORY          | 1         | 1           |            | 3                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| TS_029_NONATTENDEDSESSION       | 1         | 1           |            | 3                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| TS_030_NULLATTENDEDSESSION      | 1         | 1           |            | 3                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| TS_031_ENDOFYRBOUNDARY          | 1         | 2           |            | 1                    |  2020-03-31T00:00:00Z  |  2020-03-31T00:00:00Z  | 
| TS_032_ENDOFYRBOUNDARY          | 1         | 1           |            | 2                    |  2020-03-31T11:59:00Z  |  2020-03-31T11:59:00Z  | 
| TS_033_ENDOFYRBOUNDARY          | 1         | 1           |            | 2                    |  2020-04-01T11:59:00Z  |  2020-03-31T11:59:00Z  | 
| TS_034_SESSIONEARLIERSAMEDAY    | 1         | 1           |            | 2                    |  2019-05-01T11:59:00Z  |  2019-05-01T11:59:00Z  | 
| TS_034_SESSIONEARLIERSAMEDAY    | 2         | 2           |            | 2                    |  2019-05-03T11:59:00Z  |  2019-05-03T11:59:00Z  | 
| TS_035_OUTCOME12MONTHEARLIER1   | 1         | 1           |            | 99                   |  2019-03-01T00:00:00Z  |  2019-03-01T00:00:00Z  | 
| TS_035_OUTCOME12MONTHEARLIER1   | 1         | 1           |            | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
| TS_036_OUTCOME12MONTHEARLIER2   | 1         | 2           |            | 1                    |  2019-03-02T00:00:00Z  |  2019-03-02T00:00:00Z  | 
| TS_036_OUTCOME12MONTHEARLIER2   | 1         | 2           |            | 1                    |  2020-03-03T00:00:00Z  |  2020-03-02T00:00:00Z  | 
| TS_037_OUTCOME13MONTHEARLIER1   | 1         | 3           |            | 2                    |  2019-03-03T00:00:00Z  |  2019-03-03T00:00:00Z  | 
| TS_037_OUTCOME13MONTHEARLIER1   | 1         | 3           |            | 2                    |  2020-04-03T00:00:00Z  |  2020-04-03T00:00:00Z  | 
| TS_038_OUTCOMELT12MONTHEARLIER1 | 1         | 1           |            | 99                   |  2019-03-02T00:00:00Z  |  2019-03-02T00:00:00Z  | 
| TS_038_OUTCOMELT12MONTHEARLIER1 | 1         | 1           |            | 99                   |  2020-03-01T00:00:00Z  |  2020-03-01T00:00:00Z  | 
| TS_039_OUTCOMELT12MONTHEARLIER2 | 1         | 2           |            | 1                    |  2019-03-03T00:00:00Z  |  2019-03-03T00:00:00Z  | 
| TS_039_OUTCOMELT12MONTHEARLIER2 | 1         | 2           |            | 1                    |  2020-03-03T00:00:00Z  |  2020-03-02T00:00:00Z  | 
| TS_039_OUTCOMELT12MONTHEARLIER2 | 1         | 1           |            | 1                    |                        |                        | 
| TS_039_OUTCOMELT12MONTHEARLIER2 | 1         | 1           |            | 1                    |  2020-03-01T00:00:00Z  |  2020-03-02T00:00:00Z  | 
| TS_040_OUTCOMELT13MONTHEARLIER2 | 1         | 3           |            | 2                    |  2019-03-03T00:00:00Z  |  2019-03-03T00:00:00Z  | 
| TS_040_OUTCOMELT13MONTHEARLIER2 | 1         | 3           |            | 2                    |  2020-04-03T00:00:00Z  |  2020-04-02T00:00:00Z  | 
| TS_041_OUTCOMEGT12MONTHEARLIER1 | 1         | 1           |            | 99                   |  2019-03-02T00:00:00Z  |  2019-03-02T00:00:00Z  | 
| TS_041_OUTCOMEGT12MONTHEARLIER1 | 1         | 1           |            | 99                   |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_042_OUTCOMEGT12MONTHEARLIER2 | 1         | 2           |            | 1                    |  2019-03-02T00:00:00Z  |  2019-03-02T00:00:00Z  | 
| TS_042_OUTCOMEGT12MONTHEARLIER2 | 1         | 2           |            | 1                    |  2020-03-03T00:00:00Z  |  2020-03-03T00:00:00Z  | 
| TS_043_OUTCOMEGT13MONTHEARLIER3 | 1         | 5           |            | 2                    |  2019-03-03T00:00:00Z  |  2019-03-02T00:00:00Z  | 
| TS_043_OUTCOMEGT13MONTHEARLIER3 | 1         | 2           |            | 2                    |  2020-04-03T00:00:00Z  |  2020-04-03T00:00:00Z  | 
| TS_044_LATEROUTCOMECLAIMED1     | 1         | 1           |            | 2                    |  2019-04-10T00:00:00Z  |  2019-04-10T00:00:00Z  | 
| TS_044_LATEROUTCOMECLAIMED1     | 1         | 1           |            | 2                    |  2019-05-10T00:00:00Z  |  2019-05-10T00:00:00Z  | 



And I have made any data fudging updates required
And I have confirmed all test data is now in the backup data store
And the report period start date is "2019-04-01"
And the report period end date is "2020-03-31"
And a request has been made and the report data is available
And I have completed loading data and don't want to repeat for each test


Scenario:  Outcomes are submitted early in the tax year
		When I check the report data
		Then Outcome 1 for test customer "TS_020_STARTOFYRBOUNDARY" is not included in the report
		Then Outcome 2 for test customer "TS_020_STARTOFYRBOUNDARY" is included in the report
		Then Outcome 3 for test customer "TS_020_STARTOFYRBOUNDARY" is included in the report
		Then Outcome 1 for test customer "TS_021_STARTOFYRBOUNDARY" is included in the report
		Then Outcome 1 for test customer "TS_022_STARTOFYRBOUNDARY" is included in the report
		Then Outcome 1 for test customer "TS_023_STARTOFYRBOUNDARY" is included in the report
		Then Outcome 1 for test customer "TS_024_STARTOFYRBOUNDARY" is included in the report

Scenario:: Outcomes are submitted on the last day of the report period
		When I check the report data
		Then Outcome 1 for test customer "TS_031_ENDOFYRBOUNDARY" is included in the report
		Then Outcome 1 for test customer "TS_032_ENDOFYRBOUNDARY" is included in the report
		Then Outcome 1 for test customer "TS_033_ENDOFYRBOUNDARY" is not included in the report


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
		Then Outcome 1 for test customer "TS_009_PREVSESSGT12MNTHS1" is not included in the report
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


Scenario: Duplicate Address for one customer with same timestamp
		When I check the report data
		Then Outcome 1 for test customer "TS_025_ADDRESS_DUPLICATE" is included in the report

		
Scenario: Multiple Address for one customer 
		When I check the report data
		Then Outcome 1 for test customer "TS_026_ADDRESS_MULTIPLE" is included in the report

		
Scenario: Ended Address for customer 
		When I check the report data
		Then Outcome 1 for test customer "TS_027_ADDRESS_ENDED" is included in the report

Scenario: Historic Addresses for customer 
		When I check the report data
		Then Outcome 1 for test customer "TS_028_ADDRESS_HISTORY" is included in the report

Scenario: Previous session which was not attended 
		When I check the report data
		Then Outcome 1 for test customer "TS_029_NONATTENDEDSESSION" is included in the report
		

Scenario: Previous session with NULL value in attended flag 
		When I check the report data
		Then Outcome 1 for test customer "TS_030_NULLATTENDEDSESSION" is not included in the report

Scenario: Multiple sessions on the same day
		When I check the report data
		Then Outcome 1 for test customer "TS_034_SESSIONEARLIERSAMEDAY" is included in the report
		Then Outcome 2 for test customer "TS_034_SESSIONEARLIERSAMEDAY" is not included in the report

@ignore
Scenario: Customer is more than 100 years old
		Given a request has been made and the report data is available
		Then test customer "100TMRW" is included in the report
		And test customer "100TODAY" is included in the report
		And test customer "100YESTERDAY" is not included in the report


#Scenario: Customer date of birth is not known
@ignore
Scenario: Customer DOB is not known
		Given a request has been made and the report data is available
		Then test customer "DOB_UNKNOWN" is not included in the report

@ignore
Scenario: A session exists which is dated before the contract start date
		Given a request has been made and the report data is available
		Then test customer "SESSION_ON_CONTRACT_START" is included in the report
		And test customer "SESSION_B4_CONTRACT_START" is not included in the report

@ignore
Scenario: A session exists which is dated in the future
		Given a request has been made and the report data is available
		Then test customer "SESSION_HAS_CURRENT_DATE" is included in the report
        And test customer "SESSION_NOW" is included in the report
		And test customer "SESSION_HAS_FUTURE_DATE" is not included in the report

@ignore
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



