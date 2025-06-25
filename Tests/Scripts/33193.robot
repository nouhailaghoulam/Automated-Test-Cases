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
${Nom_Business}    0797871      
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Prestation1}    EL-VP
${Prestation2}    OS-OPL
${Approbateur}    Ilham YASSINE
${Domaine}    Usine
${Statut}    Opportunité
${Origine_piste}    Appel entrant
${Ville}    Paris
${Adresse}    8 rue de la Comédie
${Cp}    75001
${Type_ERP}    Refuge de montagne
${PERC}    30
${Message}    Bonjour, ceci est un message
${Etendu_prestation}    Ceci est une prestation étendue


*** Test Cases ***
33193
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
    Sleep    3
    Comment etape 2.5
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
    Sleep    15
    Comment etape 2.11
    Run Keyword And Continue On Failure    Je verifie la presence de //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number[contains(text(), '5')] >> nth=0
    Run Keyword And Continue On Failure    Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//li[contains(@class, 'slds-is-current')]//*[contains(text(), 'Opportunité')]
    Comment etape 3
    Scroll To Element    "Opportunity Conclusion"
    Click    //button[@title='Modifier Durée du contrat (mois)']
    Sleep    1
    Je renseigne la valeur "12" sous le champ "Durée du contrat (mois)"
    Sleep    3
    Je clique sur //button[@name='SaveEdit']
    Sleep    10
    Comment etape 5.1
    ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    ##################################################
    Comment etape 5.4
    Sleep    5
    Je verifie la presence de //ul[@role='listbox']//span[contains(text(), 'Devis en préparation')]
    Run Keyword And Continue On Failure    Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    25\xa0%
    Comment etape 5.3
    Je clique sur //a[.//*[contains(text(), 'Devis CPQ')]]
    Sleep    15
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..
    # Je verifie la presence de //li[contains(@class, 'slds-is-current')]//span[contains(text(), 'Brouillon')]
    J'attends que l'élément //records-highlights-details-item//lightning-formatted-text[text()='Brouillon'] soit affiché
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    1/6 - Les Prestations et Prix doivent être complétés
    Comment etape 7
    Je clique sur "Modifier les lignes" >> nth=0
    Sleep    15
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}

    # BOUTON NON NECESSAIRE SELON LES USERS
    # Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0
    Comment etape 8
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
    Sleep    3
    Comment etape 9
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    ${Etendu_prestation}
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Je sélectionne la valeur Bureaux Services dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Nature d’établissement")) >> nth=0
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Bureaux")) >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> [name="Bureaux"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Bureaux"] >> [id="myinput"] >> nth=0    5
    Sleep    1s
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    10
    Comment etape 10
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
    Sleep    3
    Comment etape 11
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    ${Etendu_prestation}
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("UO (1UO = 1h)")) >> nth=0    2
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    15
    Comment etape 12
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("OS-OPL")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("OS-OPL")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("OS-OPL")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("OS-OPL")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("OS-OPL")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    2000
    Keyboard Key    press    Enter
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer") 
    Sleep    10
    Comment etape 23
    Je clique sur "Echéancier"
    Je clique sur "Modifier Afficher les échéanciers par prestation"
    Je clique sur //input[@type='checkbox' and @name='GLOBAL_ShowBillingSchedule__c']
    Je clique sur //button[@name='SaveEdit']
    Sleep    10
    Reload
    Je clique sur "Echéancier"
    Sleep    3
    Comment etape 23
    Je verifie la presence de //tr[th[@data-cell-value="A l'issue de l'intervention"] and td[@data-cell-value='0.5']]
    Sleep    2
    Comment etape 23
    scroll to Element    //tr[th[@data-cell-value='Lors de la 1ère facturation']]
    Je verifie la presence de //tr[th[@data-cell-value='Lors de la 1ère facturation'] and td[@data-cell-value='1']] 
    # Sleep    2
    Comment etape 23
    scroll to Element    //tr[th[@data-cell-value='A la commande']]   
    Je verifie la presence de //tr[th[@data-cell-value='A la commande'] and td[@data-cell-value='0.3']] 
    Je verifie la presence de //tr[th[@data-cell-value="A l'issue de l'intervention"] and td[@data-cell-value='0.5']]
    Je verifie la presence de //tr[th[@data-cell-value='A la remise du rapport'] and td[@data-cell-value='0.2']]
    

    
    
