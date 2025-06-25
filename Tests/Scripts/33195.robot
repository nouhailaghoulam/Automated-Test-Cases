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
${Application}    Sales
${Navigation}    Comptes
${Nom_Compte}     BNP Paribas Fortis Film Finance
${Nom_Business}    0797524       
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Prestation}    EL-CONS
${Approbateur}    Ilham YASSINE
${Domaine}    Publique
${Statut}    Opportunité
${Origine_piste}    Appel entrant
${Ville}    Paris
${Adresse}    8 rue de la Comédie
${Cp}    75001
${Type_ERP}    Refuge de montagne
${PERC}    30
${Message}    Bonjour, ceci est un message
${Etendu_prestation}    Ceci est une prestation étendue
${AccordCadre}     test acn


*** Test Cases ***
33195
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    #################################################
    Je lance l'application ${Application} ${Navigation}
    ####################################################
    Comment etape 2.3
    Je clique sur "${Nom_Compte}"
    Sleep    5
    Comment etape 2.4
    Je clique sur "Nouvelle Opportunité"
    Sleep    5
    Comment etape 2.5
    Run Keyword If    '${AccordCadre}' != ''    Je clique sur //a[contains(text(),'${AccordCadre}')]/../../../../../..//input[@type='radio']/..
    Sleep    2
    Je clique sur "Suivant"
    Sleep    3
    Comment etape 2.6
    Je renseigne la valeur "${Nom_Business}" sous le champ "Centre Budgétaire"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Business}']]
    Je renseigne la valeur "${Nom_Contact}" sous le champ "Contact principal pour cette Opportunité"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Contact}']]
    Je clique sur "Suivant" >> nth=0
    # Si opportunité en attente
    Comment etape 2.7
    Je clique sur "Suivant" >> nth=0
    Sleep    3
    Comment etape 2.8
    Je renseigne la valeur "${Nom_Opportunite}" sous le champ "Nom de l'Opportunité"
    Sleep    3
    Je renseigne la valeur "${Domaine}" sous le champ "Domaine d'intervention"
    Sleep    3
    Je sélectionne la valeur ${Origine_piste} dans la liste select[name=screen_OpptySource]
    Get Text    xpath=//input[contains(@name, 'screen_Probability')]    ==    5
    Je clique sur "Suivant" >> nth=0
    Sleep    3
    Comment etape 2.10
    Je clique sur "Suivant" >> nth=0
    Sleep    10
    Comment etape 2.11
    Run Keyword And Continue On Failure    Je verifie la presence de //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number[contains(text(), '5')] >> nth=0
    Run Keyword And Continue On Failure    Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//li[contains(@class, 'slds-is-current')]//*[contains(text(), 'Opportunité')]
    Sleep    3
    Comment etape 5.1
    ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    ##################################################
    Comment etape 5.4
    Sleep    5
    Je verifie la presence de //ul[@role='listbox']//span[contains(text(), 'Devis en préparation')]
    Run Keyword And Continue On Failure    Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    25\xa0%
    Sleep    5
    Comment etape 5.3
    Je clique sur //a[.//*[contains(text(), 'Devis CPQ')]]
    Sleep    5
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..
    Comment etape 6
    Je clique sur "Modifier les lignes"
    Sleep    10
    Comment etape 7
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}
    # Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0
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
    Sleep    3
    Comment etape 8
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Sleep    15
    Je sélectionne la valeur Bureaux Services dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Nature d’établissement")) >> nth=0
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Superficie")) >> nth=0    
    Je clique sur iframe[name="${iframe}"] >>> [name="Superficie"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Superficie"] >> [id="myinput"] >> nth=0    5
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    10
    Comment etape 11
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("SE-FDOSS")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("SE-FDOSS")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("SE-FDOSS")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Keyboard Input    insertText    0
    Keyboard Key    press    Enter
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    10
    Je clique sur "Echéancier"
    Comment etape 14
    Je verifie la presence de //tr[th[@data-cell-value="A l'issue de l'intervention"] and td[@data-cell-value='1']]
    Sleep    3
