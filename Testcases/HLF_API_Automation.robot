*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

Resource    ../Keywords/loginuser_keywords.robot
Resource    ../Keywords/GetCustemer.robot
Resource    ../Keywords/UpdateCustemerDetails_keywords.robot
Resource    ../Keywords/GetUserAddress.robot
Resource    ../Keywords/UpdateBiometricKeywords.robot
Resource    ../Keywords/deviceLoginKeywords.robot



*** Test Cases ***
TC_1. LogIn user into HLF app
        LoginUser_Set_Global_Variable

#TC_2. GetUserDetails
#        Get_custemor_GETAPI
#
#TC_3. Updates User Delivery Address
#        UpdateUserAddress
#
#TC_4. Get User Updated Address
#        Get User Address

TC_5. Update User Device Biometric
        Generate User Device Token Id

TC_6. Login to app using device biometrics
        Login with Biometrics Quick option
