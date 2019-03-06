@Collections
Feature: Post
	The ABCs will request a year to day report via a POST to an Rest API service
Background:

Given I load test customer data for this feature:
	#Parent for ADDRESS in CUSTOMER
| LoaderRef                   | TouchPoint | Title | GivenName          | FamilyName       | DateofBirth       | DateOfRegistration   | UniqueLearnerNumber | OptInUserResearch   | OptInMarketResearch   | DateOfTermination   | ReasonForTermination   | IntroducedBy | IntroducedByAdditionalInfo   | LastModifiedDate       | 
| OUTCOMES1                   | 9000000001 | 4     | outcomeone         | outcomeone       |  Today -21Y       |  Now -3D             | 9999900002          |  true               |  false                |                     |                        | 1            |  ZZ_TESTDATA_ANON            |  2019-01-17T00:00:00Z  | 

 And I load test interaction data for this feature
#	#Parent for INTERACTION is CUSTOMER
| LoaderRef                   |  TouchpointId  |  AdviserDetailsId                      |  DateandTimeOfInteraction  |  Channel  |  InteractionType  |  LastModifiedDate      |  LastModifiedTouchpointId  | 
| OUTCOMES1                   | 4              |  bb940afb-1423-4999-a234-5a64a5c00831  |  Today -180D               | 2         | 3                 |  2019-01-23T00:00:00Z  | 90000001                   | 

	And I load test session data for the feature
| LoaderRef                  | ParentRef | DateandTimeOfSession   | VenuePostCode          | SessionAttended          | ReasonForNonAttendance   | LastModifiedDate           | LastModifiedTouchpointId | 
| OUTCOMES1                  | 1         |  Today -400D           |  NE9 7RG               |  true                    |                          |  2019-01-23T00:00:00Z      | 90000001                 | 
| OUTCOMES1                  | 1         |  Today -300D           |  NE9 7RG               |  true                    |                          |  2019-01-23T00:00:00Z      | 90000001                 | 

And I load action plan data for the feature
| LoaderRef | ParentRef | DateActionPlanCreated | CustomerCharterShownToCustomer | DateAndTimeCharterShown | DateActionPlanSentToCustomer | ActionPlanDeliveryMethod | DateActionPlanAcknowledged | PriorityCustomer | CurrentSituation   |
| OUTCOMES1 | 1         | Today -400D           | true                           | Today -400D             | Today -400D                  | 1                        | Today -400D                | 1                | looking for work17 | 

And I load outcome data for the feature
| LoaderRef                  | ParentRef | OutcomeType | TouchPointId | ClaimedPriorityGroup | OutcomeClaimedDate   | OutcomeEffectiveDate   | 
| OUTCOMES1                  | 1         | 1           | 9000000090   | 99                   |  Today -300D         |  Today -300D           | 
| OUTCOMES1                  | 1         | 2           | 9000000090   | 99                   |  Today -200D         |  Today -200D           | 
| OUTCOMES1                  | 1         | 3           | 9000000090   | 99                   |  Today -100D         |  Today -100D           | 

#And I update the following sessions
#| LoaderRef | SessionRef | DateandTimeOfSession |
#| OUTCOMES1  | 1          | Today -500D        |
#| OUTCOMES1  | 2          | Today -400D        |

	And I have completed loading data and don't want to repeat for each test
	And I have confirmed all test data is now in the backup data store
Scenario: Multiple Outcomes
		Given the report period start date is "Today -365D"
		And the report period end date is "Today"
		And a request has been made and the report data is available
		Then Outcome 1 for test customer "OUTCOMES1" is included in the report
		

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



