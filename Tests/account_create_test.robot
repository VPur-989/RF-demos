*** Settings ***
Documentation   Script that creates a user on the prestashop.
Library    SeleniumLibrary

*** Variables ***
${base_url}    https://vm1376.kaj.pouta.csc.fi/index.php
${first_name}     Jimbob
${last_name}    Jones
${email}        pee@mail.com
${password}     peruna666

*** Keywords ***

Navigate to create account page
    Click Element    class=user-info    #click the login, need to figure out what this ought to be
    Click Element    class=no-account    #click the create account page

Fill in account info

    Click Element   id=field-id_gender-1   #mr tag on the radio button
    Input Text  id=field-firstname   ${first_name}    #first name field
    Input Text  id=field-lastname   ${last_name}    #last name field
    Input Text  id=field-email   ${email}    #email field
    Input Text  id=field-password   ${password}    #password field
    Click Element   name=psgdpr     #terms and conditions check
    Click Element   name=customer_privacy     #agree to privacy notice check
    Click Element   xpath://*[contains(text(), "Save")]     #click save

See if the userpage appears

    Page Should Contain     Sign out    #confirms that the sign out appears once account is created


*** Test Cases ***
Create account
    Open Browser    ${base_url}     firefox
    Navigate to create account page
    Fill in account info
    See if the userpage appears
    Sleep   5s
    Close Browser