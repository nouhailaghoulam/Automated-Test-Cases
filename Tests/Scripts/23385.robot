*** Settings ***
Library          Browser
Library          ${CURDIR}/../../Tests/Resources/keywords/checkPDF.py
Library          ${CURDIR}/../../Tests/Resources/keywords/SF_Connection.py
Resource         ${CURDIR}/../../Tests/Resources/env/users.resource
Resource         ${CURDIR}/../../Tests/Resources/env/env.resource
Resource         ${CURDIR}/../../Tests/Resources/or/OR.resource
Resource         ${CURDIR}/../../Tests/Resources/keywords/Methodes_Techniques.robot
Resource         ${CURDIR}/../../Tests/Resources/keywords/Methodes_Salesforce.robot
Test Teardown    Run Keyword If Test Failed    Take Screenshot    filename=EMBED    filename=EMBED

*** Variables ***
${Application}    CPQ Light
${Navigation}    CPQ Light
${Nom_Compte}     SOS OXYGENE NORMANDIE
${AccordCadre}     
${Nom_Business}    0797524       
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Prestation1}    EL-IN
${Prestation2}    EL-CONS
${Approbateur}    Ilham YASSINE

*** Test Cases ***
23385
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    Je lance l'application ${Application} ${Navigation}
    ####################################################
    Creation Devis Light ${Nom_Compte} ${AccordCadre} ${Nom_Business} ${Nom_Contact} ${Nom_Opportunite} ${Categorie_Etablissement} ${Installation_Electrique} ${Categorie_Objet} ${Type_Objet}
    ####################################################
    Sleep    2
    Comment étape 3
    # ${iframe} =     Get Attribute    (//iframe[@title='accessibility title'])[1]    name
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    # Type Text    iframe[name="${iframe}"] >>> input:above(:text("Libellé de prestation")) >> nth=0    ${Prestation1}
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation1}
    END
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> [id="search"] >> nth=3
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner et ajouter plus" >> nth=0
    Comment étape 4
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Je sélectionne la valeur Bureaux Services dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Nature d’établissement")) >> nth=0
    Je sélectionne la valeur Non renseigné dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Comptage électrique")) >> nth=0
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Bureaux")) >> nth=0    
    Je clique sur iframe[name="${iframe}"] >>> [name="Bureaux"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Bureaux"] >> [id="myinput"] >> nth=0    25000
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    10
    Comment étape 5
    Type Text    iframe[name="${iframe}"] >>> input:above(:text("Libellé de prestation")) >> nth=0    ${Prestation2}
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation2}
    END
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> [id="search"] >> nth=3
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Comment étape 6
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Sleep    15
    Je sélectionne la valeur Bureaux Services dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Nature d’établissement")) >> nth=0
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Superficie")) >> nth=0    
    Je clique sur iframe[name="${iframe}"] >>> [name="Superficie"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Superficie"] >> [id="myinput"] >> nth=0    250000
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Comment étape 7
    # cocher decocher et cocher modif manuelle pour calculer total visite
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Superficie")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> css=img#checkbox
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Superficie")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> css=img#checkbox
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Superficie")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> css=img#checkbox
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Superficie")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Superficie")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    # Type Text    iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Superficie")) >> css=input#myinput    100000
    Keyboard Input    insertText    350000
    Keyboard Key    press    Enter
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    15 
    Comment étape 8
    Je clique sur "Echéancier"
    Sleep    5
    Comment etape 9
    Je clique sur //span[contains(text(),'${Prestation1}')]/../../../../../../../../..//tbody//button[@aria-haspopup='true']
    Je clique sur "Modifier"
    Comment etape 10
    Je clique sur //label[contains(text(),'échéance')]/following-sibling::div//button[@title='Effacer la sélection']
    Je renseigne la valeur "A la commande" sous le champ "Type d'échéance"
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = 'A la commande']] >> nth=0
    Sleep    10
    Je clique sur //button[@type='submit' and text()='Enregistrer']
    Sleep    5
    Comment etape 11
    Je clique sur "Détails"
    Run Keyword And Continue On Failure    Get Text    lightning-formatted-text:below(:text('Etape')) >> nth=0    ==    3/6 - Sélectionnez un approbateur
    Comment etape 12-13
    # Run Keyword And Continue On Failure    Je clique sur "Modifier Approbateur"
    # Je renseigne la valeur "${Approbateur}" sous le champ "Approbateur"
    # Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Approbateur}']] >> nth=0
    Je clique sur "Modifier Approbateur"
    Sleep    1
    Je clique sur //input[@placeholder="Recherchez dans les Personnes..."]
    Sleep    1
    Je renseigne le champ "Approbateur" avec la valeur ${Approbateur}
    Je clique sur //lightning-base-combobox-formatted-text[contains(@title,"${Approbateur}")]
    Je clique sur //button[@name='SaveEdit' and text()='Enregistrer']
    Comment etape 14
    Je clique sur "Modifier les lignes" >> nth=0
    Comment etape 15
    ${iframe} =     Get Attribute    (//iframe[@title='accessibility title'])[1]    name
    ${Montant_SE-FDOSS_Initial}    Get Text    iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("SE-FDOSS")) >> xpath=following-sibling::div[contains(@field, "GLOBAL_NetTotalCustom__c")]/div[@class="r"]
    
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Montant client cible")) >> nth=0   20000
    Keyboard Key    press    Enter
    Get Text    iframe[name="${iframe}"] >>> input:right-of(:text("Montant client cible")) >> nth=0    ==    20 000,00
    Get Text    iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("SE-FDOSS")) >> xpath=following-sibling::div[contains(@field, "GLOBAL_NetTotalCustom__c")]/div[@class="r"]    ==    ${Montant_SE-FDOSS_Initial}
    Comment etape 16
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Annuler")
    Comment etape 17
    Je clique sur //p[@title='Opportunité']/following-sibling::p//a
    J'attends que l'élément //lightning-input[not(@checked)]//span[text()='Relance Auto'] soit affiché
    Comment etape 18
    Je clique sur "Fermer ${Nom_Opportunite} | Opportunité"
    Je clique sur "Générer un document"
    Sleep    5
    ${iframe} =     Get Attribute    (//iframe[@title='accessibility title'])[1]    name
    ${ErreurGenerationDocument}    Get Element Count    iframe[name="${iframe}"] >>> //div[contains(text(),'Désolé, une erreur')]