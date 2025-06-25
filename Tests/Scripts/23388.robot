*** Settings ***
Library          Browser
# Library          ${CURDIR}/../../Tests/Resources/keywords/checkPDF.py
Library          ${CURDIR}/../../Tests/Resources/keywords/SF_Connection.py
Resource         ${CURDIR}/../../Tests/Resources/env/users.resource
Resource         ${CURDIR}/../../Tests/Resources/env/env.resource
Resource         ${CURDIR}/../../Tests/Resources/or/OR.resource
Resource         ${CURDIR}/../../Tests/Resources/keywords/Methodes_Techniques.robot
Resource         ${CURDIR}/../../Tests/Resources/keywords/Methodes_Salesforce.robot
Test Teardown    Run Keyword If Test Failed    Take Screenshot    filename=EMBED    filename=EMBED

*** Variables ***
${Application}    Sales
${Navigation}    Devis
${NumDevis}    Q-1830092
${Nom_Business}    0421630
${New_Nom_Business}    0421554
${NewPerson}    Daisy TRIAIRE     
${Nom_Opportunite}    NewOpName
${Prestation1}    AMO-AC
${Prestation2}    DRONE-BT
${Prestation3}    GP-PSE
${Etendu_prestation}    Ceci est une prestation étendue
${Accord_cadre}    ACN avec ref du bon de commande


*** Test Cases ***
23388
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Ilham}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    #######################################################################
    Comment etape 2 et 3
    Je lance l'application ${Application} ${Navigation}
    Comment etape 4
    Je renseigne le champ //input[@placeholder='Recherchez dans cette liste...'] avec la valeur ${NumDevis}
    Keyboard Key    press    Enter
    Je clique sur //a[contains(@title,'${NumDevis}')]
    Sleep    3
    Comment etape 5
    Je clique sur //button[contains(@class,'slds-button slds-button_icon-border-filled')]//lightning-primitive-icon
    Je clique sur //span[text()='Dupliquer le Devis']
    Sleep    15
    Comment etape 6
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    15
    Comment etape 7
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    10
    Comment etape 8
    Je clique sur //label[contains(text(), "Centre Budgetaire")]/..//button[@title='Effacer la sélection']
    Sleep    1
    Je renseigne la valeur "${Nom_Business}" sous le champ "Centre Budgétaire"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Business}']]
    Sleep    2
    Comment etape 9
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Comment etape 11
    Je renseigne la valeur "${Nom_Opportunite}" sous le champ "Nom de l'Opportunité"
    Je clique sur //label[contains(text(), "Propriétaire de l'Opportunité")]/..//button[@title='Effacer la sélection']
    Je renseigne la valeur "${NewPerson}" sous le champ "Propriétaire de l'Opportunité"
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${NewPerson}']]

    Je clique sur //label[contains(text(), "Apporteur d'affaire")]/..//button[@title='Effacer la sélection']
    Je renseigne la valeur "${NewPerson}" sous le champ "Apporteur d'affaire"
    Je clique sur (//lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[contains(@title, '${NewPerson}')]])[2]

    Je clique sur //label[contains(text(), "Attributaire de la relance")]/..//button[@title='Effacer la sélection']
    Je renseigne la valeur "${NewPerson}" sous le champ "Attributaire de la relance"
    Je clique sur (//lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[contains(@title, '${NewPerson}')]])[3]
    Sleep    2
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]

    Sleep    5
    Comment etape 12
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]

    Sleep    5
    Comment etape 13
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    5
    Je verifie la presence de //span[contains(text(),"n'est pas active et/ou") and contains(text(),"accessible") and contains(text(),"du CB sélectionné et ne sera pas dupliquée dans ce devis")]   
    Comment etape 14
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    5
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Je verifie la presence de //span[contains(text(),"Merci de cliquer sur") and contains(text(),"Suivant") and contains(text(),"afin d'être redirigé vers les lignes de devis.")]   
    Comment etape 15
    Sleep    5
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep   20

    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}
    Je clique sur //li[.//*[contains(text(), 'Q-1830092')]]//button[contains(@title, 'Fermer')]
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> button[tooltip="Supprimer la ligne"]
    Sleep    3
    # BOUTON NON NECESSAIRE SELON LES USERS (A VERIFIER AVEC USER ROBOT)
    Comment etape 16
    Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0

    Comment etape 17
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
    Comment etape 18
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    ${Etendu_prestation}
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1

    Comment etape 19
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("UO (1UO = 1h)")) >> nth=0    2
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    7
    # Verifier si le bouton est tout le temps présent
    Je clique sur iframe[name="${iframe}"] >>> "Continuer" >> nth=0

    Sleep    15
    Comment etape 20
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation2}
    END
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> [id="search"] >> nth=3
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner et ajouter plus" >> nth=0
    Sleep    3
    Comment etape 21
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    ${Etendu_prestation}
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Comment etape 22
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("UO (1UO = 1h)")) >> nth=0    2
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    
    Sleep    20
    Comment etape 23
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation3}
    END
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> [id="search"] >> nth=3
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Sleep    3
    Comment etape 25
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    ${Etendu_prestation}
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1 
    Comment etape 26
    # pourquoi deux fois enregistrer sur scénario azure
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("UO (1UO = 1h)")) >> nth=0    2
    Comment etape 27
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    
    Sleep    10
    Comment etape 28
    # cocher decocher et cocher modif manuelle pour calculer total visite
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("DRONE-BT")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("DRONE-BT")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("DRONE-BT")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("DRONE-BT")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("DRONE-BT")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    100
    Keyboard Key    press    Enter
    Sleep    3
    
    Comment etape 29
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrement rapide")
    Sleep    10
    
    ${all_divs_Prix horaire moyen}=    Get Elements    iframe[name="${iframe}"] >>> sb-field-set-table-item.--desktop >> div:right-of(:text("Prix horaire moyen"))
    FOR    ${div}    IN    @{all_divs_Prix horaire moyen}
        ${prix_moyen}=    Get Text    ${div}
        Exit For Loop IF    '${prix_moyen}' != ''
    END 
    ${prix_moyen_float}    Convert To Number    ${prix_moyen.replace(",", ".")}
    Run Keyword If    ${prix_moyen_float} < 135    Log    "Le prix moyen (${prix_moyen_float}) est inférieur à 135."
    Run Keyword And Continue On Failure    Run Keyword If    ${prix_moyen_float} >= 135    Fail    "Le prix moyen (${prix_moyen_float}) est supérieur ou égal à 135."
    Sleep    5

    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    15

    Comment etape 30
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    3/6 - Sélectionnez un approbateur
    Sleep    3

    Comment etape 31
    Je clique sur "Modifier les lignes" >> nth=0
    Sleep    20
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name

    Comment etape 32
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("DRONE-BT")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    15

    Comment etape 33
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    4/6 - Le Devis doit être généré
    Sleep    2

    Comment etape 34
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
    Sleep    5
    Je clique sur //button[contains(@title, 'Modifier Accord cadre')]
    Sleep    3
    Je renseigne la valeur "${Accord_cadre}" sous le champ "Accord cadre"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Accord_cadre}']]
    Sleep    2
    Je clique sur //button[@name='SaveEdit']
    Sleep    10
    Comment etape 35
    Je clique sur //button[contains(@title, 'Fermer ${Nom_Opportunite}')]
    Sleep    10
    ${allOngletsDetails}=    Get Elements    //li[@title='Détails']
    FOR    ${OngletDetails}    IN    @{allOngletsDetails}
        Run Keyword And Ignore Error    Je clique sur ${OngletDetails}
    END
    Scroll To Element    "TVA, facturation et délai de paiement"
    Get Text    //lightning-formatted-text[text()='EUR 1 100,00']
    Get Text    //lightning-formatted-text[text()='EUR 600,00']
    Get Text    //span[@class='test-id__field-label' and text()='Minimum de facturation']/../../..//lightning-formatted-text     ==    EUR 200,00

    Comment etape 36
    Get Text    //span[@class='test-id__field-label' and text()='Délai de paiement']/../../..//lightning-formatted-text     ==    Selon les modalités définies dans l'accord cadre
    Sleep    5
    # Je clique sur "Générer un document"

    ####################################
    #CONTOURNEMENT + ETAPES APRES GENERATION
    Scroll To Element    "Détails de l'offre"
    Sleep    1
    Je clique sur //button[contains(@title, 'Modifier Envoyer le devis via Salesforce ?')]
    Sleep    3
    Je clique sur //button[contains(@aria-label, 'Envoyer le devis via Salesforce ?')]
    Sleep    1
    Je clique sur //lightning-base-combobox-item[contains(@data-value, 'No')]
    Sleep    2
    Je clique sur //button[@name='SaveEdit']
    Sleep    5

    Comment etape 39
    Je clique sur //button[contains(text(), 'Passer au statut "émis"')]
    Sleep    2
    Je clique sur //footer//button/span[contains(text(), 'Enregistrer')]
    Sleep    5
    Je verifie la presence de //ul[@role='listbox']//a[@aria-selected="true"]//span[contains(text(), 'Émis')]

    Comment etape 40
    Sleep    5
    Je clique sur //li[contains(@data-name, 'Contract adjustment')]//a
    Sleep    1
    Je clique sur //button[./span[contains(text(), 'Marquer Statut en cours')]]
    Sleep    3

    Comment etape 41
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
    Sleep    2
    Scroll To Element    "Contracting Office"
    Sleep    1
    Je clique sur "Modifier Libellé du Centre Budgétaire"
    Sleep    2
    Je clique sur //label[contains(text(), "Libellé du Centre Budgétaire")]/..//button[@title='Effacer la sélection']
    Sleep    1
    Je renseigne la valeur "${New_Nom_Business}" sous le champ "Libellé du Centre Budgétaire"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${New_Nom_Business}']]
    Sleep    1
    Je clique sur //button[@name='SaveEdit']

