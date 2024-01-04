*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Resource    ../Variable_Repository/LoginVariables.robot

*** Variables ***
${BearerToken}=     ${EMPTY}
${useriD}       ${EMPTY}
${Cust_hash_id}     ${EMPTY}

*** Keywords ***
LoginUser_Set_Global_Variable
        create session    loginsession      ${BaseURL}
        ${body}     create dictionary       email=${UserEmail}      password=${UserPassword}
        ${Response}     post on session    loginsession     /api/v1/user/login      json=${body}
#        log to console    ${Response.status_code}
#        log to console      ${Response.json()}
        ${json_Obj}=       to json      ${Response.content}




#Validations
        ${StatusCode}=   convert to string    ${Response.status_code}
        ${Respo_Content}=   convert to string    ${Response.content}
        should be equal    ${StatusCode}    200
        should contain     ${Respo_Content}     id
        should contain     ${Respo_Content}     customer_hash_id
        should contain     ${Respo_Content}     email
        should be equal     ${Response.json()}[data][email]     ${UserEmail}
        should be equal     ${Response.json()}[data][role]     CONSUMER



#    Set global Variables for use in another requests

        ${tokenValue}=      get value from json    ${json_Obj}      $.data.token
        ${userIdValue}=     get value from json    ${json_Obj}      $.data.id
        ${user_hashId_Value}=     get value from json    ${json_Obj}      $.data.customer_hash_id


        set global variable       ${BearerToken}        ${tokenValue[0]}
        set global variable    ${useriD}        ${userIdValue[0]}
        set global variable    ${Cust_hash_id}      ${user_hashId_Value[0]}


#        Set variables by another way
#        set global variable       ${BearerToken}        ${Response.json()}[data][token]
#        set global variable    ${useriD}        ${Response.json()}[data][id]
#        set global variable    ${Cust_hash_id}        ${Response.json()}[data][customer_hash_id]
