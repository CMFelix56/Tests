*** Settings ***
Library    RequestsLibrary
Resource   Outils.resource

*** Variables ***

*** Keywords ***
Verify Retour Api
    [Documentation]    Validation du code retour d'une API
    ...    Arguments:
    ...        aUrl          ==> L'URL à contrôler
    ...        aCodeReturn   ==> Le code retour attendu
    [Arguments]    ${aUrl}    ${aCodeReturn}
    [Tags]    Technique

    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    RequestsLibrary.GET   ${aUrl}     expected_status=${aCodeReturn}
    #RequestsLibrary.Status Should Be    ${aCodeReturn}
    TraitementStatusApi    ${status1}    ${aCodeReturn}    ${aUrl}    ${value1}

TraitementStatusApi
    [Documentation]    Gestion des messages selon le traitement et le statut
    ...    Arguments:
    ...        aStatus     ==> Le statut du traitement
    ...        aCodeReturn ==> Le code retour attendu
    ...        aApi        ==> L'Api à tester
    ...        aStackTrace ==> La stack trace erreur
    [Arguments]    ${aStatus}    ${aCodeReturn}    ${aApi}    ${aStackTrace}
    [Tags]    Technique
    
    #RequestsLibrary.Status Should Be    ${aCodeReturn}
    ${Message}    BuiltIn.Set Variable    ${TEST NAME}: L'API '${aApi}' n'a pas Code retour(${aCodeReturn}) mais (${aStackTrace})
    #Log To Console    ${Message}
    IF    '${aStatus}' == 'FAIL'
        Outils.Log Report    ${Message}    ERROR
        BuiltIn.Fail    ${aStackTrace} 
    END

