*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     String
Documentation  Adds products to cart and checks that price before shipping matches tallied subtotal.
Suite Setup     Open Browser   ${URL}     headlessfirefox
Suite Teardown      Close Browser
*** Variables ***

${URL}      https://vm1376.kaj.pouta.csc.fi/index.php?id_category=2&controller=category     #URL should be the "All products" page on the site
@{SUBTOTALS}
${sum}

*** Test Cases ***

Purchase test
        Select product to basket  xpath=//img[@alt='Hummingbird printed t-shirt']
        Select product to basket  xpath=//img[@alt='Mug The best is yet to come']
        Select product to basket  xpath=//img[@alt='Mountain fox notebook']
        Tally in total

*** Keywords ***

Select product to basket
    [Arguments]  ${image_alt_text}
    VAR     ${subtotal}
    Set Suite Variable      ${subtotal}     ${EMPTY}
    Click Element       ${image_alt_text}

    ${subtotal} =   Get Property    css=.current-price-value       innerHTML
    ${subtotal} =   Remove String   ${subtotal}     $
    ${subtotal} =   Convert To Number   ${subtotal}
    Click Element       css=.add-to-cart
    Wait Until Element is Visible       css=.subtotal
    Click Element       css=.cart-content-btn > .btn-secondary
    Append To List      ${SUBTOTALS}     ${subtotal}
    Go To       ${URL}
    Log     ${subtotal}
    Log     ${SUBTOTALS}

Tally in total

    VAR     ${checkout_pre_shipping}
    Click Element       css=.header .hidden-sm-down
    FOR     ${price}    IN      @{SUBTOTALS}
        ${sum}      Evaluate    float(${sum}) + ${price}
    END
    Log     ${sum}
    ${checkout_pre_shipping} =      Get Property    xpath=//div[@id='cart-subtotal-products']/span[2]       innerHTML
    ${checkout_pre_shipping} =   Remove String   ${checkout_pre_shipping}     $
    ${checkout_pre_shipping} =   Convert To Number   ${checkout_pre_shipping}
    Should Be True      '${sum}' == '${checkout_pre_shipping}'



