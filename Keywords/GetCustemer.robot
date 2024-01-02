*** Settings ***
Library    RequestsLibrary
Library    Collection
Library    JSONLibrary
Resource    ../Variable_Repository/LoginVariables.robot
Resource    ../Keywords/loginuser_keywords.robot

*** Keywords ***
Get_custemor_GETAPI
           create session    Get_cust_data      ${Base_URL}     verify=True
           ${Header}=  create dictionary    Authorization=Bearer ${BearerToken}      Content-Type=application/json
           ${response}=     get on session     Get_cust_data    /api/v1/user/${useriD}/customer/${Cust_hash_id}     headers=${Header}
#           log to console    ${response.content}
           log to console    ${response.status_code}
#           log to console    ${response.json()}


           #Validation
           ${resp_code}=       convert to string        ${response.status_code}
           ${resp_content}=    convert to string     ${response.json()}

           status should be      OK     ${response}
           should be equal     ${resp_code}    200
           should contain      ${resp_content}      Customer get successfully
           should contain    ${resp_content}    ${UserEmail}
           should be equal    ${response.json()}[data][customerHashId]     ${Cust_hash_id}