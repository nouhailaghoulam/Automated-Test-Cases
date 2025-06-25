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
${Nom_Compte}     BNP Paribas Fortis Film Finance
${AccordCadre}     test acn
${Nom_Business}    0797524       
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Prestation}    TB-CH-VP
${Approbateur}    Ilham YASSINE

*** Test Cases ***
23387
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    Je lance l'application ${Application} ${Navigation}
    ####################################################
    # Creation Devis Light ${Nom_Compte} ${AccordCadre} ${Nom_Business} ${Nom_Contact} ${Nom_Opportunite} ${Categorie_Etablissement} ${Installation_Electrique} ${Categorie_Objet} ${Type_Objet}
    # ####################################################
    # Sleep    2
    Comment etape 2.5
    Je renseigne la valeur "${Nom_Compte}" sous le champ "Nom du Compte :"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Compte}']] >> nth=0
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    # Je clique sur "Suivant" >> nth=0
    # Sleep    2
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
    Comment étape 3
    # ${iframe} =     Get Attribute    (//iframe[@title='accessibility title'])[1]    name
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    # Type Text    iframe[name="${iframe}"] >>> input:above(:text("Libellé de prestation")) >> nth=0    ${Prestation}
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation}
    END
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> [id="search"] >> nth=3
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Comment étape 4
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Chaufferie avec chaudière(s) à combustion (Gaz/Fuel/Bois…)")) >> nth=0    
    Je clique sur iframe[name="${iframe}"] >>> [name="Chaufferie avec chaudière(s) à combustion (Gaz/Fuel/Bois…)"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Chaufferie avec chaudière(s) à combustion (Gaz/Fuel/Bois…)"] >> [id="myinput"] >> nth=0    1
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    15
    Comment étape 5
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrement rapide" >> nth=0
    Comment étape 6
    Je clique sur iframe[name="${iframe}"] >>> div:right-of([field="GLOBAL_NetTotalCustom__c"]) >> nth=3 
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> img#checkbox
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ListPrice__c"]:has(:text("35,00 EUR"))
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ListPrice__c"]:has(:text("35,00 EUR"))
    Keyboard Input    insertText    0
    Keyboard Key    press    Enter
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Comment étape 7
    Run Keyword And Continue On Failure    Get Text    lightning-formatted-text:below(:text('Etape')) >> nth=0    ==    4/6 - Le Devis doit être généré
    Comment étape 9
    Scroll To Element    "TVA, facturation et délai de paiement"
    Run Keyword And Continue On Failure    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1 Journée']/../../..//lightning-formatted-text    ==    EUR 900,00
    Run Keyword And Continue On Failure    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1/2 Journée']/../../..//lightning-formatted-text     ==    EUR 450,00
    Run Keyword And Continue On Failure    Get Text    //span[@class='test-id__field-label' and text()='Minimum de facturation']/../../..//lightning-formatted-text     ==    EUR 200,00
    Comment étape 10
    Run Keyword And Continue On Failure    Get Text    //span[@class="test-id__field-label" and text()='Délai de paiement']/../../..//lightning-formatted-text     ==    à 45 jours, date de facture
    Comment étape 11
    Scroll To Element    "Détails de l'offre"
   