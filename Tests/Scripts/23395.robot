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
${Nom_Business}    0797589      
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Domaine}    Publique
${Origine_piste}    Appel entrant
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Type_ERP}    Refuge de montagne
${Prestation1}    TB-LERES
${Type_Document}    Annexe Périmètre    
${FICHIER}    ${CURDIR}/../../Tests/Resources/ChargerDoc/
 
 
 
*** Test Cases ***
23395
    Comment    étape 1.1
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    Comment étape 2.1 - 2.4
    Fermer tous les onglets
    Je lance l'application ${Application} ${Navigation}
    Comment etape 2.3
    Je clique sur "${Nom_Compte}"
    Sleep    5
    Comment etape 2.4
    Je clique sur "Nouvelle Opportunité"
    Sleep    3
    Comment etape 2.5
    Je clique sur "Suivant"
    Sleep    5
    Comment etape 2.6
    Je renseigne la valeur "${Nom_Business}" sous le champ "Centre Budgétaire"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Business}']]
    Je renseigne la valeur "${Nom_Contact}" sous le champ "Contact principal pour cette Opportunité"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Contact}']]
    Je clique sur "Suivant" >> nth=0
    Comment etape 2.7
    Je clique sur "Suivant" >> nth=0
    Sleep    3
    Comment etape 2.8
    Je renseigne la valeur "${Nom_Opportunite}" sous le champ "Nom de l'Opportunité"
    Sleep    3
    Je renseigne la valeur "${Domaine}" sous le champ "Domaine d'intervention"
    Sleep    3
    Je sélectionne la valeur ${Origine_piste} dans la liste select[name=screen_OpptySource]
    Je clique sur "Suivant" >> nth=0
    Sleep    3
    Comment etape 2.10
    Je clique sur "Suivant" >> nth=0
    Sleep    3
    Comment etape 2.11
    # Run Keyword And Continue On Failure    Je verifie la presence de //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number[contains(text(), '5')] >> nth=0
    Comment etape 3.1 & 3.2
    #################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    #################################################    
    Comment etape 3.3
    Sleep    3
    Je clique sur "Devis CPQ (1)"
    Sleep    3
    Reload
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..
    Sleep    3
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    1/6 - Les Prestations et Prix doivent être complétés
    Comment etape 3.4
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
    Scroll To Element    "Opportunity Details"
    Run Keyword And Continue On Failure    Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    25\xa0%
    Sleep    3
    Scroll To Element    "Opportunity Information"
    Je clique sur "Devis CPQ (1)"
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..
    Sleep    3
    Comment etape 4
    Scroll To Element    "TVA, facturation et délai de paiement"
    Je clique sur "Modifier Cocher ici pour modifier le type TVA :"
    Je clique sur //input[@type='checkbox' and @name="Global_ChangeLocation__c"]
    Je clique sur //button[@name='SaveEdit']    
    Je clique sur "Modifier Type de TVA"
    Je clique sur //button[@type="button" and @aria-label="Type de TVA"]
    Je clique sur "Saint Martin (particuliers)"
    Je clique sur //button[@name='SaveEdit']
    Sleep    2
    Comment etape 5
    Scroll To Element    "Détails de l'offre"
    Je clique sur "Modifier les lignes"
    Sleep    15
    Comment etape 6
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}
    # BOUTON NON NECESSAIRE SELON LES USERS
    # Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation1}
    END
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div.option >> nth=0
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Sleep    3
    Comment etape 7
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> span:below(:text("Commentaire")) >> nth=0
    Sleep    2
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Test
    Je clique sur iframe[name="${iframe}"] >>> paper-button:not(#pcSave):has-text("Enregistrer")
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("UO (1UO = 1h)")) >> nth=0    2
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    3
    Comment etape 8
    Je clique sur iframe[name="${iframe}"] >>> "Continuer" >> nth=0
    Comment etape 9
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("TB-LERES")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("TB-LERES")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("TB-LERES")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("TB-LERES")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Keyboard Input    insertText    1000
    Keyboard Key    press    Enter
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    3
    Comment etape 10
    Je clique sur "Echéancier"
    Je clique sur "Modifier Afficher les échéanciers par prestation"
    Je clique sur //input[@type='checkbox' and @name='GLOBAL_ShowBillingSchedule__c']
    Je clique sur //button[@name='SaveEdit']
    Sleep    10
    Reload
    Je clique sur "Echéancier"
    Comment etape 11
    Je clique sur "Afficher les actions" >> nth=0
    Je clique sur //div[@class="slds-dropdown__item"][.//span[text()="Modifier"]]
    Comment etape 12
    Je clique sur //label[contains(text(),'échéance')]/following-sibling::div//button[@title='Effacer la sélection']
    Je renseigne la valeur "A la commande" sous le champ "Type d'échéance"
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = 'A la commande']] >> nth=0
    Sleep    10
    Je clique sur //button[@type='submit' and text()='Enregistrer']
    Comment etape 13
    Reload
    Comment etape 14
    Scroll To Element    "TVA, facturation et délai de paiement"
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1 Journée']/../../..//lightning-formatted-text    ==    EUR 900,00
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1/2 Journée']/../../..//lightning-formatted-text     ==    EUR 450,00
    Get Text    //span[@class='test-id__field-label' and text()='Minimum de facturation']/../../..//lightning-formatted-text     ==    EUR 200,00
    Sleep    2
    Comment etape 15
    Scroll To Element    "Détails de l'offre"
    Je clique sur "Générer un document"
    # Sleep    125
    # Je clique sur //button[@title="Fermer APXTConga4__Conga Composer"]
    # Comment etape 16
    # Reload
    # Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//div[@class='filerow']//span[contains(text(), '.pdf') and contains(@title, 'pdf')]
    # Comment etape 17