*** Settings ***
Library    SeleniumLibrary
Suite Setup     Open Browser   ${url}     headlessfirefox
Suite Teardown      Close Browser
*** Variables ***

${url}    https://vm1376.kaj.pouta.csc.fi/index.php
${default_colour}   white

*** Test Cases ***

Colour check
    Check background colour

*** Keywords ***

Check background colour

    ${bg_colour} =   Get Property    css=.header-top   background-colour
    Log     ${bg_colour}
    Should Be True      '${bg_colour}' == '${default_colour}'

