*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Open Form
    Open Form

Empty Destination
	Input Inquiry Form    ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${EMPTY}    ${VALID CONTACT_PERSON}    ${VALID RELATIONSHIP}    ${VALID EMAIL}    ${VALID PHONENUMBER}
    Location Should Contain    ${REGISTER URL}
    Wait Until Page Contains    ${DESTINATION ERROR MESSAGE}
    Capture Page Screenshot    filename=emptyfirstname.jpg
    [Teardown]    Close Browser

Empty Email
    Open Form
	Input Inquiry Form    ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${VALID DESTINATION}    ${VALID CONTACT_PERSON}    ${VALID RELATIONSHIP}    ${EMPTY}    ${VALID PHONENUMBER}
    Location Should Contain    ${REGISTER URL}
    Wait Until Page Contains    ${EMAIL ERROR MESSAGE}
    Capture Page Screenshot    filename=emptyemail.jpg
    [Teardown]    Close Browser

Invalid Email
    Open Form
	Input Inquiry Form    ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${VALID DESTINATION}    ${VALID CONTACT_PERSON}    ${VALID RELATIONSHIP}    ${INVALID EMAIL}    ${VALID PHONENUMBER}
    Location Should Contain    ${REGISTER URL}
    Wait Until Page Contains    ${EMAIL ERROR MESSAGE}
    Capture Page Screenshot    filename=invalidemail.jpg
    [Teardown]    Close Browser

Empty Phone Number
    Open Form
	Input Inquiry Form    ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${VALID DESTINATION}    ${VALID CONTACT_PERSON}    ${VALID RELATIONSHIP}    ${INVALID EMAIL}    ${EMPTY}
    Location Should Contain    ${REGISTER URL}
    Wait Until Page Contains    ${EMPTY PHONENUMBER ERROR MESSAGE}
    Capture Page Screenshot    filename=emptyphone.jpg
    [Teardown]    Close Browser

Invalid Phone Number
    Open Form
	Input Inquiry Form    ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${VALID DESTINATION}    ${VALID CONTACT_PERSON}    ${VALID RELATIONSHIP}    ${VALID EMAIL}    ${INVALID PHONENUMBER}
    Location Should Contain    ${REGISTER URL}
    Wait Until Page Contains    ${INVALID PHONENUMBER ERROR MESSAGE}
    Capture Page Screenshot    filename=invalidphonenumber.jpg
    [Teardown]    Close Browser
