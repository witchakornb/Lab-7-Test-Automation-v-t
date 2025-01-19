*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${SERVER}         localhost:7272
${BROWSER}        Chrome
${REGISTER URL}    http://${SERVER}/Form.html
${SUCCESS URL}    http://${SERVER}/Complete.html
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}chrome-mac-x64${/}Google Chrome for Testing.app${/}Contents${/}MacOS${/}Google Chrome for Testing
${CHROME_DRIVER_PATH}    ${EXECDIR}${/}chromedriver-mac-x64${/}chromedriver
${DELAY}          0
${VALID FIRSTNAME}    Somsong
${VALID LASTNAME}    Sandee
${VALID DESTINATION}    Europe
${VALID CONTACT_PERSON}    Sodsai Sandee
${VALID RELATIONSHIP}    Mother
${VALID EMAIL}    somsong@kkumail.com
${VALID PHONENUMBER}    081-111-1234

*** Test Cases ***
Open Form
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${chrome_options.binary_location}     Set Variable       ${CHROME_BROWSER_PATH}
    ${service}   Evaluate   sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")
    # [selenium >= 4.10] `chrome_options` change to `options`
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
	Open Browser    ${REGISTER URL}    ${BROWSER}
	Location Should Be    ${REGISTER URL}
	Capture Page Screenshot    filename=openpage.jpg
	Set Selenium Speed    ${DELAY}

Register Success
    Input Text    firstname    ${VALID FIRSTNAME}
	Input Text    lastname    ${VALID LASTNAME}
	Input Text    destination    ${VALID DESTINATION}
	Input Text    contactperson    ${VALID CONTACT_PERSON}
	Input Text    relationship    ${VALID RELATIONSHIP}
    Input Text    email    ${VALID EMAIL}
	Input Text    phone    ${VALID PHONENUMBER}
    Click Button    submitButton
    Wait Until Page Contains    Our agent will contact you shortly.
	Wait Until Page Contains    Thank you for your patient.
	Location Should Contain    ${SUCCESS URL}
    Title Should Be    Completed

	[Teardown]    Close Browser
