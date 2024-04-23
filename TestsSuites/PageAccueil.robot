*** Settings ***
Resource    %{PROJECT_FOLDER}/Data-env/Environnement.resource
Resource    %{PROJECT_FOLDER}/Resources/Utils/GestionBrowser.resource
Resource    %{PROJECT_FOLDER}/Resources/PagesObjects/Autentification.resource

Suite Setup       Suite Setup Sans Url
Test Setup          Test Setup
Test Teardown       Test Teardown avec Url
Suite Teardown    Suite Teardown Sans Url

*** Test Cases ***
TC Controler la page d'accueil OpenCruise
    [Documentation]    Controle de la présence de tous les element de la page d'accueil 
    ...    possible d'écrire les appels Json:
    ...        [Connexion][LabelUsername]
    ...    ou
    ...       $..[*].LabelUsername ==> Attention il faut que le nom soit unique dans le fichier ==> Déconseillé 
    [Tags]    Technique
    
    GestionBrowser.OpenBrowserManuel    ${URL_IHM}
    Set Language    ${LANG}


    Outils.VerifySansArret    [Connexion][LabelUsername]
    Outils.VerifySansArret    [Connexion][Text1]
    Outils.SelectByLabelSansArret    [Connexion][PaysLabel]
    Outils.SelectByValueSansArret    [Connexion][PaysValue]
    Outils.SetSansArret    [Connexion][Username]    toto
    Outils.NotSetSansArret    [Connexion][Username]
    Outils.GetValueSansArret    [Connexion][Username]
    Outils.GetValueSansArret    [Connexion][LabelUsername]
    Outils.GetValueSansArret    [Connexion][Text1]
    Outils.NotSetContainsSansArret    [Connexion][Username]    toto
    Outils.NotEmptySetSansArret    [Connexion][Username1]
    Outils.GetValueSansArret    [Connexion][LabelUsername]
    Outils.NotSetContainsSansArret    [Connexion][Username]    toto1
    ${ret}=      Outils.GetValueSansArret    [Connexion][Username]
    Log To Console    ret1: ${ret}*

TC Controler la page d'accueil Digital Systems
    [Documentation]    Controle de la présence de tous les element de la page d'accueil 
    ...    possible d'écrire les appels Json:
    ...        [Connexion][LabelUsername]
    ...    ou
    ...       $..[*].LabelUsername ==> Attention il faut que le nom soit unique dans le fichier ==> Déconseillé 
    [Tags]    Technique
    
    GestionBrowser.OpenBrowserManuel    ${URL_IHM1}
    #Set    [Connexion][Username]
    Outils.VerifySansArret    [Accueil][Texte1]
    #${resultat}=     GetSansArret    [Accueil][Texte2]
    #Log To Console    resultat:${resultat}
    Outils.VerifySansArret    [Accueil][Texte2]
    Outils.VerifySansArret    [Accueil][Texte3]

TC Controler la page d'accueil Elit
    [Documentation]    Controle de la présence de tous les element de la page d'accueil 
    ...    possible d'écrire les appels Json:
    ...        [Connexion][LabelUsername]
    ...    ou
    ...       $..[*].LabelUsername ==> Attention il faut que le nom soit unique dans le fichier ==> Déconseillé 
    [Tags]    Technique
    
    GestionBrowser.OpenBrowserManuel    ${URL_IHM2}
    GestionBrowser.VerifierURL    ${URL_IHM2}
    Outils.VerifySansArret    [Connexion2][Username]
    ${ret}=      Outils.GetTextSansArret    [Connexion2][Username]
    Log To Console    Username text: ${ret}
    ${ret}=      Outils.GetValueSansArret    [Connexion2][Username]
    Log To Console    Username: ${ret}
    ${ret}=      Outils.GetPlaceholderSansArret    [Connexion2][Placeholder]
    Log To Console    Placeholder: ${ret}
    ${ret}=      Outils.GetLabelSansArret    [Connexion2][LabelUsername]
    Log To Console    LabelUsername: ${ret}
    #Revoi une erreur
    ${ret}=      Outils.GetTextSansArret    [Connexion2][Text2]
    Log To Console    Text2: ${ret}
    ${ret}=      Outils.GetValueSansArret    [Connexion2][Text2]
    Log To Console    Text2: ${ret}
    ${ret}=      Outils.GetValueSansArret    [Connexion2][Text1]
    Log To Console    Text1: ${ret}
    ${ret}=      Outils.GetValueSansArret    [Connexion2][Text3]
    Log To Console    Text3: ${ret}

TC Controler la connexion Digital Systems
    [Documentation]    Controle de la présence de tous les element de la page d'accueil 
    ...    possible d'écrire les appels Json:
    ...        [Connexion][LabelUsername]
    ...    ou
    ...       $..[*].LabelUsername ==> Attention il faut que le nom soit unique dans le fichier ==> Déconseillé 
    [Tags]    Technique
    
    OpenBrowserManuel    ${URL_CONNEXION}

    Autentification.ConnexionDS
    Autentification.DeconnexionDS
