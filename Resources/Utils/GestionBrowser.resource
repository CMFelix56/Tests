*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    DateTime
Library    %{PROJECT_FOLDER}/libs/Common.py
Resource   %{PROJECT_FOLDER}/Data-env/Environnement.resource
Resource   Outils.resource
Resource   GestionApi.resource

*** Variables ***

*** Keywords ***
Suite Setup Sans Url
    [Documentation]    Initialisation de la suite de tests
    [Tags]    Technique
    Log To Console    ${EMPTY}
    Log To Console    ================================================================== SUITE SETUP
    Log To Console    CURDIR____________\t${CURDIR}
    Log To Console    EXECDIR___________\t${EXECDIR}
    Log To Console    OUTPUT DIR________\t${OUTPUT DIR}
    Log To Console    BROWSER___________\t${BROWSER}
    Log To Console    LANG___________\t${LANG}
    Log To Console    ${EMPTY}

Suite Setup
    [Documentation]    Initialisation de la suite de tests
    [Tags]    Technique
    Log To Console    ${EMPTY}
    Log To Console    ================================================================== SUITE SETUP
    Log To Console    CURDIR____________\t${CURDIR}
    Log To Console    EXECDIR___________\t${EXECDIR}
    Log To Console    OUTPUT DIR________\t${OUTPUT DIR}
    Log To Console    BROWSER___________\t${BROWSER}
    Log To Console    LANG___________\t${LANG}
    Log To Console    ${EMPTY}

    OpenBrowserManuel    ${URL_IHM}

Test Setup
    [Documentation]    Initialisation du cas de test
    [Tags]    Technique

    Log To Console    ${EMPTY}
    Log To Console    ================================================================== TEST SETUP

Openchrome
    [Documentation]    Ouverture du navigateur Chrome en normal
    [Tags]    Technique
    [Arguments]    ${url}
    Open Browser
    ...    url=${url}
    ...    browser=chrome

OpenchromePrivate
    [Documentation]    Ouverture du navigateur Chrome en private
    [Tags]    Technique
    [Arguments]    ${url}
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    incognito
    ${excludeSwitches}    Create List    enable-logging
    Call Method    ${options}    add_experimental_option    excludeSwitches    ${excludeSwitches}
    Open Browser
    ...    url=${url}
    ...    browser=chrome
    ...    options=${options}

Openfirefox
    [Documentation]    Ouverture du navigateur firefox en normal
    [Tags]    Technique
    Open Browser
    ...    url=${URL_IHM}
    ...    browser=firefox

OpenBrowserManuel
    [Documentation]    Ouverture du navigateur selon l'url choisi
    [Arguments]    ${aUrl}
    [Tags]    Technique
    GestionApi.Verify Retour Api    ${aUrl}    200

    Run Keyword    Open${BROWSER}  ${aUrl}
    Set Browser Implicit Wait    5
    Maximize Browser Window 

#Todo ==> normalisé avec les logs 
VerifierURL  
    [Documentation]    Vérifie que l'url de la page affichée est bien l'url passé en paramètre "url_cible"
    [Arguments]    ${url_cible}
    [Tags]    Technique

    ${location} =    SeleniumLibrary.Get Location
    
    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    BuiltIn.Should Be Equal As Strings    ${location}    ${url_cible}
    Outils.TraitementStatus    ${status1}    égale à (${url_cible})    ${location}    ${value1}

Capture Step ScreenShot
    [Documentation]    Capture avec règle de nommage du fichier
    ...    Le step permet d'identifier l'étape et de faire plusieurs captures par test
    ...    Arguments:
    ...        step ==> Etat du traitement = FAIL
    [Arguments]    ${step}
    ${dt}    DateTime.Get Current Date    result_format=%Y%m%d_%H%M%S%f

    ${filename}    Common.Clean String Filename    ${dt}_${TEST NAME}_${step}
    #Log Console    ${step}    INFO
    IF    '${step}' == 'FAIL'
    #IF    '''${step}''' == 'FAIL'
        SeleniumLibrary.Capture Page Screenshot    ${OUTPUT DIR}${/}${filename}.png
        #${html}    SeleniumLibrary.Get Source
        #OperatingSystem.Create File    path=${OUTPUT DIR}${/}${filename}.html    content=${html}    encoding=UTF-8
    END

Capture Step Element ScreenShot
    [Documentation]    Capture avec règle de nommage du fichier
    ...    Le step permet d'identifier l'étape et de faire plusieurs captures par test
    ...    Arguments:
    ...        step    ==> Etat du traitement = FAIL
    ...        locator ==> L'id de localisation de l'objet de la page
    [Arguments]    ${step}    ${locator}
    ${status}    ${value1}    BuiltIn.Run Keyword And Ignore Error    Wait Until Page Contains Element    ${locator}
    IF    '${status}' == 'FAIL'
        Log To Console    "ok"
    ELSE
        ${dt}    DateTime.Get Current Date    result_format=%Y%m%d_%H%M%S%f
        Log Console    ${dt}    INFO
        ${filename}    Common.Clean String Filename    ${dt}_${TEST NAME}_${step}
        SeleniumLibrary.Capture Element Screenshot    ${locator}    ${OUTPUT DIR}${/}${filename}.png
    END

Test Teardown
    [Documentation]    Fermeture du cas de test
    [Tags]    Technique
    #Capture Step ScreenShot    ${TEST_STATUS}
    Log To Console    ================================================================== Close TEST SETUP

Test Teardown avec Url
    [Documentation]    Fermeture du cas de test
    [Tags]    Technique
    Close All Browsers
    Log To Console    ================================================================== Close TEST SETUP

Suite Teardown
    [Documentation]    Fermeture de la suite de tests
    [Tags]    Technique
    Close All Browsers
    Log To Console    ================================================================== Close SUITE SETUP

Suite Teardown Sans Url
    [Documentation]    Fermeture de la suite de tests
    [Tags]    Technique
    #Close All Browsers
    Log To Console    ================================================================== Close SUITE SETUP
