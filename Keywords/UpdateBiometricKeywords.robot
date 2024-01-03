*** Settings ***
Library    RequestsLibrary
Library    Collection
Library    JSONLibrary
Resource    ../Keywords/loginuser_keywords.robot

*** Variables ***
${Device_id}=   ${EMPTY}
${Device_token_id}=     ${EMPTY}

*** Keywords ***
Generate User Device Token Id
        create session    UpdateBiometric       ${BaseURL}
        ${header}=     create dictionary    Authorization=Bearer ${BearerToken}     Content-Type=application/json
        ${Body}=       create dictionary     device_id=B0B2AD8D-924B-42D7-85ED-4CE7C17B4B3A     action=ENABLE
        ${Response}=    put on session    UpdateBiometric   /api/v1/user/${UserId}/bio-metric    json=${Body}   headers=${header}
        log to console    ${Response.json()}

#        Validation
        status should be    Ok      ${Response}
        should be equal as strings      ${Response.json()}[message]       Biometric access set up successfully

# Setting the global variables
        set global variable    ${Device_id}     ${Response.json()}[data][device_id]
        set global variable    ${Device_token_id}     ${Response.json()}[data][device_token_id]

#        log to console    ${Device_id}
#        log to console    ${Device_token_id}