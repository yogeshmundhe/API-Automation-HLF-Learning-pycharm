*** Settings ***
Library    RequestsLibrary
Library    Collection
Library    JSONLibrary
Resource    ../Keywords/loginuser_keywords.robot

*** Keywords ***
UpdateUserAddress
        create session    Userupdates   ${BaseURL}
        ${body}=    create dictionary       deliveryAddress1=Perennial Systems Swargate    deliveryAddress2=Kalewadi-pune    deliveryCity=Pune     deliveryZipCode=4104104    deliveryCountry=IN
        ${headers}=     create dictionary    Authorization=Bearer ${BearerToken}      Content-Type=application/json
        ${Response}=    PUT On Session    Userupdates   /api/v1/user/${useriD}      json=${body}    headers=${headers}
        log to console    ${Response.status_code}


#        Validations
        ${response_content}     convert to string    ${Response.content}
        ${status-code}      convert to string       ${Response.status_code}
        ${success_msg}      convert to boolean       true
#        ${resp_obj}     to json    ${Response.content}
        should be equal    ${status-code}       200
        status should be    Ok      ${Response}

        should be equal    ${Response.json()}[success]      ${success_msg}

