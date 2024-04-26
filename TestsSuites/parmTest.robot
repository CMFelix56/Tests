*** Settings ***
Documentation    Exemple Squash TF
Library    squash_tf.TFParamService
#Library    conditionalHang.py    42

*** Test Cases ***
Parameter Test
    [Documentation]     Test robo
    ${paramValue}=    Get Param    TC_REFERENCE
    Log To Console    message: ${paramValue}