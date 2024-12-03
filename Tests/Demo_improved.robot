*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${BASE_URL}     https://travel.agileway.net/login     #testattava sivu
&{user1}    username=testuser    password=testpassword  #dictionary muuttuja
&{user2}    username=agileway    password=testwise

*** Keywords ***
            #itse tehty avainsana, toimii makrona
Attempt Login
    [Arguments]  ${username}  ${password}
    Open Browser    ${BASE_URL}    edge

    Input Text    name=username    ${username}
    Input Password    name=password   ${password}
    Click Element  name=commit
    Element Should Contain    id=flash_notice    Signed in!

    Close Browser

*** Test Cases ***
Test1   #testi väärällä tunnuksella
    Attempt Login  ${user1}[username]  ${user1}[password]

Test2   #testi oikealla tunnuksella
    Attempt Login  ${user2}[username]  ${user2}[password]

