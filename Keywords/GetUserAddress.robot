*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Resource    ../Keywords/loginuser_keywords.robot

*** Keywords ***
Get User Address
        create session    get user address      ${BaseURL}
        ${headers}=     create dictionary    Content-Type=application/json      Authorization=Bearer ${BearerToken}
        ${Response}=    GET On Session    get user address      /api/v1/user/${useriD}/customer/${cust_hash_id}/address     headers=${headers}
#        log to console     ${Response.status_code}
#        log to console    ${Response.json()}


#  Validations
        ${success_msg}      convert to boolean       true
        status should be    Ok       ${Response}
        should be equal as strings      ${Response.status_code}     200
        should be equal    ${Response.json()}[success]      ${success_msg}
        should be equal as strings      ${Response.json()}[message]         Customer address get successfully
        should contain      ${Response.json()}[data][deliveryAddress]       Perennial Systems Swargate

















