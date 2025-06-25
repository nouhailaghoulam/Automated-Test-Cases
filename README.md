# ROBOTFRAMEWORK / PLAYWRIGHT

1) Python 3	https://www.python.org/downloads

Installer la dernière version de Python 3 avec l'ensemble des compléments proposés dans l'installation avancée ainsi que les variables d'environnements configurées

2) Node JS	https://nodejs.org/en/download/prebuilt-installer		

Installer la dernière version de NodeJS avec l'ensemble des compléments proposés dans l'installation avancée ainsi que les variables d'environnements configurées

3)	Robot Framework	https://robotframework.org/?tab=1#getting-started	
	
		pip install robotframework	
	
Lancer cette ligne de commande dans un terminal avec droits admin

4) Browser Library	https://robotframework-browser.org/#installation	
	
		pip install robotframework-browser
		npm set strict-ssl false
		rfbrowser init

Lancer ces lignes de commande dans un terminal avec droits admin. La commande "rfbrowser init" peut poser problème en fonction de la configuration réseau/VPN. Si besoin, lancer les commandes ci-dessous :

	set NODE_TLS_REJECT_UNAUTHORIZED=0
	npm install -D @playwright/test@latest --no-strict-ssl
	npm i -D playwright --no-strict-ssl
	npm i -D @playwright/test --no-strict-ssl
	npx playwright install
	set NODE_TLS_REJECT_UNAUTHORIZED=1

5)	Visual Studio Code	https://code.visualstudio.com/	

Extensions: Python, RobotCode	

Installer la dernière version de VSCode ainsi que les deux extensions officielles via le marketplace

-- **COMMANDE DE LANCEMENT D'UN SCRIPT** --

	robot -d Results Tests/Scripts/{SCRIPT}.robot