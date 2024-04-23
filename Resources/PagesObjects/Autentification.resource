*** Settings ***
Resource    %{PROJECT_FOLDER}/Data-env/Environnement.resource
Resource    %{PROJECT_FOLDER}/Resources/Utils/Outils.resource
Resource    %{PROJECT_FOLDER}/Resources/Utils/GestionBrowser.resource

*** Variables ***

*** Keywords ***
ConnexionDS  
    [Documentation]    Fonction permettant de se connecter à un compte Digital System à l'aide de l'environnement
    [Tags]    Technique

    Outils.VerifySansArret    [Accueil][BoutonConnexion]
    Outils.Click    [Accueil][BoutonConnexion]
    Outils.VerifySansArret    [Connexion][Text1]
    GestionBrowser.VerifierURL    ${URL_CONNEXION}
    Outils.Set    [Connexion][Username]
    Outils.Set    [Connexion][Password]
    Outils.Click    [Connexion][BoutonValider]
    Outils.VerifySansArret    [Accueil][BoutonNomConnecte]
    GestionBrowser.VerifierURL    ${URL_CONNEXION}

DeconnexionDS  
    [Documentation]    Fonction permettant de se déconnecter du compte Digital System
    [Tags]    Technique

    Outils.VerifySansArret    [Accueil][BoutonNomConnecte]
    GestionBrowser.VerifierURL    ${URL_CONNEXION}
    Outils.Click    [Accueil][BoutonNomConnecte]
    Outils.Click    [Accueil][BoutonDeconnexion]
    Outils.VerifySansArret    [Accueil][BoutonConnexion]
    GestionBrowser.VerifierURL    ${URL_CONNEXION}
