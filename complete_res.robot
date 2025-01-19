*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Open Form
    Open Form

Register Success
	Input Inquiry Form    ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${VALID DESTINATION}    ${VALID CONTACT_PERSON}    ${VALID RELATIONSHIP}    ${VALID EMAIL}    ${VALID PHONENUMBER}
    Wait Until Page Contains    Our agent will contact you shortly.
	Wait Until Page Contains    Thank you for your patient.
	Location Should Contain    ${SUCCESS URL}
    Title Should Be    Completed
    Capture Page Screenshot    filename=successpage.jpg
	[Teardown]    Close Browser
