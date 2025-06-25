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
${Nom_Contact}    ilham yassine - ilham.yassine@cgi.com
${Nom_Opportunite}    Devis avenant
${Relation_Client}    Avenant
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Prestation1}    EL-VP
${Prestation2}    EL-1VP
${Domaine_Intervention}    Usine
${Origine_Piste}    Appel entrant
${Probabilite}    5000
${Type_Derp}    J Structure d'accueil personnes handicapées
${Etendu_prestation}    Ceci est une prestation étendue

*** Test Cases ***
23389P2
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Comment    etape 1.1
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    Comment    etape 1.2
    Je lance l'application ${Application} ${Navigation}
    ##################################################
    Comment    etape 2.1
    Je clique sur "${Nom_Compte}"
    Sleep    5
    Comment    etape 2.2
    Je clique sur ${BoutonNouvelleOpportunite}
    Sleep    1
    Comment    etape 2.3
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Sleep    1
    Comment    etape 2.4
    Je renseigne la valeur "${Nom_Business}" sous le champ "Centre Budgétaire"
    Sleep    1
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Business}']]
    Sleep    1
    Je renseigne la valeur "${Nom_Contact}" sous le champ "Contact principal pour cette Opportunité"
    Sleep    1
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Contact}']]
    Sleep    1
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Comment    etape 2.5
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Comment    etape 2.6
    Je renseigne la valeur "${Nom_Opportunite} " sous le champ "Nom de l'Opportunité"
    Je renseigne la valeur "${Domaine_Intervention} " sous le champ "Domaine d'intervention"
    Sleep    2
    Je clique sur //select[option[@value="PicklistOpptySource.Call In"]]
    Sleep    2
    Je sélectionne la valeur ${Origine_Piste} dans la liste select[name="screen_OpptySource"]
    Sleep    2
    Je sélectionne la valeur ${Relation_Client} dans la liste //*[contains(@class, 'field-element')]//*[name()='lightning-select'][.//*[contains(text(), "Avenant")]]//select
    Sleep    2
    Je clique sur (//button[@title='Effacer la sélection']//lightning-primitive-icon)[3]
    Sleep    2
    Je clique sur //*[contains(text(), "Opportunité initiale")]/..//input
    Sleep    1
    Je clique sur //*[contains(text(), "Opportunité initiale")]/..//*[contains(@class, 'slds-listbox_vertical')]/*[9]
    Sleep    2
    Comment    etape 2.7
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Sleep    2
    Comment    etape 2.8
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Sleep    30
    Comment    etape 2.9
    Run Keyword And Continue On Failure    Je verifie la presence de //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number[contains(text(), '5')] >> nth=0 
    Comment    etape 3.1
    Scroll To Element    "Opportunity Information"
    Je clique sur "Nouveau devis"
    Sleep    2
    Comment    etape 3.2
    Je clique sur //span[span[contains(text(), "Envoyer le devis via Salesforce ?")]]/following-sibling::div//a[@class="select"]  
    Je clique sur //a[@title="Oui"]
    Sleep    2
    Je clique sur //span[span[contains(text(), "Catégorie d'établissement")]]/following-sibling::div//a[@class="select"]  
    Je clique sur //a[@title="${Categorie_Etablissement}"]
    Sleep    2
    Je clique sur //span[span[contains(text(), "Type d'ERP")]]/following-sibling::div//a[@class="select"]  
    Je clique sur //a[@title="${Type_Derp}"]
    Sleep    2
    Je clique sur //span[span[contains(text(), "Installation Electrique")]]/following-sibling::div//a[@class="select"]  
    Je clique sur //div[@class='select-options']//ul[@class='scrollable']/li[last()]/a[@title='${Installation_Electrique}'] >> nth=1
    Je clique sur //footer[@class='slds-modal__footer']//button[contains(@class, 'slds-button_brand')]//span[text()='Enregistrer']
    ##################################################
    # Creation Devis ${Categorie_Etablissement} ${Type_Derp} ${Installation_Electrique}
    ##################################################
    Comment    etape 3.3
    Je clique sur //a[@data-navigation='enable' and contains(@href,'SBQQ__Quotes2__r/view')]
    Sleep    2
    Je clique sur //th[@data-label='Numéro du devis']//records-hoverable-link//a[@data-navigation='enable' and contains(@href,'/view')]
    Sleep    5
    J'attends que l'élément //records-highlights-details-item//lightning-formatted-text[text()='Brouillon'] soit affiché
    Sleep    2
    Comment    etape 3.4
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    1/6 - Les Prestations et Prix doivent être complétés
    Sleep    2
    Comment    etape 3.5
    Je clique sur //p[@title='Opportunité']/following-sibling::p//a
    Sleep    2
    J'attends que l'élément //span[text()='Devis en préparation'] soit affiché
    Run Keyword And Continue On Failure    Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    25\xa0%
    Je clique sur //li//a//span[contains(text(),'Q-')]
    Sleep    2
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
    Keyboard Key    press    Tab
    Sleep    1s
    Keyboard Key    press    Enter    #Pour cocher la case "Locaux sociaux"
    # Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Locaux sociaux")) >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> [name="Locaux sociaux"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Locaux sociaux"] >> [id="myinput"] >> nth=0    5
    
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    10
    Comment etape 7
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation2}
    END
    # Type Text    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']       ${Prestation}
    # Run Keyword And Ignore Error    Type Text    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits'] >> nth=0   ${Prestation}
    # Run Keyword And Ignore Error    Type Text    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits'] >> nth=1   ${Prestation}
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> [id="search"] >> nth=3
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Comment etape 8
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Je sélectionne la valeur Bureaux Services dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Nature d’établissement")) >> nth=0
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Locaux sociaux")) >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> [name="Locaux sociaux"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Locaux sociaux"] >> [id="myinput"] >> nth=0    5

    Sleep    1s
    Keyboard Key    press    Tab
    Sleep    1s
    Keyboard Key    press    Enter    #Pour cocher la case "Bureaux"
    # Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Bureaux")) >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> [name="Bureaux"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Bureaux"] >> [id="myinput"] >> nth=0    5

    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    10
    Comment etape 8
    Comment    etape 8
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
    Comment    etape 9
    Scroll To Element    "TVA, facturation et délai de paiement"
    Run Keyword And Continue On Failure    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1 Journée']/../../..//lightning-formatted-text    ==    EUR 900,00
    Run Keyword And Continue On Failure    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1/2 Journée']/../../..//lightning-formatted-text     ==    EUR 450,00
    Run Keyword And Continue On Failure    Get Text    //span[@class='test-id__field-label' and text()='Minimum de facturation']/../../..//lightning-formatted-text     ==    EUR 200,00
    Comment    etape 10
    # generer le doc
    ##########################################
    Sleep    20
    Comment    etape 11
    Je clique sur //button[contains(@title, 'Modifier Envoyer le devis via Salesforce ?')]
    Sleep    3
    Je clique sur //button[contains(@aria-label, 'Envoyer le devis via Salesforce ?')]
    Sleep    1
    Je clique sur //lightning-base-combobox-item[contains(@data-value, 'No')]
    Sleep    3
    Je clique sur //button[@name='SaveEdit']
    Sleep    5
    Comment    etape 12
    Je verifie la presence de //ul[@role='listbox']//a[@aria-selected="true"]//span[contains(text(), 'Brouillon')]
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    6/6 - Le Devis est prêt à être envoyé ou soumis pour approbation
    Sleep    3
    Comment    etape 13
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
    Sleep    2
    Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//li[contains(@class, 'slds-is-current')]//*[contains(text(), 'Devis en préparation')]
    Sleep    1
    Je clique sur //a[contains(@title, 'Q-')]
    Sleep    2
    Comment    etape 14
    Je clique sur //button[contains(text(), 'Passer au statut "émis"')]
    Sleep    2
    Je clique sur //footer//button/span[contains(text(), 'Enregistrer')]
    Sleep    5
    Comment    etape 15
    Je verifie la presence de //ul[@role='listbox']//a[@aria-selected="true"]//span[contains(text(), 'Émis')]
    # FAIRE VERIF DU MAIL RECU PAR LE CLIENT
    Comment    etape 16
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
    Sleep    2
    Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//li[contains(@class, 'slds-is-current')]//*[contains(text(), 'Devis émis')]
    Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    70\xa0%
    Sleep    1
