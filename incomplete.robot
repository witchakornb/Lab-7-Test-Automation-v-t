*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${SERVER}         localhost:7272
${BROWSER}        Chrome
${REGISTER URL}    http://${SERVER}/Form.html
${SUCCESS URL}    http://${SERVER}/Complete.html
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}chrome-mac-x64${/}Google Chrome for Testing.app${/}Contents${/}MacOS${/}Google Chrome for Testing
${CHROME_DRIVER_PATH}    ${EXECDIR}${/}chromedriver-mac-x64${/}chromedriver
${VALID FIRSTNAME}    Somsong
${VALID LASTNAME}    Sandee
${VALID DESTINATION}    Europe
${VALID CONTACT_PERSON}    Sodsai Sandee
${VALID RELATIONSHIP}    Mother
${VALID EMAIL}    somsong@kkumail.com
${INVALID EMAIL}    somsong@
${VALID PHONENUMBER}    081-001-1234
${INVALID PHONENUMBER}    191
${DESTINATION ERROR MESSAGE}    Please enter your destination.
${EMAIL ERROR MESSAGE}    Please enter a valid email address.
${EMPTY PHONENUMBER ERROR MESSAGE}    Please enter a phone number.
${INVALID PHONENUMBER ERROR MESSAGE}    Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678)

*** Test Cases ***
Open Form
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${chrome_options.binary_location}     Set Variable       ${CHROME_BROWSER_PATH}
    ${service}   Evaluate   sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")
    # [selenium >= 4.10] `chrome_options` change to `options`
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
	Open Browser    ${REGISTER URL}    ${BROWSER}
	Location Should Be    ${REGISTER URL}

Empty Destination
    Input Text    firstname    ${EMPTY}
	Input Text    lastname    ${VALID LASTNAME}
	Input Text    destination    ${EMPTY}
	Input Text    contactperson    ${VALID CONTACT_PERSON}
	Input Text    relationship    ${VALID RELATIONSHIP}
    Input Text    email    ${VALID EMAIL}
	Input Text    phone    ${VALID PHONENUMBER}
    Click Button    submitButton
    Location Should Contain    ${REGISTER URL}
    Wait Until Page Contains    ${DESTINATION ERROR MESSAGE}

Empty Email
    Go To    ${REGISTER URL}
    Location Should Be    ${REGISTER URL}
    Input Text    firstname    ${VALID FIRSTNAME}
	Input Text    lastname    ${VALID LASTNAME}
	Input Text    destination    ${VALID DESTINATION}
	Input Text    contactperson    ${VALID CONTACT_PERSON}
	Input Text    relationship    ${VALID RELATIONSHIP}
    Input Text    email    ${EMPTY}
	Input Text    phone    ${VALID PHONENUMBER}
    Click Button    submitButton
    Location Should Contain    ${REGISTER URL}
    Wait Until Page Contains    ${EMAIL ERROR MESSAGE}

Invalid Email
    Go To    ${REGISTER URL}
    Location Should Be    ${REGISTER URL}
    Input Text    firstname    ${VALID FIRSTNAME}
	Input Text    lastname    ${VALID LASTNAME}
	Input Text    destination    ${VALID DESTINATION}
	Input Text    contactperson    ${VALID CONTACT_PERSON}
	Input Text    relationship    ${VALID RELATIONSHIP}
    Input Text    email    ${INVALID EMAIL}
	Input Text    phone    ${VALID PHONENUMBER}
    Click Button    submitButton
    Location Should Contain    ${REGISTER URL}
    Wait Until Page Contains    ${EMAIL ERROR MESSAGE}

Empty Phone Number
    Go To    ${REGISTER URL}
    Location Should Be    ${REGISTER URL}
    Input Text    firstname    ${VALID FIRSTNAME}
	Input Text    lastname    ${VALID LASTNAME}
	Input Text    destination    ${VALID DESTINATION}
	Input Text    contactperson    ${VALID CONTACT_PERSON}
	Input Text    relationship    ${VALID RELATIONSHIP}
    Input Text    email    ${VALID EMAIL}
	Input Text    phone    ${EMPTY}
    Click Button    submitButton
    Location Should Contain    ${REGISTER URL}
    Wait Until Page Contains    ${EMPTY PHONENUMBER ERROR MESSAGE}

Invalid Phone Number
    Go To    ${REGISTER URL}
    Location Should Be    ${REGISTER URL}
    Input Text    firstname    ${VALID FIRSTNAME}
	Input Text    lastname    ${VALID LASTNAME}
	Input Text    destination    ${VALID DESTINATION}
	Input Text    contactperson    ${VALID CONTACT_PERSON}
	Input Text    relationship    ${VALID RELATIONSHIP}
    Input Text    email    ${VALID EMAIL}
	Input Text    phone    ${INVALID PHONENUMBER}
    Click Button    submitButton
    Location Should Contain    ${REGISTER URL}
    Wait Until Page Contains    ${INVALID PHONENUMBER ERROR MESSAGE}

	[Teardown]    Close Browser
