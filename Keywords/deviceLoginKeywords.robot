
*** Settings ***
Library    RequestsLibrary
Library    Collection
Library    JSONLibrary
Resource    ../Keywords/loginuser_keywords.robot
Resource    ../Keywords/UpdateBiometricKeywords.robot

*** Keywords ***
 Login with Biometrics Quick option
#           [Arguments]     ${Device_id}        ${Device_token_id}
            create session    devicelogin       ${BaseURL}
            ${Body}=    create dictionary    device_id=${Device_id}     device_token_id=${Device_token_id}
            ${Response}=    post on session    devicelogin       /api/v1/user/verify-device     json=${Body}
            log to console    ${Response.json()}

#            Validations
            status should be    Ok      ${Response}
            should be equal      ${Response.json()}[data][id]       ${USERID}
            should be equal      ${Response.json()}[data][email]       ${UserEmail}
            should be equal      ${Response.json()}[data][customer_hash_id]       ${cust_hash_id}
            should be equal     ${Response.json()}[data][device_id]     ${device_id}
#            should contain      ${Response.content}       device_id
            should have value in json     ${Response.json()}        $.data.device_id
            should have value in json        ${Response.json()}       $.data.token

