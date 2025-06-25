*** Settings ***
Library    Browser
Library    Collections
Library    String
Library    OperatingSystem
Library    ${CURDIR}/SF_Connection.py
Resource   ${CURDIR}/../env/users.resource
Resource   ${CURDIR}/../env/env.resource
Library    ${CURDIR}/checkPDF.py

# Environnement & paramètres généraux : 
Resource  ${CURDIR}/../keywords/Methodes_Techniques.robot
Resource  ${CURDIR}/../or/OR.resource

Documentation    Ce fichier contient les mots-clés relatifs à Salesforce

*** Variables ***
${timeout} =    30s


*** Keywords ***
Je me connecte a Salesforce avec le user ${user}
    ${URL_SALESFORCE_Logged}    Run Keyword If    ${user}==${USER_SALESFORCE_Robot}    getAuthenticatedSalesforceURL
    Lancer un nouveau navigateur
    Comment    etape 1.1
    New Page
    Run Keyword If    ${user}==${USER_SALESFORCE_Robot}    Go To    ${URL_SALESFORCE_Logged}    60s
    Run Keyword If    ${user}!=${USER_SALESFORCE_Robot}    Go To    ${URL_SALESFORCE}    60s
    # Run Keyword If    ${user}==${USER_SALESFORCE_Robot}    New Page    ${URL_SALESFORCE_Logged}
    # Run Keyword If    ${user}!=${USER_SALESFORCE_Robot}    New Page    ${URL_SALESFORCE}
    Sleep    5
    Go To    ${URL_SALESFORCE}    60s
    # Go To    ${URL_SALESFORCE}
    Comment etape 1.2
    Run Keyword If    ${user}!=${USER_SALESFORCE_Robot}    Se connecter avec le user ${user}
    Sleep    10
 

Se connecter avec le user ${user}
    Wait For Elements State    [name="username"]    visible
    Type Text    [name="username"]    ${user}[username]
    Wait For Elements State    [name="pw"]    visible
    Type Text    [name="pw"]    ${user}[password]
    Click    text=Se connecter à un Sandbox
    # Wait For Elements State    text=Bienvenue sur la plateforme Salesforce    visible
    DEBUG - Screenshot

Je lance l'application ${Lanceur application} ${Menu Navigation}
    Je clique sur //button[contains(@title, "Lanceur d'application")]
    Sleep    1
    Type Text    //input[contains(@placeholder, 'Recherchez des applications et des éléments')]    ${Lanceur application}
    Sleep    1
    Je clique sur //div[contains(@aria-label, 'Application')]//a[@data-label='${Lanceur application}']
    Sleep    5
    Comment etape 2.1
    Je clique sur "Afficher le menu de navigation"
    Sleep    1
    Comment etape 2.2
    Je clique sur //a[@role='menuitem'][.//*[contains(text(), '${Menu Navigation}')]]
    Sleep    10
    Fermer tous les onglets
    # Fermeture de l'éventuelle popup pouvant s'afficher en bas à droite de l'écran
    Run Keyword And Ignore Error    Je clique sur //button[@title='Fermer']
    
Fermer tous les onglets
    ${boutonFermerOnglet}    Set Variable    //div[contains(@aria-label, 'Espaces de travail')]//button[contains(@title, 'Fermer')]
    # ${is_present}=    Run Keyword And Return Status    Get Element States    ${boutonFermerOnglet}    contains    visible
    ${is_present}    Get Element Count    ${boutonFermerOnglet}
    # Click    ${boutonFermerOnglet}
    DEBUG - Screenshot
    WHILE    ${is_present}
        Click    ${boutonFermerOnglet} >> nth=0
        Sleep    2s
        DEBUG - Screenshot
        # ${is_present}=    Run Keyword And Return Status    Get Element States    ${boutonFermerOnglet}    contains    visible
        ${is_present}    Get Element Count    ${boutonFermerOnglet}
    END
    Sleep    5s

Creation Devis Light ${Nom_Compte} ${AccordCadre} ${Nom_Business} ${Nom_Contact} ${Nom_Opportunite} ${Categorie_Etablissement} ${Installation_Electrique} ${Categorie_Objet} ${Type_Objet}
    # Comment etape 2.1
    # Je clique sur "Lanceur d'application"
    # Comment etape 2.2
    # Je renseigne le champ "Recherchez des applications et des éléments..." avec la valeur CPQ Light
    # Je clique sur ${Bouton_Applications}
    # Sleep    10
    # Fermer tous les onglets
    # Comment etape 2.3
    # Je clique sur "Afficher le menu de navigation"
    # Sleep    2
    # Comment etape 2.4
    # Je clique sur ${ListeDeroulanteCPQLight}
    Comment etape 2.5
    Je renseigne la valeur "${Nom_Compte}" sous le champ "Nom du Compte :"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Compte}']] >> nth=0
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Comment 2.6
    Run Keyword If    '${AccordCadre}' != ''    Je clique sur //a[contains(text(),'${AccordCadre}')]/../../../../../..//input[@type='radio']/..
    Sleep    2
    Je clique sur "Suivant" >> nth=0
    Sleep    8
    Comment 2.7
    Je clique sur "Effacer la sélection" >> nth=0
    Sleep    2
    Je renseigne la valeur "${Nom_Business}" sous le champ "Centre Budgétaire"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Business}']] >> nth=0
    Je renseigne la valeur "${Nom_Contact}" sous le champ "Contact principal pour cette Opportunité"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Contact}']] >> nth=0
    Je clique sur "Suivant" >> nth=0
    Comment 2.8
    Je renseigne la valeur "${Nom_Opportunite}" sous le champ "Nom de l'Opportunité"
    Je sélectionne la valeur ${Categorie_Etablissement} dans la liste select[name=Etablishment_Category]
    Je sélectionne la valeur ${Installation_Electrique} dans la liste select[name=Electric_Meter]
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Comment 2.9
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Comment 2.10
    Je sélectionne la valeur ${Categorie_Objet} dans la liste (//select)[1]
    Je sélectionne la valeur ${Type_Objet} dans la liste (//select)[2]
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Comment 2.11
    Je clique sur "Suivant" >> nth=0
    Sleep    20
    Comment étape 2.12
    ${iframe} =     Get Attribute    (//iframe[@title='accessibility title'])[1]    name
    Log    ${iframe}
    # Run Keyword And Continue On Failure    Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0
    Sleep    2

Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    Je clique sur "Nouveau devis"
    Je clique sur //*[contains(@class, 'uiInput')][.//*[contains(text(), 'Envoyer le devis via Salesforce')]]//a
    Je clique sur //div[contains(@class, 'popup')]//a[contains(text(), 'Oui')]
    Je clique sur //*[contains(@class, 'uiInput')][.//*[contains(text(), 'Catégorie')]]//a
    Je clique sur //div[contains(@class, 'popup')]//a[contains(text(), '${Categorie_Etablissement}')]
    Je clique sur //*[contains(@class, 'uiInput')][.//*[contains(text(), 'Type')]]//a
    Je clique sur //div[contains(@class, 'popup')]//a[contains(text(), '${Type_ERP}')]
    Je clique sur //*[contains(@class, 'uiInput')][.//*[contains(text(), 'Installation Electrique')]]//a
    Je clique sur //div[contains(@class, 'popup')][contains(@class, 'visible')]//a[contains(text(), '${Installation_Electrique}')]
    Sleep    3
    Je clique sur //footer//button[.//*[contains(text(), 'Enregistrer')]]
    Sleep    10

Modification Devis ligne ${Produit} avec prix ${Prix}
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("${Produit}")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("${Produit}")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("${Produit}")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("${Produit}")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("${Produit}")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Keyboard Input    insertText    ${Prix}
    Keyboard Key    press    Enter
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("${Produit}")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    ### Naviguer vers Ajouter des prestations et Annuler pour remettre à zéro les boutons 'Modifications manuelles'
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> paper-button[id="plCancel"]
    Sleep    1
    ###

Je télécharge le document
    #Récupération du numéro de devis
    # ${dl_promise}    Promise To Wait For Download    ${CURDIR}
    ${NumeroDevis}=    Get Text    //h1//lightning-formatted-text
    #Téléchargement document
    Je clique sur //span[contains(@title,'${NumeroDevis}') and contains(@title,'.pdf')] 
    Je clique sur //button[@title='Télécharger']
    ${latest_downloaded_file}    Get Latest File    ${CURDIR}
    Move File    ${latest_downloaded_file}    ${CURDIR}/../data/document.pdf
    ${latest_pdf_file}    Get Latest Pdf File    ${CURDIR}/../data/
    Pdf Verification    ${latest_pdf_file}