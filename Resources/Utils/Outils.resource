*** Settings ***
Library    SeleniumLibrary
Library    JSONLibrary
Library    Collections
Resource   GestionBrowser.resource
Resource    %{PROJECT_FOLDER}/data-env/Environnement.resource
Resource    %{PROJECT_FOLDER}/Resources/PagesObjects/Autentification.resource

*** Variables ***
${Message}

*** Keywords ***
Set Language
    [Documentation]    Selection d'un language
    [Arguments]    ${aLangage}
    SelectByValue    ${aLangage}    #Tag    à créer dans les fichier json pour sélection de la langue dans la page

SelectByLabel
    [Documentation]    Selection d'un élément selon sa valeur dans une Combobox ou une liste
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    [Tags]    Technico-Fonctionnel
 
    ${Locator}    Outils.Get value Json Locator Data     ${aNom}
    ${Value}    Outils.Get value Json Lang Data    ${aNom}

    ${status}    PresentVisible    ${aNom}    ${Locator}

    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Element Should Be Enabled    ${Locator}
    TraitementStatus    ${status1}    séléctionnable    ${aNom}    ${Locator}    ${value1}

    # exemple Label: Français (France)
    ${status2}    ${value2}    BuiltIn.Run Keyword And Ignore Error    Select From List By Label    ${Locator}    ${Value}
    TraitementStatus    ${status2}    sélectionné    ${aNom}    ${Locator}    ${value2}

SelectByValue
    [Documentation]    Selection d'un élément selon sa valeur dans une Combobox ou une liste
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    [Tags]    Technico-Fonctionnel
 
    ${Locator}    Outils.Get value Json Locator Data     ${aNom}
    ${Value}    Outils.Get value Json Lang Data    ${aNom}

    ${status}    PresentVisible    ${aNom}    ${Locator}

    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Element Should Be Enabled    ${Locator}
    TraitementStatus    ${status1}    séléctionnable    ${aNom}    ${Locator}    ${value1}

    # exemple Value: Fr
    ${status2}    ${value2}    BuiltIn.Run Keyword And Ignore Error    Select From List By Value    ${Locator}    ${Value}
    TraitementStatus    ${status2}    sélectionné    ${aNom}    ${Locator}    ${value2}

Set
    [Documentation]    Saisie d'un texte dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    ${Locator}    Outils.Get value Json Locator Data     ${aNom}
    ${Value}    Outils.Get value Json Lang Data    ${aNom}

    PresentVisible    ${aNom}    ${Locator}

    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Element Should Be Enabled    ${Locator}
    TraitementStatus    ${status1}    saisissable    ${aNom}    ${Locator}    ${value1}

    ${status2}    ${value2}    BuiltIn.Run Keyword And Ignore Error    Input Text    ${Locator}    ${Value}
    TraitementStatus    ${status2}    saisie    ${aNom}    ${Locator}    ${value2}

NotSet
    [Documentation]    un texte non saisisable dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    ${Locator}    Outils.Get value Json Locator Data     ${aNom}

    PresentVisible    ${aNom}    ${Locator}

    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Element Should Be Disabled    ${Locator}
    TraitementStatus    ${status1}    non saisissable    ${aNom}    ${Locator}    ${value1}

NotSetContains
    [Documentation]    un texte non contenu dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}    ${aValue}
    ${Locator}    Outils.Get value Json Locator Data     ${aNom}

    PresentVisible    ${aNom}    ${Locator}

    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error     get element attribute    ${Locator}    value
    IF    '${status1}' == 'FAIL' or '${value1}' == '${aValue}'
        TraitementStatus    FAIL    non contenu (Value: ${aValue})    ${aNom}    ${Locator}    ${value1}
    END

EmptySet
    [Documentation]    un texte vide dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    ${Locator}    Outils.Get value Json Locator Data     ${aNom}
    ${Value}    Outils.Get value Json Lang Data    ${aNom}

    PresentVisible    ${aNom}    ${Locator}

    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error     get element attribute    ${Locator}    value
    IF    '${status1}' == 'FAIL' or '${value1}' == '${EMPTY}'
        TraitementStatus    FAIL    vide    ${aNom}    ${Locator}    ${value1}
    END

NotEmptySet
    [Documentation]    un texte non vide dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    ${Locator}    Outils.Get value Json Locator Data     ${aNom}

    PresentVisible    ${aNom}    ${Locator}

    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error     get element attribute    ${Locator}    value
    IF    '${status1}' == 'FAIL' or '${value1}' != '${EMPTY}'
        TraitementStatus    FAIL   non vide    ${aNom}    ${Locator}    ${value1}
    END

Get
    [Documentation]    Lire un texte dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    ...    Sortie:
    ...        Le texte lu
    [Arguments]    ${aNom}    ${aAttribute}
    ${Locator}    Outils.Get value Json Locator Data     ${aNom}

    PresentVisible    ${aNom}    ${Locator}

    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    get element attribute    ${Locator}    ${aAttribute}
    TraitementStatus    ${status1}    lisible    ${aNom}    ${Locator}    ${value1}
    
    RETURN    ${value1}

GetText
    [Documentation]    Lire un texte dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    ...    Sortie:
    ...        Le texte lu
    [Arguments]    ${aNom}

    ${Locator}    Outils.Get value Json Locator Data     ${aNom}

    PresentVisible    ${aNom}    ${Locator}

    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Get Text    ${Locator}
    TraitementStatus    ${status1}    lisible    ${aNom}    ${Locator}    ${value1}
    

GetValue
    [Documentation]    Lire un texte dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    ...    Sortie:
    ...        La valeur lu
    [Arguments]    ${aNom}

    ${return}=    Get    ${aNom}    value

    RETURN    ${return}

GetLabel
    [Documentation]    Lire un texte dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    ...    Sortie:
    ...        Le label lu
    [Arguments]    ${aNom}

    ${return}=    Get    ${aNom}    label

    RETURN    ${return}

GetPlaceholder
    [Documentation]    Lire un texte dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    ...    Sortie:
    ...        Le placeholder lu
    [Arguments]    ${aNom}

    ${return}=    GetSansArret    ${aNom}    placeholder

    RETURN    ${return}

Checked
    [Documentation]    Check ou Uncheck d'un élément Checkbox
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    ${Locator}    Outils.Get value Json Locator Data     ${aNom}
    ${Value}    Outils.Get value Json Lang Data    ${aNom}

    PresentVisible    ${aNom}    ${Locator}

    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    BuiltIn.Element Should Be Checked    ${Locator}    ${Value}
    TraitementStatus    ${status1}    checkable    ${aNom}    ${Locator}    ${value1}

    ${status2}    ${value1}    BuiltIn.Run Keyword And Ignore Error    BuiltIn.Select Checkbox    ${Locator}    ${Value}
    TraitementStatus    ${status2}    Check    ${aNom}    ${Locator}    ${value1}

Verify
    [Documentation]    Vérifier le texte d'un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    #Log To Console    ${aNom}
    
    ${Locator}    Outils.Get value Json Locator Data     ${aNom}
    ${Value}    Outils.Get value Json Lang Data    ${aNom}
    Log To Console    ${Locator}
    Log To Console    ${Value}

    PresentVisible    ${aNom}    ${Locator}

    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Element Should Contain    ${Locator}    ${Value}
    TraitementStatus    ${status1}    contenu (${Value})    ${aNom}    ${Locator}    ${value1}

Click  
    [Documentation]    Clic sur un élément identifié par le paramètre locator
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    [Tags]    Technique

    ${locator}    Outils.Get value Json Locator Data    ${aNom}

    PresentVisible    ${aNom}    ${Locator}

    #BuiltIn.Run Keyword    SeleniumLibrary.Click Element    xpath:${locator}
    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Click Element    ${locator}
    TraitementStatus    ${status1}    cliqué    ${aNom}    ${Locator}    ${value1}

PresentVisible
    [Documentation]    Présence et visibilité d'un élément dans la page
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    ...        aLocator ==> L'id de localisation de l'objet de la page
    [Arguments]    ${aNom}    ${aLocator}
    [Tags]    Technique

    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    Wait Until Page Contains Element    ${aLocator}
    TraitementStatus    ${status1}    présent    ${aNom}    ${aLocator}    ${value1}

    ${status2}    ${value2}    BuiltIn.Run Keyword And Ignore Error    Element Should Be Visible    ${aLocator}
    TraitementStatus    ${status2}    visible    ${aNom}    ${aLocator}    ${value2}

TraitementStatus
    [Documentation]    Gestion des messages selon le traitement et le statut
    ...    Arguments:
    ...        aStatus     ==> Le statut du traitement
    ...        aTraitement ==> Le libellé message du traitement
    ...        aNom ==> Le chemin dans les fichiers json
    ...        aLocator    ==> L'id de localisation de l'objet de la page
    ...        aStackTrace ==> La stack trace erreur
    [Arguments]    ${aStatus}    ${aTraitement}    ${aNom}    ${aLocator}    ${aStackTrace}
    [Tags]    Technique
    
    ${Message}    BuiltIn.Set Variable    ${TEST NAME}: Le locator '${aNom}'(${aLocator}) n'est pas ${aTraitement} dans la page
    Log To Console    ${Message}
    IF    '${aStatus}' == 'FAIL'
        Capture Step Element ScreenShot    ${aStatus}    ${aLocator}
        Log Report    ${Message}    ERROR
        BuiltIn.Fail    ${aStackTrace} 
    ELSE
        ${Message}    BuiltIn.Set Variable    ${TEST NAME}: Le locator '${aNom}'(${aLocator}) est ${aTraitement} dans la page
        Log To Console    ${Message}
    END

SelectByLabelSansArret
    [Documentation]    Selection d'un élément selon sa valeur dans une Combobox ou une liste
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    [Tags]    Technico-Fonctionnel
 
    ${Locator}    Outils.Get value Json Locator Data SansArret    ${aNom}
    ${Value}    Outils.Get value Json Lang Data SansArret   ${aNom}

    IF    "${Locator}" != ""
        ${status}    PresentVisibleSansArret    ${aNom}    ${Locator}

        IF    '${status}' == 'PASS'
            ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Element Should Be Enabled    ${Locator}
            IF    '${status1}' == 'FAIL'
                TraitementStatusSansArret    ${status1}    séléctionnable    ${aNom}    ${Locator}    ${value1}
                BuiltIn.Run Keyword And Continue On Failure    SeleniumLibrary.Element Should Be Enabled    ${Locator}
            END

            IF    '${status1}' == 'PASS'
                # exemple Label: Français (France)
                ${status2}    ${value1}    BuiltIn.Run Keyword And Ignore Error    Select From List By Label    ${Locator}    ${Value}
                IF    '${status2}' == 'FAIL'
                    TraitementStatusSansArret    ${status2}    sélectionné (Label: ${Value})   ${aNom}    ${Locator}    ${value1}
                    BuiltIn.Run Keyword And Continue On Failure    Select From List By Label    ${Locator}
                END
            END
        END
    END

SelectByValueSansArret
    [Documentation]    Selection d'un élément selon sa valeur dans une Combobox ou une liste
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    [Tags]    Technico-Fonctionnel
 
    ${Locator}    Outils.Get value Json Locator Data SansArret    ${aNom}
    ${Value}    Outils.Get value Json Lang Data SansArret   ${aNom}

    IF    "${Locator}" != ""
        ${status}    PresentVisibleSansArret    ${aNom}    ${Locator}

        IF    '${status}' == 'PASS'
            ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Element Should Be Enabled    ${Locator}
            IF    '${status1}' == 'FAIL'
                TraitementStatusSansArret    ${status1}    séléctionnable    ${aNom}    ${Locator}    ${value1}
                BuiltIn.Run Keyword And Continue On Failure    SeleniumLibrary.Element Should Be Enabled    ${Locator}
            END

            IF    '${status1}' == 'PASS'
                # exemple Value: Fr
                ${status2}    ${value1}    BuiltIn.Run Keyword And Ignore Error    Select From List By Value    ${Locator}    ${Value}
                IF    '${status2}' == 'FAIL'
                    TraitementStatusSansArret    ${status2}    sélectionné (Value: ${Value})    ${aNom}    ${Locator}    ${value1}
                    BuiltIn.Run Keyword And Continue On Failure    Select From List By Value    ${Locator}
                END
            END
        END
    END

SetSansArret
    [Documentation]    Saisie d'un texte dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}    ${aValue}
    ${Locator}    Outils.Get value Json Locator Data SansArret    ${aNom}

    IF    "${Locator}" != ""
        ${status}    PresentVisibleSansArret    ${aNom}    ${Locator}
        
        IF    '${status}' == 'PASS'
            ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Element Should Be Enabled    ${Locator}
            IF    '${status1}' == 'FAIL'
                TraitementStatusSansArret    ${status1}    saisissable    ${aNom}    ${Locator}    ${value1}
                BuiltIn.Run Keyword And Continue On Failure    SeleniumLibrary.Element Should Be Enabled    ${Locator}
            END

            IF    '${status1}' == 'PASS'
                ${status2}    ${value1}    BuiltIn.Run Keyword And Ignore Error    Input Text    ${Locator}    ${aValue}
                IF    '${status2}' == 'FAIL'
                    TraitementStatusSansArret    ${status2}    saisie (Value: ${aValue})    ${aNom}    ${Locator}    ${value1}
                    BuiltIn.Run Keyword And Continue On Failure    Input Text    ${Locator}
                END
            END
        END
    END

NotSetSansArret
    [Documentation]    un texte non saisisable dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    ${Locator}    Outils.Get value Json Locator Data SansArret    ${aNom}

    IF    "${Locator}" != ""
        ${status}    PresentVisibleSansArret    ${aNom}    ${Locator}

        IF    '${status}' == 'PASS'
            ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Element Should Be Disabled    ${Locator}
            IF    '${status1}' == 'FAIL'
                TraitementStatusSansArret    ${status1}    non saisissable    ${aNom}    ${Locator}    ${value1}
                BuiltIn.Run Keyword And Continue On Failure    SeleniumLibrary.Element Should Be Disabled    ${Locator}
            END
        END
    END

NotSetContainsSansArret
    [Documentation]    un texte non contenu dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}    ${aValue}
    ${Locator}    Outils.Get value Json Locator Data SansArret    ${aNom}

    IF    "${Locator}" != ""
        ${status}    PresentVisibleSansArret    ${aNom}    ${Locator}

        IF    '${status}' == 'PASS'
            ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error     get element attribute    ${Locator}    value
            Log To Console    Val: ${value1}
            IF    '${status1}' == 'FAIL'
                TraitementStatusSansArret    ${status1}    non contenu (Value: ${aValue})    ${aNom}    ${Locator}    ${value1}
                BuiltIn.Run Keyword And Continue On Failure    SeleniumLibrary.Element Should Not Contain    ${Locator}    ${aValue}
            END
        END
    END

EmptySetSansArret
    [Documentation]    un texte vide dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    
    ${Locator}    Outils.Get value Json Locator Data SansArret    ${aNom}

    IF    "${Locator}" != ""
        ${status}    PresentVisibleSansArret    ${aNom}    ${Locator}

        IF    '${status}' == 'PASS'
            ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error     get element attribute    ${Locator}    value
            #Log To Console    Val: ${value1}
            #Log To Console    Valu: ${aValue}
            IF    '${status1}' == 'FAIL' or '${value1}' == '${EMPTY}'
                TraitementStatusSansArret    FAIL    vide    ${aNom}    ${Locator}    ${value1}
                BuiltIn.Run Keyword And Continue On Failure    Should Not Be Equal    '${value1}'   '${EMPTY}'
            END
        END
    END

NotEmptySetSansArret
    [Documentation]    un texte non vide dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    
    ${Locator}    Outils.Get value Json Locator Data SansArret    ${aNom}

    IF    "${Locator}" != ""
       ${status}    PresentVisibleSansArret    ${aNom}    ${Locator}

        IF    '${status}' == 'PASS'
            ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error     get element attribute    ${Locator}    value
            Log To Console    Val: ${value1}
            IF    '${status1}' == 'FAIL' or '${value1}' != '${EMPTY}'
                TraitementStatusSansArret    FAIL    non vide    ${aNom}    ${Locator}    ${value1}
                BuiltIn.Run Keyword And Continue On Failure    Should Not Be Equal    '${value1}'   '${EMPTY}'
            END
        END
    END

GetSansArret
    [Documentation]    Lire un texte dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    ...    Sortie:
    ...        Le texte lu
    [Arguments]    ${aNom}    ${aAttribute}
    ${Locator}    Outils.Get value Json Locator Data SansArret    ${aNom}

    IF    "${Locator}" != ""
        ${status}    PresentVisibleSansArret    ${aNom}    ${Locator}

        IF    '${status}' == 'PASS'
            ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error     get element attribute    ${Locator}    ${aAttribute}
            IF    '${status1}' == 'FAIL'
                TraitementStatusSansArret    ${status1}    lisible    ${aNom}    ${Locator}    ${value1}
                BuiltIn.Run Keyword And Continue On Failure    get element attribute    ${Locator}    ${aAttribute}
                RETURN    ""
            ELSE
                RETURN    ${value1}
            END
        ELSE
            RETURN    ""
        END
    ELSE
        RETURN    ""
    END

GetTextSansArret
    [Documentation]    Lire un texte dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    ...    Sortie:
    ...        Le texte lu
    [Arguments]    ${aNom}

    ${Locator}    Outils.Get value Json Locator Data SansArret    ${aNom}

    IF    "${Locator}" != ""
        ${status}    PresentVisibleSansArret    ${aNom}    ${Locator}

        IF    '${status}' == 'PASS'
            ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error     SeleniumLibrary.Get Text    ${Locator}
            IF    '${status1}' == 'FAIL'
                TraitementStatusSansArret    ${status1}    lisible    ${aNom}    ${Locator}    ${value1}
                BuiltIn.Run Keyword And Continue On Failure    SeleniumLibrary.Get Text    ${Locator}
                RETURN    ""
            ELSE
                RETURN    ${value1}
            END
        ELSE
            RETURN    ""
        END
    ELSE
        RETURN    ""
    END

GetValueSansArret
    [Documentation]    Lire un texte dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    ...    Sortie:
    ...        L valeur lu
    [Arguments]    ${aNom}

    ${return}=    GetSansArret    ${aNom}    value

    RETURN    ${return}

GetLabelSansArret
    [Documentation]    Lire un texte dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    ...    Sortie:
    ...        Le label lu
    [Arguments]    ${aNom}

    ${return}=    GetSansArret    ${aNom}    label

    RETURN    ${return}

GetPlaceholderSansArret
    [Documentation]    Lire un texte dans un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    ...    Sortie:
    ...        Le placeholder lu
    [Arguments]    ${aNom}

    ${return}=    GetSansArret    ${aNom}    placeholder

    RETURN    ${return}

CheckedSansArret
    [Documentation]    Check ou Uncheck d'un élément Checkbox
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    ${Locator}    Outils.Get value Json Locator Data SansArret    ${aNom}
    ${Value}    Outils.Get value Json Lang Data SansArret   ${aNom}

    IF    "${Locator}" != ""
        ${status}    PresentVisibleSansArret    ${aNom}    ${Locator}

        IF    '${status}' == 'PASS'
            ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    BuiltIn.Element Should Be Checked    ${Locator}    ${Value}
            IF    '${status1}' == 'FAIL'
                TraitementStatusSansArret    ${status1}    checkable    ${aNom}    ${Locator}    ${value1}
                BuiltIn.Run Keyword And Continue On Failure    BuiltIn.Element Should Be Checked    ${Locator}
            END

            IF    '${status1}' == 'PASS'
                ${status2}    ${value1}    BuiltIn.Run Keyword And Ignore Error    BuiltIn.Select Checkbox    ${Locator}    ${Value}
                IF    '${status2}' == 'FAIL'
                    TraitementStatusSansArret    ${status2}    Check    ${aNom}    ${Locator}    ${value1}
                    BuiltIn.Run Keyword And Continue On Failure    BuiltIn.Element Should Be Checked    ${Locator}
                END
            END
        END
    END

VerifySansArret
    [Documentation]    Vérifier le texte d'un élément
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    #Log To Console    ${aNom}
    
    ${Locator}    Outils.Get value Json Locator Data SansArret    ${aNom}
    ${Value}    Outils.Get value Json Lang Data SansArret   ${aNom}
    #Log To Console    ${Locator}
    #Log To Console    ${Value}

    IF    "${Locator}" != ""
        ${status}    PresentVisibleSansArret    ${aNom}    ${Locator}

        IF    '${status}' == 'PASS'
            ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Element Should Contain    ${Locator}    ${Value}
            IF    '${status1}' == 'FAIL'
                TraitementStatusSansArret    ${status1}    contenu (${Value})    ${aNom}    ${Locator}    ${value1}
                BuiltIn.Run Keyword And Continue On Failure    SeleniumLibrary.Element Should Contain    ${Locator}
            END
        END
    END

ClickSansArret 
    [Documentation]    Clic sur un élément identifié par le paramètre locator
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    [Arguments]    ${aNom}
    [Tags]    Technique

    ${Locator}    Outils.Get value Json Locator Data SansArret    ${aNom}

    IF    "${Locator}" != ""
        ${status}    PresentVisibleSansArret    ${aNom}    ${Locator}

        IF    '${status}' == 'PASS'
            ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Click Element    ${locator}
            IF    '${status1}' == 'FAIL'
                TraitementStatusSansArret    ${status1}    cliqué    ${aNom}    ${Locator}    ${value1}
                BuiltIn.Run Keyword And Continue On Failure    SeleniumLibrary.Click Element    ${Locator}
            END
        END
    END

PresentVisibleSansArret
    [Documentation]    Présence et visibilité d'un élément dans la page
    ...    Arguments:
    ...        aNom ==> Le chemin dans les fichiers json
    ...        aLocator ==> L'id de localisation de l'objet de la page
    [Arguments]    ${aNom}    ${aLocator}
    [Tags]    Technique
    
    ${status1}    ${value1}    BuiltIn.Run Keyword And Ignore Error    SeleniumLibrary.Wait Until Page Contains Element    ${aLocator}
    IF    '${status1}' == 'FAIL'
        TraitementStatusSansArret    ${status1}    présent    ${aNom}    ${aLocator}    ${value1}
        BuiltIn.Run Keyword And Continue On Failure    SeleniumLibrary.Wait Until Page Contains Element    ${aLocator}
    END

    IF    '${status1}' == 'PASS'
        ${status2}    ${value2}    BuiltIn.Run Keyword And Ignore Error    Element Should Be Visible    ${aLocator}
        
        IF    '${status2}' == 'FAIL'
            TraitementStatusSansArret    ${status2}    visible    ${aNom}    ${aLocator}    ${value2}
            BuiltIn.Run Keyword And Continue On Failure    Element Should Be Visible    ${aLocator}
            RETURN    ${status2}
        END
    END
    RETURN    ${status1}

TraitementStatusSansArret
    [Documentation]    Gestion des messages selon le traitement et le statut
    ...    Arguments:
    ...        aStatus     ==> Le statut du traitement
    ...        aTraitement ==> Le libellé message du traitement
    ...        aNom ==> Le chemin dans les fichiers json
    ...        aLocator    ==> L'id de localisation de l'objet de la page
    ...        aStackTrace ==> La stack trace erreur
    [Arguments]    ${aStatus}    ${aTraitement}    ${aLocator}    ${aNom}    ${aStackTrace}
    [Tags]    Technique
    
    ${Message}    BuiltIn.Set Variable    ${TEST NAME}: Le locator '${aNom}'(${aLocator}) n'est pas ${aTraitement} dans la page
    
    IF    '${aStatus}' == 'FAIL'
        Capture Step ScreenShot    ${aStatus}
        #Capture Step Element ScreenShot    ${aStatus}    ${aLocator}
        Log Report    ${Message}    ERROR 
    ELSE
        ${Message}    BuiltIn.Set Variable    ${TEST NAME}: Le locator '${aNom}'(${aLocator}) est ${aTraitement} dans la page
        Log To Console    ${Message}
    END

Log Report
    [Documentation]    Création du message dans le Rapport
    ...    Arguments:
    ...        aMessage  ==> Le message du traitement
    ...        level     ==> ERREUR / INFO / WARN ...
    [Arguments]    ${message}    ${level}
    [Tags]    Technique
    BuiltIn.Log    ${message}    level=${level}    console=False

Log Console
    [Documentation]    Création du message dans la log
    ...    Arguments:
    ...        aMessage  ==> Le message du traitement
    ...        level     ==> ERREUR / INFO / WARN ...
    [Arguments]    ${message}    ${level}
    [Tags]    Technique
    #BuiltIn.Log    ${message}    level=${level}    console=True
    Log To Console    ${message}

Get Json Lang Data
    [Documentation]    Chargement du fichier json selon la langue
    ${DataLangJson}    Load JSON from file     %{PROJECT_FOLDER}/Data-env/Label_${LANG}.json    encoding=utf-8
    RETURN          ${DataLangJson}

Get value Json Lang Data
    [Documentation]    Chargement du fichier json selon la langue
    ...    Arguments:
    ...        aLocator ==> Le nom de l'id de localisation de l'objet de la page
    [Arguments]    ${aLocator}
    [Tags]    Technique
    ${DataLangJson}    Get Json Lang Data
    ${ValueLangJson}    get value from json    ${DataLangJson}    ${aLocator}    fail_on_empty=${True}
    ${ValueLangJsonLg}=    Get Length    ${ValueLangJson}
    IF    ${ValueLangJsonLg} == 0
        TraitementStatus    FAIL    présent dans le json du Language '${LANG}'   ${aLocator}    ''    'List 'ValueLangJson' has no item in index 0.'
        RETURN    ${EMPTY}
    ELSE
        RETURN          ${ValueLangJson}[0]
    END

Get value Json Lang Data SansArret
    [Documentation]    Chargement du fichier json selon la langue
    ...    Arguments:
    ...        aLocator ==> Le nom de l'id de localisation de l'objet de la page
    [Arguments]    ${aLocator}
    [Tags]    Technique
    ${DataLangJson}    Get Json Lang Data
    ${ValueLangJson}    get value from json    ${DataLangJson}    ${aLocator}
    ${ValueLangJsonLg}=    Get Length    ${ValueLangJson}
    IF    ${ValueLangJsonLg} == 0
        TraitementStatusSansArret    FAIL    présent dans le json du Language '${LANG}'   ${aLocator}    ''    'List 'ValueLangJson' has no item in index 0.'
        BuiltIn.Run Keyword And Continue On Failure    get value from json    ${DataLangJson}    ${aLocator}    fail_on_empty=${True}
        RETURN    ${EMPTY}
    ELSE
        RETURN          ${ValueLangJson}[0]
    END

Get Json Locator Data
    [Documentation]    Chrgement du fichier json des locators
    ${DataLocatorJson}         Load JSON from file     %{PROJECT_FOLDER}/Data-env/Locators.json    encoding=utf-8
    RETURN          ${DataLocatorJson}

Get value Json Locator Data
    [Documentation]    Chrgement du fichier json des locators
    ...    Arguments:
    ...        aLocator ==> Le nom de l'id de localisation de l'objet de la page
    [Arguments]    ${aLocator}
    [Tags]    Technique
    ${DataLocatorJson}    Get Json Locator Data
    
    ${ValueLocatorJson}    get value from json    ${DataLocatorJson}    ${aLocator}    #fail_on_empty=${True}
    ${ValueLocatorJsonLg}=    Get Length    ${ValueLocatorJson}
    IF    ${ValueLocatorJsonLg} == 0
        TraitementStatus    FAIL    présent dans le json des Locators    ${aLocator}    ''    'List 'ValueLocatorJson' has no item in index 0.'
        RETURN    ${EMPTY}
    ELSE
        RETURN    ${ValueLocatorJson}[0]
    END

Get value Json Locator Data SansArret
    [Documentation]    Chrgement du fichier json des locators
    ...    Arguments:
    ...        aLocator ==> Le nom de l'id de localisation de l'objet de la page
    [Arguments]    ${aLocator}
    [Tags]    Technique
    ${DataLocatorJson}    Get Json Locator Data
    
    ${ValueLocatorJson}    get value from json    ${DataLocatorJson}    ${aLocator}
    ${ValueLocatorJsonLg}=    Get Length    ${ValueLocatorJson}
    IF    ${ValueLocatorJsonLg} == 0
        TraitementStatusSansArret    FAIL    présent dans le json des Locators    ${aLocator}    ''    'List 'ValueLocatorJson' has no item in index 0.'
        BuiltIn.Run Keyword And Continue On Failure    get value from json    ${DataLocatorJson}    ${aLocator}    fail_on_empty=${True}
        RETURN    ${EMPTY}
    ELSE
        RETURN    ${ValueLocatorJson}[0]
    END
