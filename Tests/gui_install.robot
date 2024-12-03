*** Settings ***
Documentation   Installs the GUI portion of the service.
Library    SeleniumLibrary

*** Variables ***
#edit these to match the ones you used to setup the service.
${base_url}    https://vm1376.kaj.pouta.csc.fi/install/
${db_name}      prestashopdb    #name of the sql table you set up in mariadb
${db_user}      prestashop      #name of the database user
${db_pw}        peruna          #database password, use the one you used in setup phase


*** Keywords ***

Choose your language
    Click Element    id=btNext    #btNext is the element id of the button

Licence Agreements
    Click Element    id=set_license    #setlicence is the checkbox id, unsure if click element works
    Click Element    id=btNext     #clicks the next button

Store Information
    Input Text  id=infosShop    placeHolderName
    Click Element   enable_ssl  #presses the enable ssl radio button
    Input Text  id=infosFirstname   placeHolderFirstName    #first name field
    Input Text  id=infosName    placeHolderlastName    #last name field
    Input Text  id=infosEmail   mail@admin.com    #email address field
    Input Text  id=infosPassword    peruna666    #password field
    Input Text  id=infosPasswordRepeat  peruna666    #retype password field
    Click Element    id=btNext     #clicks the next button

Content of your store
    Click Element    id=btNext     #clicks the next button

System configuration
    input Text  id=dbName   ${db_name}    #database name, use the one you created in mariadb
    Input Text  id=dbLogin    ${db_user}    #database login info, use the credentials you used when you created the table in mariadb
    Input Text  id=dbPassword    ${db_pw}    #use the password for database
    Click Element    id=btNext
    

*** Test Cases ***
Install PrestaShop
    Open Browser    ${base_url}
    Choose your language
    Licence Agreements
    Store information
    Content of your store
    System configuration
    Sleep   120s
    Page Should Contain    Your installation is finished!
    Close Browser
