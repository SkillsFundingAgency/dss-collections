Feature: reportData_PreviousSessions

Background:

Given I load test customer data for this feature:
	#Parent for ADDRESS in CUSTOMER
| LoaderRef                        | TouchPoint | Title | GivenName | FamilyName     | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
| COL1043_PREVSESSION1             |            | 4     | Dan       | tsfortyone     |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1044_PREVSESSION2             |            | 4     | Dan       | tsfortytwo     |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1045_PREVSESSION3             |            | 4     | Dan       | tsfortythree   |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1046_PREVSESSION4             |            | 4     | Dan       | tsfortyfour    |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1047_PREVSESSION5             |            | 4     | Dan       | tsfortyfive    |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1048_PREVSESSION6             |            | 4     | Dan       | tsfortysix     |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1049_PREVSESSION7             |            | 4     | Dan       | tsfortyseven   |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1050_PREVSESSION8             |            | 4     | Dan       | tstsfortyeight |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1051_PREVSESSION9             |            | 4     | Dan       | tstsfortynine  |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1052_PREVSESSION10            |            | 4     | Dan       | tsfifty        |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1053_PREVSESSION11            |            | 4     | Dan       | tsfiftyone     |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1054_PREVSESSION12            |            | 4     | Dan       | tsfiftytwo     |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1055_PREVSESSION13            |            | 4     | Dan       | tsfiftythree   |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1056_PREVSESSION14            |            | 4     | Dan       | tsfiftyfour    |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1057_PREVSESSION15            |            | 4     | Dan       | tsfiftyfive    |  Today -21Y       |  Now -3D             | 9999900053          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1058_PREVSESSION16            |            | 4     | Dan       | tsfiftysix     |  Today -21Y       |  Now -3D             | 9999900054          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1059_PREVSESSION17            |            | 4     | Dan       | tsfiftyseven   |  Today -21Y       |  Now -3D             | 9999900055          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1060_PREVSESSION18            |            | 4     | Dan       | tsfiftyeight   |  Today -21Y       |  Now -3D             | 9999900056          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1061_PREVSESSION19            |            | 4     | Dan       | tsfiftynine    |  Today -21Y       |  Now -3D             | 9999900057          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1062_PREVSESSION20            |            | 4     | Dan       | tssixty        |  Today -21Y       |  Now -3D             | 9999900058          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1063_PREVSESSION21            |            | 4     | Dan       | tssixtyone     |  Today -21Y       |  Now -3D             | 9999900059          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1064_PREVSESSION22            |            | 4     | Dan       | tssixtytwo     |  Today -21Y       |  Now -3D             | 9999900060          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1065_PREVSESSION23            |            | 4     | Dan       | tssixtythree   |  Today -21Y       |  Now -3D             | 9999900061          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1066_PREVSESSION24            |            | 4     | Dan       | tssixtyfour    |  Today -21Y       |  Now -3D             | 9999900062          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1067_PREVSESSION25            |            | 4     | Dan       | tssixtyfive    |  Today -21Y       |  Now -3D             | 9999900063          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1068_PREVSESSION26            |            | 4     | Dan       | tssixtysix     |  Today -21Y       |  Now -3D             | 9999900064          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1069_PREVSESSION27            |            | 4     | Dan       | tssixtyseven   |  Today -21Y       |  Now -3D             | 9999900065          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1070_PREVSESSION28            |            | 4     | Dan       | tssixtyeight   |  Today -21Y       |  Now -3D             | 9999900066          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1071_PREVSESSION29            |            | 4     | Dan       | tssixtynine    |  Today -21Y       |  Now -3D             | 9999900067          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1072_PREVSESSION30            |            | 4     | Dan       | tssixty        |  Today -21Y       |  Now -3D             | 9999900068          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1073_PREVSESSION31            |            | 4     | Dan       | tsseventyone   |  Today -21Y       |  Now -3D             | 9999900069          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1074_PREVSESSION32            |            | 4     | Dan       | tsseventytwo   |  Today -21Y       |  Now -3D             | 9999900070          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1075_PREVSESSION33            |            | 4     | Dan       | tsseventythree |  Today -21Y       |  Now -3D             | 9999900071          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1076_PREVSESSION34            |            | 4     | Dan       | tsseventyfour  |  Today -21Y       |  Now -3D             | 9999900072          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1077_PREVSESSION35            |            | 4     | Dan       | tsseventyfive  |  Today -21Y       |  Now -3D             | 9999900073          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1078_PREVSESSION36            |            | 4     | Dan       | tsseventysix   |  Today -21Y       |  Now -3D             | 9999900074          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1079_PREVSESSION37            |            | 4     | Dan       | tsseventyseven |  Today -21Y       |  Now -3D             | 9999900075          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1080_PREVSESSION38            |            | 4     | Dan       | tsseventyeight |  Today -21Y       |  Now -3D             | 9999900076          |  true               |  false                |                     |                        |              |                              |                        | 
| COL1081_PREVSESSION39            |            | 4     | Dan       | tsseventynine  |  Today -21Y       |  Now -3D             | 9999900077          |  true               |  false                |                     |                        |              |                              |                        | 

And I load test address data for this feature:
| LoaderRef                  | Address1         | Address2        | Address3 | Address4 | Address5 | PostCode   | AlternativePostCode | Longitude | Latitude | EffectiveFrom        | EffectiveTo          | LastModifiedDate     | LastModifiedTouchpointId | 

And I load test contact data for this feature:
| LoaderRef | PreferredContactMethod | MobileNumber | HomeNumber | AlternativeNumber | EmailAddress | LastModifiedDate | LastModifiedTouchpointId | 

 And I load test interaction data for this feature
#	#Parent for INTERACTION is CUSTOMER
| LoaderRef                        | TouchPoint |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
| COL1043_PREVSESSION1             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-01-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1043_PREVSESSION1             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1044_PREVSESSION2             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1044_PREVSESSION2             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1045_PREVSESSION3             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1045_PREVSESSION3             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1046_PREVSESSION4             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1046_PREVSESSION4             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1047_PREVSESSION5             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1047_PREVSESSION5             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1048_PREVSESSION6             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1048_PREVSESSION6             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1049_PREVSESSION7             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 
| COL1049_PREVSESSION7             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1050_PREVSESSION8             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1050_PREVSESSION8             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1051_PREVSESSION9             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1051_PREVSESSION9             |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1052_PREVSESSION10            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1052_PREVSESSION10            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1053_PREVSESSION11            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1053_PREVSESSION11            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1054_PREVSESSION12            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1054_PREVSESSION12            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1055_PREVSESSION13            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1055_PREVSESSION13            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1056_PREVSESSION14            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1056_PREVSESSION14            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1057_PREVSESSION15            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1057_PREVSESSION15            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1058_PREVSESSION16            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1058_PREVSESSION16            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1059_PREVSESSION17            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1059_PREVSESSION17            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1060_PREVSESSION18            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1060_PREVSESSION18            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1061_PREVSESSION19            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1061_PREVSESSION19            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1062_PREVSESSION20            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1062_PREVSESSION20            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1063_PREVSESSION21            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1063_PREVSESSION21            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2019-03-01T00:00:00Z      | 2         | 3                 |  2019-01-23T00:00:00Z  |                            | 
| COL1064_PREVSESSION22            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1064_PREVSESSION22            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1065_PREVSESSION23            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1065_PREVSESSION23            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1066_PREVSESSION24            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1066_PREVSESSION24            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1067_PREVSESSION25            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1067_PREVSESSION25            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1068_PREVSESSION26            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1068_PREVSESSION26            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1069_PREVSESSION27            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1069_PREVSESSION27            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1070_PREVSESSION28            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1070_PREVSESSION28            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1071_PREVSESSION29            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1071_PREVSESSION29            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1072_PREVSESSION30            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1072_PREVSESSION30            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1073_PREVSESSION31            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1073_PREVSESSION31            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1074_PREVSESSION32            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1074_PREVSESSION32            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1075_PREVSESSION33            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1075_PREVSESSION33            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1076_PREVSESSION34            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1076_PREVSESSION34            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1077_PREVSESSION35            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1077_PREVSESSION35            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1078_PREVSESSION36            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1078_PREVSESSION36            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1079_PREVSESSION37            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1079_PREVSESSION37            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1080_PREVSESSION38            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1080_PREVSESSION38            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1081_PREVSESSION39            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 
| COL1081_PREVSESSION39            |            |  bb940afb-1423-4999-a234-5a64a5c00831  |  2017-03-01T00:00:00Z      | 2         | 3                 |  2017-03-01T00:00:00Z  |                            | 

	And I load test session data for the feature
| LoaderRef                        | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended    | ReasonForNonAttendance   | LastModifiedDate       | LastModifiedTouchpointId | 
| COL1043_PREVSESSION1             | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1043_PREVSESSION1             | 2         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1044_PREVSESSION2             | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  false             |                          |                        | 90000001                 | 
| COL1044_PREVSESSION2             | 2         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  false             |                          |                        | 90000001                 | 
| COL1045_PREVSESSION3             | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1045_PREVSESSION3             | 2         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1046_PREVSESSION4             | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1046_PREVSESSION4             | 2         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1047_PREVSESSION5             | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1047_PREVSESSION5             | 2         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1048_PREVSESSION6             | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1048_PREVSESSION6             | 2         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1049_PREVSESSION7             | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1049_PREVSESSION7             | 2         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1050_PREVSESSION8             | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1050_PREVSESSION8             | 2         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1051_PREVSESSION9             | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1051_PREVSESSION9             | 2         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1052_PREVSESSION10            | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1052_PREVSESSION10            | 2         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1053_PREVSESSION11            | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1053_PREVSESSION11            | 2         |  2019-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1054_PREVSESSION12            | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1054_PREVSESSION12            | 2         |  2019-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1055_PREVSESSION13            | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1055_PREVSESSION13            | 2         |  2019-04-02T12:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1056_PREVSESSION14            | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1056_PREVSESSION14            | 2         |  2019-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1057_PREVSESSION15            | 1         |  2018-03-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1057_PREVSESSION15            | 2         |  2019-03-01T23:59:59Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1058_PREVSESSION16            | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1058_PREVSESSION16            | 2         |  2019-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1059_PREVSESSION17            | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1059_PREVSESSION17            | 2         |  2019-04-03T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1060_PREVSESSION18            | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1060_PREVSESSION18            | 2         |  2019-04-03T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1061_PREVSESSION19            | 1         |  2018-04-02T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1061_PREVSESSION19            | 2         |  2019-04-03T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1062_PREVSESSION20            | 1         |  2018-04-02T23:59:59Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1062_PREVSESSION20            | 2         |  2019-04-03T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1063_PREVSESSION21            | 1         |  2018-04-02T23:59:59Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1063_PREVSESSION21            | 2         |  2019-04-03T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1064_PREVSESSION22            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1064_PREVSESSION22            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1065_PREVSESSION23            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1065_PREVSESSION23            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1066_PREVSESSION24            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1066_PREVSESSION24            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1067_PREVSESSION25            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1067_PREVSESSION25            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1068_PREVSESSION26            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1068_PREVSESSION26            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1069_PREVSESSION27            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1069_PREVSESSION27            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1070_PREVSESSION28            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1070_PREVSESSION28            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1071_PREVSESSION29            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1071_PREVSESSION29            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1072_PREVSESSION30            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1072_PREVSESSION30            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1073_PREVSESSION31            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1073_PREVSESSION31            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1074_PREVSESSION32            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1074_PREVSESSION32            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1075_PREVSESSION33            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1075_PREVSESSION33            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1076_PREVSESSION34            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1076_PREVSESSION34            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1077_PREVSESSION35            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1077_PREVSESSION35            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1078_PREVSESSION36            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1078_PREVSESSION36            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1079_PREVSESSION37            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1079_PREVSESSION37            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1080_PREVSESSION38            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1080_PREVSESSION38            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1081_PREVSESSION39            | 1         |  2017-05-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 
| COL1081_PREVSESSION39            | 2         |  2018-04-01T00:00:00Z  |  NE9 7RG               |  true              |                          |                        | 90000001                 | 

And I load action plan data for the feature
| LoaderRef                        | ParentRef | DateActionPlanCreated  | CustomerCharterShownToCustomer   | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation    | 
| COL1043_PREVSESSION1             | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        | 1                        |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1043_PREVSESSION1             | 2         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1044_PREVSESSION2             | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        | 1                        |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1044_PREVSESSION2             | 2         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1045_PREVSESSION3             | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        | 1                        |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1045_PREVSESSION3             | 2         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1046_PREVSESSION4             | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        | 1                        |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1046_PREVSESSION4             | 2         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1047_PREVSESSION5             | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        | 1                        |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1047_PREVSESSION5             | 2         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1048_PREVSESSION6             | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        | 1                        |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1048_PREVSESSION6             | 2         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1049_PREVSESSION7             | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        | 1                        |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1049_PREVSESSION7             | 2         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1050_PREVSESSION8             | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        | 1                        |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1050_PREVSESSION8             | 2         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1051_PREVSESSION9             | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        | 1                        |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1051_PREVSESSION9             | 2         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1052_PREVSESSION10            | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        | 1                        |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1052_PREVSESSION10            | 2         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1053_PREVSESSION11            | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        | 1                        |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1053_PREVSESSION11            | 2         |  2019-04-01T00:00:00Z  |  true                            |  2019-04-01T00:00:00Z   |  2019-04-01T00:00:00Z        | 1                        |  2019-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1054_PREVSESSION12            | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        |                          |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1054_PREVSESSION12            | 2         |  2019-04-02T00:00:00Z  |  true                            |  2019-04-02T00:00:00Z   |  2019-04-02T00:00:00Z        |                          |  2019-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1055_PREVSESSION13            | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        |                          |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1055_PREVSESSION13            | 2         |  2019-04-02T12:00:00Z  |  true                            |  2019-04-02T12:00:00Z   |  2019-04-02T12:00:00Z        |                          |  2019-04-02T12:00:00Z      | 1                |  looking for work26 | 
| COL1056_PREVSESSION14            | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        |                          |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1056_PREVSESSION14            | 2         |  2019-04-02T00:00:00Z  |  true                            |  2019-04-02T00:00:00Z   |  2019-04-02T00:00:00Z        |                          |  2019-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1057_PREVSESSION15            | 1         |  2018-03-01T00:00:00Z  |  true                            |  2018-03-01T00:00:00Z   |  2018-03-01T00:00:00Z        |                          |  2018-03-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1057_PREVSESSION15            | 2         |  2019-03-01T23:59:59Z  |  true                            |  2019-03-01T23:59:59Z   |  2019-03-01T23:59:59Z        |                          |  2019-03-01T23:59:59Z      | 1                |  looking for work26 | 
| COL1058_PREVSESSION16            | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        |                          |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1058_PREVSESSION16            | 2         |  2019-04-02T00:00:00Z  |  true                            |  2019-04-02T00:00:00Z   |  2019-04-02T00:00:00Z        |                          |  2019-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1059_PREVSESSION17            | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        |                          |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1059_PREVSESSION17            | 2         |  2019-04-03T00:00:00Z  |  true                            |  2019-04-03T00:00:00Z   |  2019-04-03T00:00:00Z        |                          |  2019-04-03T00:00:00Z      | 1                |  looking for work26 | 
| COL1060_PREVSESSION18            | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        |                          |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1060_PREVSESSION18            | 2         |  2019-04-03T00:00:00Z  |  true                            |  2019-04-03T00:00:00Z   |  2019-04-03T00:00:00Z        |                          |  2019-04-03T00:00:00Z      | 1                |  looking for work26 | 
| COL1061_PREVSESSION19            | 1         |  2018-04-02T00:00:00Z  |  true                            |  2018-04-02T00:00:00Z   |  2018-04-02T00:00:00Z        |                          |  2018-04-02T00:00:00Z      | 1                |  looking for work26 | 
| COL1061_PREVSESSION19            | 2         |  2019-04-03T00:00:00Z  |  true                            |  2019-04-03T00:00:00Z   |  2019-04-03T00:00:00Z        |                          |  2019-04-03T00:00:00Z      | 1                |  looking for work26 | 
| COL1062_PREVSESSION20            | 1         |  2018-04-02T23:59:59Z  |  true                            |  2018-04-02T23:59:59Z   |  2018-04-02T23:59:59Z        |                          |  2018-04-02T23:59:59Z      | 1                |  looking for work26 | 
| COL1062_PREVSESSION20            | 2         |  2019-04-03T00:00:00Z  |  true                            |  2019-04-03T00:00:00Z   |  2019-04-03T00:00:00Z        |                          |  2019-04-03T00:00:00Z      | 1                |  looking for work26 | 
| COL1063_PREVSESSION21            | 1         |  2018-04-02T23:59:59Z  |  true                            |  2018-04-02T23:59:59Z   |  2018-04-02T23:59:59Z        |                          |  2018-04-02T23:59:59Z      | 1                |  looking for work26 | 
| COL1063_PREVSESSION21            | 2         |  2019-04-03T00:00:00Z  |  true                            |  2019-04-03T00:00:00Z   |  2019-04-03T00:00:00Z        |                          |  2019-04-03T00:00:00Z      | 1                |  looking for work26 | 
| COL1064_PREVSESSION22            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1064_PREVSESSION22            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1065_PREVSESSION23            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1065_PREVSESSION23            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1066_PREVSESSION24            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1066_PREVSESSION24            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1067_PREVSESSION25            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1067_PREVSESSION25            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1068_PREVSESSION26            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1068_PREVSESSION26            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1069_PREVSESSION27            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1069_PREVSESSION27            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1070_PREVSESSION28            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1070_PREVSESSION28            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1071_PREVSESSION29            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1071_PREVSESSION29            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1072_PREVSESSION30            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1072_PREVSESSION30            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1073_PREVSESSION31            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1073_PREVSESSION31            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1074_PREVSESSION32            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1074_PREVSESSION32            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1075_PREVSESSION33            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1075_PREVSESSION33            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1076_PREVSESSION34            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1076_PREVSESSION34            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1077_PREVSESSION35            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1077_PREVSESSION35            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1078_PREVSESSION36            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1078_PREVSESSION36            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1079_PREVSESSION37            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1079_PREVSESSION37            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1080_PREVSESSION38            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1080_PREVSESSION38            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1081_PREVSESSION39            | 1         |  2017-05-01T00:00:00Z  |  true                            |  2017-05-01T00:00:00Z   |  2017-05-01T00:00:00Z        |                          |  2017-05-01T00:00:00Z      | 1                |  looking for work26 | 
| COL1081_PREVSESSION39            | 2         |  2018-04-01T00:00:00Z  |  true                            |  2018-04-01T00:00:00Z   |  2018-04-01T00:00:00Z        |                          |  2018-04-01T00:00:00Z      | 1                |  looking for work26 | 

And I load outcome data for the feature
| LoaderRef                        | ParentRef | OutcomeType | TouchPoint | ClaimedPriorityGroup | OutcomeClaimedDate     | OutcomeEffectiveDate   | 
| COL1043_PREVSESSION1             | 1         | 1           |            | 3                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1043_PREVSESSION1             | 2         | 1           |            | 3                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| COL1043_PREVSESSION1             | 2         | 2           |            | 3                    |  2019-05-04T00:00:00Z  |  2019-05-04T00:00:00Z  | 
| COL1043_PREVSESSION1             | 2         | 3           |            | 3                    |  2019-06-04T00:00:00Z  |  2019-06-04T00:00:00Z  | 
| COL1044_PREVSESSION2             | 1         | 2           |            | 1                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1044_PREVSESSION2             | 2         | 2           |            | 2                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| COL1044_PREVSESSION2             | 2         | 3           |            | 1                    |  2019-05-04T00:00:00Z  |  2019-05-04T00:00:00Z  | 
| COL1044_PREVSESSION2             | 2         | 4           |            | 2                    |  2019-06-04T00:00:00Z  |  2019-06-04T00:00:00Z  | 
| COL1045_PREVSESSION3             | 1         | 3           |            | 2                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1045_PREVSESSION3             | 2         | 3           |            | 2                    |  2019-05-04T00:00:00Z  |  2019-05-04T00:00:00Z  | 
| COL1045_PREVSESSION3             | 2         | 1           |            | 2                    |  2019-06-04T00:00:00Z  |  2019-06-04T00:00:00Z  | 
| COL1046_PREVSESSION4             | 1         | 3           |            | 99                   |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1046_PREVSESSION4             | 2         | 4           |            | 2                    |  2019-05-04T00:00:00Z  |  2019-05-04T00:00:00Z  | 
| COL1047_PREVSESSION5             | 1         | 3           |            | 2                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1047_PREVSESSION5             | 2         | 5           |            | 99                   |  2019-05-04T00:00:00Z  |  2019-05-04T00:00:00Z  | 
| COL1048_PREVSESSION6             | 1         | 4           |            | 99                   |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1048_PREVSESSION6             | 2         | 3           |            | 1                    |  2019-05-04T00:00:00Z  |  2019-05-04T00:00:00Z  | 
| COL1049_PREVSESSION7             | 1         | 4           |            | 1                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1049_PREVSESSION7             | 2         | 4           |            | 2                    |  2019-05-04T00:00:00Z  |  2019-05-04T00:00:00Z  | 
| COL1050_PREVSESSION8             | 1         | 4           |            | 2                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1050_PREVSESSION8             | 2         | 5           |            | 99                   |  2019-05-04T00:00:00Z  |  2019-05-04T00:00:00Z  | 
| COL1051_PREVSESSION9             | 1         | 5           |            | 99                   |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1051_PREVSESSION9             | 2         | 3           |            | 1                    |  2019-05-04T00:00:00Z  |  2019-05-04T00:00:00Z  | 
| COL1052_PREVSESSION10            | 1         | 5           |            | 1                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1052_PREVSESSION10            | 2         | 4           |            | 1                    |  2019-05-04T00:00:00Z  |  2019-05-04T00:00:00Z  | 
| COL1053_PREVSESSION11            | 1         | 5           |            | 1                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1053_PREVSESSION11            | 2         | 5           |            | 2                    |  2019-05-04T00:00:00Z  |  2019-05-04T00:00:00Z  | 
| COL1054_PREVSESSION12            | 1         | 1           |            | 2                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1054_PREVSESSION12            | 2         | 1           |            | 99                   |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| COL1055_PREVSESSION13            | 1         | 2           |            | 99                   |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1055_PREVSESSION13            | 2         | 2           |            | 1                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| COL1056_PREVSESSION14            | 1         | 3           |            | 1                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1056_PREVSESSION14            | 2         | 3           |            | 2                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| COL1057_PREVSESSION15            | 1         | 4           |            | 2                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1057_PREVSESSION15            | 2         | 4           |            | 2                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| COL1058_PREVSESSION16            | 1         | 5           |            | 2                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1058_PREVSESSION16            | 2         | 5           |            | 4                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| COL1059_PREVSESSION17            | 1         | 1           |            | 4                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1059_PREVSESSION17            | 2         | 2           |            | 1                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| COL1060_PREVSESSION18            | 1         | 2           |            | 2                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1060_PREVSESSION18            | 1         | 3           |            | 3                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| COL1061_PREVSESSION19            | 1         | 3           |            | 4                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1061_PREVSESSION19            | 2         | 2           |            | 5                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| COL1062_PREVSESSION20            | 1         | 3           |            | 6                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1062_PREVSESSION20            | 2         | 1           |            | 99                   |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| COL1063_PREVSESSION21            | 1         | 2           |            | 1                    |  2018-04-04T00:00:00Z  |  2018-04-04T00:00:00Z  | 
| COL1063_PREVSESSION21            | 2         | 4           |            | 2                    |  2019-04-04T00:00:00Z  |  2019-04-04T00:00:00Z  | 
| COL1064_PREVSESSION22            | 1         | 1           |            | 3                    |  2018-05-01T00:00:00Z  |  2018-05-01T00:00:00Z  | 
| COL1064_PREVSESSION22            | 2         | 1           |            | 4                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| COL1065_PREVSESSION23            | 1         | 2           |            | 5                    |  2018-05-01T00:00:00Z  |  2018-05-01T00:00:00Z  | 
| COL1065_PREVSESSION23            | 2         | 2           |            | 6                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| COL1066_PREVSESSION24            | 1         | 3           |            | 99                   |  2018-05-01T00:00:00Z  |  2018-05-01T00:00:00Z  | 
| COL1066_PREVSESSION24            | 2         | 3           |            | 1                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| COL1067_PREVSESSION25            | 1         | 4           |            | 2                    |  2018-05-01T00:00:00Z  |  2018-05-01T00:00:00Z  | 
| COL1067_PREVSESSION25            | 2         | 4           |            | 3                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| COL1068_PREVSESSION26            | 1         | 5           |            | 4                    |  2018-05-01T00:00:00Z  |  2018-05-01T00:00:00Z  | 
| COL1068_PREVSESSION26            | 2         | 5           |            | 5                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| COL1069_PREVSESSION27            | 1         | 1           |            | 6                    |  2018-05-01T00:00:00Z  |  2018-05-01T00:00:00Z  | 
| COL1069_PREVSESSION27            | 2         | 1           |            | 99                   |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| COL1070_PREVSESSION28            | 1         | 2           |            | 1                    |  2018-05-01T00:00:00Z  |  2018-05-01T00:00:00Z  | 
| COL1070_PREVSESSION28            | 2         | 2           |            | 2                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| COL1071_PREVSESSION29            | 1         | 3           |            | 3                    |  2018-06-01T00:00:00Z  |  2018-06-01T00:00:00Z  | 
| COL1071_PREVSESSION29            | 2         | 3           |            | 4                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| COL1072_PREVSESSION30            | 1         | 4           |            | 5                    |  2018-05-01T00:00:00Z  |  2018-05-01T00:00:00Z  | 
| COL1072_PREVSESSION30            | 2         | 4           |            | 6                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| COL1073_PREVSESSION31            | 1         | 5           |            | 99                   |  2018-05-01T00:00:00Z  |  2018-05-01T00:00:00Z  | 
| COL1073_PREVSESSION31            | 2         | 5           |            | 1                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| COL1074_PREVSESSION32            | 1         | 5           |            | 2                    |                        |                        | 
| COL1074_PREVSESSION32            | 2         | 1           |            | 3                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| COL1075_PREVSESSION33            | 1         | 2           | 0000000999 | 4                    |  2018-05-01T00:00:00Z  |  2018-05-01T00:00:00Z  | 
| COL1075_PREVSESSION33            | 2         | 3           |            | 5                    |  2019-04-01T00:00:00Z  |  2019-04-01T00:00:00Z  | 
| COL1076_PREVSESSION34            | 1         | 1           |            | 6                    |                        |                        | 
| COL1076_PREVSESSION34            | 2         | 2           |            | 99                   |                        |                        | 
| COL1077_PREVSESSION35            | 1         | 4           |            | 1                    |                        |                        | 
| COL1077_PREVSESSION35            | 2         | 1           |            | 2                    |                        |                        | 
| COL1078_PREVSESSION36            | 1         | 2           |            | 3                    |                        |                        | 
| COL1078_PREVSESSION36            | 2         | 5           |            | 4                    |                        |                        | 
| COL1079_PREVSESSION37            | 1         | 1           |            | 5                    |                        |                        | 
| COL1079_PREVSESSION37            | 2         | 2           |            | 6                    |                        |                        | 
| COL1080_PREVSESSION38            | 1         | 3           |            | 99                   |                        |                        | 
| COL1080_PREVSESSION38            | 2         | 1           |            | 1                    |                        |                        | 
| COL1081_PREVSESSION39            | 1         | 2           |            | 2                    |                        |                        | 
| COL1081_PREVSESSION39            | 2         | 4           |            | 3                    |                        |                        | 

And I update the following sessions
| LoaderRef                        | SessionRef | DateandTimeOfSession   | 
| COL1069_PREVSESSION27            | 1          | 2017-04-30T00:00:00Z   | 
| COL1070_PREVSESSION28            | 1          | 2017-04-30T23:59:59Z   | 
| COL1071_PREVSESSION29            | 1          | 2017-04-30T00:00:00Z   | 
| COL1072_PREVSESSION30            | 1          | 2017-04-30T23:59:59Z   | 
| COL1073_PREVSESSION31            | 1          | 2017-04-30T00:00:00Z   | 



And I have made any data fudging updates required
And I have confirmed all test data is now in the backup data store
And the report period start date is "2019-04-01"
And the report period end date is "2020-03-31"
And a request has been made and the report data is available
And I have completed loading data and don't want to repeat for each test


Scenario:  Previous Session less that 12 months earlier than the current session
	When I check the report data
	Then Outcome 1 for test customer "COL1043_PREVSESSION1" is not included in the report
	Then Outcome 2 for test customer "COL1043_PREVSESSION1" is not included in the report
	Then Outcome 3 for test customer "COL1043_PREVSESSION1" is included in the report
	Then Outcome 4 for test customer "COL1043_PREVSESSION1" is included in the report
	Then Outcome 1 for test customer "COL1044_PREVSESSION2" is not included in the report
	Then Outcome 2 for test customer "COL1044_PREVSESSION2" is not included in the report
	Then Outcome 3 for test customer "COL1044_PREVSESSION2" is included in the report
	Then Outcome 4 for test customer "COL1044_PREVSESSION2" is not included in the report
	Then Outcome 1 for test customer "COL1045_PREVSESSION3" is not included in the report
	Then Outcome 2 for test customer "COL1045_PREVSESSION3" is not included in the report
	Then Outcome 3 for test customer "COL1045_PREVSESSION3" is included in the report
	Then Outcome 1 for test customer "COL1046_PREVSESSION4" is not included in the report
	Then Outcome 2 for test customer "COL1046_PREVSESSION4" is not included in the report
	Then Outcome 1 for test customer "COL1047_PREVSESSION5" is not included in the report
	Then Outcome 2 for test customer "COL1047_PREVSESSION5" is not included in the report
	Then Outcome 1 for test customer "COL1048_PREVSESSION6" is not included in the report
	Then Outcome 2 for test customer "COL1048_PREVSESSION6" is not included in the report
	Then Outcome 1 for test customer "COL1049_PREVSESSION7" is not included in the report
	Then Outcome 2 for test customer "COL1049_PREVSESSION7" is not included in the report
	Then Outcome 1 for test customer "COL1050_PREVSESSION8" is not included in the report
	Then Outcome 2 for test customer "COL1050_PREVSESSION8" is not included in the report
	Then Outcome 1 for test customer "COL1051_PREVSESSION9" is not included in the report
	Then Outcome 2 for test customer "COL1051_PREVSESSION9" is not included in the report
	Then Outcome 1 for test customer "COL1052_PREVSESSION10" is not included in the report
	Then Outcome 2 for test customer "COL1052_PREVSESSION10" is not included in the report
	Then Outcome 1 for test customer "COL1053_PREVSESSION11" is not included in the report
	Then Outcome 2 for test customer "COL1053_PREVSESSION11" is not included in the report

Scenario: Previous Session exactly 12 months earlier than the current session
	When I check the report data
	Then Outcome 1 for test customer "COL1054_PREVSESSION12" is not included in the report
	Then Outcome 2 for test customer "COL1054_PREVSESSION12" is not included in the report
	Then Outcome 1 for test customer "COL1055_PREVSESSION13" is not included in the report
	Then Outcome 2 for test customer "COL1055_PREVSESSION13" is not included in the report
	Then Outcome 1 for test customer "COL1056_PREVSESSION14" is not included in the report
	Then Outcome 2 for test customer "COL1056_PREVSESSION14" is not included in the report
	Then Outcome 1 for test customer "COL1057_PREVSESSION15" is not included in the report
	Then Outcome 2 for test customer "COL1057_PREVSESSION15" is not included in the report
	Then Outcome 1 for test customer "COL1058_PREVSESSION16" is not included in the report
	Then Outcome 2 for test customer "COL1058_PREVSESSION16" is not included in the report

Scenario: Previous Session is less than 12 months earlier that the current session and the associated outcomes were submitted within 12/13 months of that session
	When I check the report data
	Then Outcome 1 for test customer "COL1059_PREVSESSION17" is not included in the report
	Then Outcome 2 for test customer "COL1059_PREVSESSION17" is included in the report
	Then Outcome 1 for test customer "COL1060_PREVSESSION18" is not included in the report
	Then Outcome 2 for test customer "COL1060_PREVSESSION18" is included in the report
	Then Outcome 1 for test customer "COL1061_PREVSESSION19" is not included in the report
	Then Outcome 2 for test customer "COL1061_PREVSESSION19" is included in the report
	Then Outcome 1 for test customer "COL1062_PREVSESSION20" is not included in the report
	Then Outcome 2 for test customer "COL1062_PREVSESSION20" is included in the report
	Then Outcome 1 for test customer "COL1063_PREVSESSION21" is not included in the report
	Then Outcome 2 for test customer "COL1063_PREVSESSION21" is included in the report

Scenario: Previous Session is less than 12 months earlier that the current session and the associated outcomes were submitted 12/13 months later than that session
	Then Outcome 1 for test customer "COL1064_PREVSESSION22" is not included in the report
	Then Outcome 2 for test customer "COL1064_PREVSESSION22" is not included in the report
	Then Outcome 1 for test customer "COL1065_PREVSESSION23" is not included in the report
	Then Outcome 2 for test customer "COL1065_PREVSESSION23" is not included in the report
	Then Outcome 1 for test customer "COL1066_PREVSESSION24" is not included in the report
	Then Outcome 2 for test customer "COL1066_PREVSESSION24" is not included in the report
	Then Outcome 1 for test customer "COL1067_PREVSESSION25" is not included in the report
	Then Outcome 2 for test customer "COL1067_PREVSESSION25" is not included in the report
	Then Outcome 1 for test customer "COL1068_PREVSESSION26" is not included in the report
	Then Outcome 2 for test customer "COL1068_PREVSESSION26" is not included in the report

Scenario: Previous Session is less than 12 months earlier that the current session and the associated outcomes were submitted more than 12/13 months later than that session
	When I check the report data
	Then Outcome 1 for test customer "COL1069_PREVSESSION27" is not included in the report
	Then Outcome 2 for test customer "COL1069_PREVSESSION27" is included in the report
	Then Outcome 1 for test customer "COL1070_PREVSESSION28" is not included in the report
	Then Outcome 2 for test customer "COL1070_PREVSESSION28" is included in the report
	Then Outcome 1 for test customer "COL1071_PREVSESSION29" is not included in the report
	Then Outcome 2 for test customer "COL1071_PREVSESSION29" is included in the report
	Then Outcome 1 for test customer "COL1072_PREVSESSION30" is not included in the report
	Then Outcome 2 for test customer "COL1072_PREVSESSION30" is included in the report
	Then Outcome 1 for test customer "COL1073_PREVSESSION31" is not included in the report
	Then Outcome 2 for test customer "COL1073_PREVSESSION31" is included in the report

Scenario: Previous Session is less than 12 months earlier that the current session and the associated outcomes were submitted by the helpline
	When I check the report data
	Then Outcome 1 for test customer "COL1074_PREVSESSION32" is not included in the report
	Then Outcome 2 for test customer "COL1074_PREVSESSION32" is included in the report
	Then Outcome 1 for test customer "COL1075_PREVSESSION33" is not included in the report
	Then Outcome 2 for test customer "COL1075_PREVSESSION33" is included in the report

