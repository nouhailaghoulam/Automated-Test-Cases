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
${Prestation1}    EL-VP
${Prestation2}    AMADEO
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


*** Test Cases ***
23384
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
    Sleep    10
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
    Comment etape 4
    Je clique sur //button[@title="Modifier Ville d'intervention"]
    Sleep    3
    Je renseigne la valeur "${Ville}" sous le champ "Ville d'intervention"
    Je renseigne la valeur "${Adresse}" sous le champ "Adresse d'intervention"
    Je renseigne la valeur "${Cp}" sous le champ "Cp intervention"
    Sleep    3
    Je clique sur //button[@name='SaveEdit']
    Sleep    10
    Comment etape 5.1
    ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    ##################################################
    Comment etape 5.4
    Je verifie la presence de //ul[@role='listbox']//span[contains(text(), 'Devis en préparation')]
    Run Keyword And Continue On Failure    Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    25\xa0%
    Comment etape 5.3
    Je clique sur //a[.//*[contains(text(), 'Devis CPQ')]]
    Sleep    10
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..
    # Je verifie la presence de //li[contains(@class, 'slds-is-current')]//span[contains(text(), 'Brouillon')]
    J'attends que l'élément //records-highlights-details-item//lightning-formatted-text[text()='Brouillon'] soit affiché
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    1/6 - Les Prestations et Prix doivent être complétés
    
    Comment etape 6
    Je clique sur //a[contains(text(), 'Paragraphe du contrat')]
    Sleep    5
    Je clique sur //div[contains(@class, 'windowViewMode-maximized')]//button[contains(@title, 'Modifier Précisions complémentaires')]
    Je renseigne le champ //div[@role='textbox'] avec la valeur ${Message}
    Upload File By Selector    //div[@aria-label='Précisions complémentaires']//input[@type='file']    ${CURDIR}/../../Tests/Resources/data/test.png
    Je clique sur //button[@name='SaveEdit']
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
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    6
    
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
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("UO (1UO = 1h)")) >> nth=0    1
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    15
    Comment etape 12
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrement rapide")
    Sleep    10
    
    ${all_divs_Prix horaire moyen}=    Get Elements    iframe[name="${iframe}"] >>> sb-field-set-table-item.--desktop >> div:right-of(:text("Prix horaire moyen"))
    FOR    ${div}    IN    @{all_divs_Prix horaire moyen}
        ${prix_moyen}=    Get Text    ${div}
        Exit For Loop IF    '${prix_moyen}' != ''
    END 
    ${prix_moyen_float}    Convert To Number    ${prix_moyen.replace(",", ".")}
    Run Keyword If    ${prix_moyen_float} < 125    Log    "Le prix moyen (${prix_moyen_float}) est inférieur à 125."
    Run Keyword And Continue On Failure    Run Keyword If    ${prix_moyen_float} >= 125    Fail    "Le prix moyen (${prix_moyen_float}) est supérieur ou égal à 125."
    Sleep    5

    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    15
    Comment etape 13
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    3/6 - Sélectionnez un approbateur
    Comment etape 14
    Je clique sur "Echéancier"
    Je verifie la presence de //span[contains(text(), 'AMADEO')]/ancestor::article[2]//table[@data-num-rows='1']

    Comment etape 15
    Je clique sur "Modifier les lignes" >> nth=0
    Sleep    10
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Comment etape 16
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("SE-FDOSS")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("SE-FDOSS")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("SE-FDOSS")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Keyboard Input    insertText    0
    Keyboard Key    press    Enter
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    3
    Comment etape 17
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Sleep    3

    Je clique sur iframe[name="${iframe}"] >>> button[tooltip="Reconfigurer la ligne"] >> nth=0
    Sleep    5
    Comment etape 18
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0

    Sleep    10
    Comment etape 19
    Je clique sur iframe[name="${iframe}"] >>> button[tooltip="Reconfigurer la ligne"] >> nth=1
    Sleep    5
    Comment etape 20
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("UO (1UO = 1h)")) >> nth=0    10
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    10
    Comment etape 21
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("AMADEO")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"] >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("AMADEO")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("AMADEO")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    3500
    Keyboard Key    press    Enter
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep       10

    Comment etape 22
    Run Keyword And Continue On Failure    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    4/6 - Le Devis doit être généré
    Comment etape 23
    Je clique sur "Echéancier"
    Je clique sur "Modifier Afficher les échéanciers par prestation"
    Je clique sur //input[@type='checkbox' and @name='GLOBAL_ShowBillingSchedule__c']
    Je clique sur //button[@name='SaveEdit']
    Sleep    10
    Reload
    Je clique sur "Echéancier"
    Run Keyword And Continue On Failure    Je verifie la presence de //span[contains(text(), 'AMADEO')]/ancestor::article[2]//table//*[contains(text(), 'A la commande')]
    Run Keyword And Continue On Failure    Je verifie la presence de //span[contains(text(), 'AMADEO')]/ancestor::article[2]//table//*[contains(text(), 'A la remise du rapport')]
    Sleep    3

    Comment etape 24
    Je clique sur "Modifier les lignes" >> nth=0
    Sleep    10
    Comment etape 25
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    ${Montant_SE-FDOSS_Initial}    Get Text    iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("SE-FDOSS")) >> xpath=following-sibling::div[contains(@field, "GLOBAL_NetTotalCustom__c")]/div[@class="r"]
    
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Montant client cible")) >> nth=0   10000
    Keyboard Key    press    Enter
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Calculer")
    Sleep    1
    Get Text    iframe[name="${iframe}"] >>> div:right-of(:text("Total du devis")) >> nth=1    ==    10 000,00 EUR
    Get Text    iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("SE-FDOSS")) >> xpath=following-sibling::div[contains(@field, "GLOBAL_NetTotalCustom__c")]/div[@class="r"]    ==    ${Montant_SE-FDOSS_Initial}

    Comment etape 26
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Annuler")

    Comment etape 27
    # Je clique sur "Détails"
    ${allOngletsDetails}=    Get Elements    //li[@title='Détails']
    FOR    ${OngletDetails}    IN    @{allOngletsDetails}
        Run Keyword And Ignore Error    Je clique sur ${OngletDetails}
    END
    Scroll To Element    "TVA, facturation et délai de paiement"
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1 Journée']/../../..//lightning-formatted-text    ==    EUR 900,00
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1/2 Journée']/../../..//lightning-formatted-text     ==    EUR 450,00
    Get Text    //span[@class='test-id__field-label' and text()='Minimum de facturation']/../../..//lightning-formatted-text     ==    EUR 200,00


    ##########################################
    Sleep    20
    Je clique sur //button[contains(@title, 'Modifier Envoyer le devis via Salesforce ?')]
    Sleep    3
    Je clique sur //button[contains(@aria-label, 'Envoyer le devis via Salesforce ?')]
    Sleep    1
    Je clique sur //lightning-base-combobox-item[contains(@data-value, 'No')]
    Sleep    3
    Je clique sur //button[@name='SaveEdit']
    Sleep    5
    Comment etape 31
    Je verifie la presence de //ul[@role='listbox']//a[@aria-selected="true"]//span[contains(text(), 'Brouillon')]
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    6/6 - Le Devis est prêt à être envoyé ou soumis pour approbation
    Sleep    3
    Comment etape 32
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
    Sleep    2
    Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//li[contains(@class, 'slds-is-current')]//*[contains(text(), 'Devis en préparation')]
    Sleep    1
    Je clique sur //a[contains(@title, 'Q-')]
    Sleep    2
    Je clique sur //button[contains(text(), 'Passer au statut "émis"')]
    Sleep    2
    Je clique sur //footer//button/span[contains(text(), 'Enregistrer')]
    Sleep    5
    Je verifie la presence de //ul[@role='listbox']//a[@aria-selected="true"]//span[contains(text(), 'Émis')]
    # FAIRE VERIF DU MAIL RECU PAR LE CLIENT
    Comment etape 34
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
    Sleep    2
    Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//li[contains(@class, 'slds-is-current')]//*[contains(text(), 'Devis émis')]
    # Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    70\xa0%
    Get Text     (//lightning-formatted-number[text()='70 %'])[1]
    Sleep    1
    Je clique sur //a[contains(@title, 'Q-')]
    Sleep    2
    Comment etape 35
    Je clique sur //li[contains(@data-name, 'In Review')]//a
    Sleep    1
    Je clique sur //button[./span[contains(text(), 'Marquer Statut en cours')]]
    Sleep    3
    Comment etape 36
    Je clique sur "Modifier les lignes" >> nth=0
    Comment etape 37
    Sleep    5
    ${iframe} =     Get Attribute    (//iframe[@title='accessibility title'])[1]    name
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Bureaux")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Bureaux")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Bureaux")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    300
    Keyboard Key    press    Enter
    Sleep    3

    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    20

    # Comment etape 38
    # Run Keyword And Continue On Failure    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    4/6 - Le Devis doit être généré