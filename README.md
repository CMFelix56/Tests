# PROJET ROBOT FRAMEWORK SELENIUM
	(NE PAS ETRE EN VPN)
	
Ce projet est un robot de test automatisés sur  
[Robot Framework](https://robotframework.org/)  
[Robot Framework Documentation](https://robotframework.org/robotframework/)  
[SeleniumLibrary Documentation](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)  
Installer l'IDE Visual Studio Code
[Visual Studio Code](https://code.visualstudio.com/)  

# INSTALLATION  

Projet initialisé et validé sous Windows 10  
Vous devez avoir Python >= 3.8 < 3.11  
On vous conseille la 3.10   
https://www.python.org/ftp/python/3.10.8/python-3.10.8-amd64.exe  

Si vous utilisez Git sur votre projet
Depuis un terminal CMD
```
winget install --id Git.Git -e --source winget
```
Lancez VSCODE et cloner https://sogetiLabsParis@dev.azure.com/sogetiLabsParis/DIGITAL_SYSTEMS/_git/DIGITAL_SYSTEMS_RBF
sur : C:\Users\cemercie\AppData\Local\TESTFACTORY\workspace

Ajouter les plugings dans VS code via marketplace
```
Ctrl + Shift + X
Python language support with extension access points for IntelliSense
Robot Framework Language Server
```
Puis fermer vscode


Tous changements des variables d'environnement nécessitent de relancer votre terminal CMD ou VS Code pour que cela soit effectif  

Depuis un terminal CMD, se positionner à la racine du projet celui défini via VS code
Normalement vous êtes dans :  \DIGITAL_SYSTEMS_RBF
(cd C:\Users\cemercie\AppData\Local\TESTFACTORY\workspace\DIGITAL_SYSTEMS_RBF)

Vous devez avoir le binaire chromedriver.exe connu de votre PATH  
La version majeure (premiers chiffres) de chromedriver doit être identique à celle de chrome  
[chromedriver downloads](https://chromedriver.chromium.org/downloads) 
```
Pour vérifier la version de chrome depuis son url    
chrome://version    
Depuis un CMD pour vérifier que chromedriver est connu du PATH  
where chromedriver   
Depuis un CMD pour vérifier la version du chromedriver  
chromedriver --version 
```

Vous devez créer un environnement virtuel Python nommé venv    
```
py -m venv venv
```
Vous devez activer l'environnement virtuel
```
venv\Scripts\activate
```
Vous pouvez mettre à jour les outils de gestion de package   
```
py -m pip install -U pip setuptools wheel
```
Vous devez installer les packages présents dans requirements.txt   
```
py -m pip install -r requirements.txt
```

Veuillez mettre à jour le fichier requirements.txt après chaque montée de version des librairies, en executant cette comande :
```
py -m pip freeze > requirements.txt  
```

Pour lancer les tests en ligne de commande  
Vous devez déclarer PROJECT_FOLDER  
```
En PS  
$env:PROJECT_FOLDER = $pwd  
En CMD  
set PROJECT_FOLDER=%CD%  
```

Vérifier les installations:
```
python --version
py -0p
pip list
```

Vous devez normalement avoir une popup sous vscode qui vous préconise les extensions à installer (car préconfiguré dans .vscode\extensions.json)  

Si la dernière version de "Robot Framework Langage Server" est toujours en 1.5.0, vous devez cliquez sur le bouton qui permet de passer à la Pre-Release  

# UTILISATION

Pour lancer les tests en ligne de commande    
Prérequis l'environnement virtuel est activé  
```
py -m robot --outputdir Results --variable BROWSER:chrome --variable LANG:Fr 
# --include tnr tests\testsuites

ou

robot -d Results -v BROWSER:chrome -v LANG:Fr 
#-i tnr tests\testsuites

```

Les fichiers de configuration sous .vscode permettent de lancer les tests depuis l'IDE  

Vous pouvez lancer les tasks avec CRTL+SHIFT+P