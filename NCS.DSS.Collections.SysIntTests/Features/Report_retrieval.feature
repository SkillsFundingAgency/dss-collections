Feature: Report Retrieval

Scenario: TouchPoint is notified that a report is ready and retrieves it
	Given A report has been requested
	# SPECFLOW creates a report row
	#And DC has generated the report
	# SPECFLOW loads a zip file to blob storage
	#And DC has notified DSS that the report is ready
	# SPECFLOW enqueues an item on the response Service Bus queue
	#Then the push subscription service informs the TouchPoint the report is ready
	# SPECFLOW checks the notification collection to confirm the notification was sent
	#And the TouchPoint can retrieve the file
	# SPECFLOW makes a GET request to the collections API with the URI included in the push message


