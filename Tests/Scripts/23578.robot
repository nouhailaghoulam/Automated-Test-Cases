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
${Nom_Compte}    SOS OXYGENE NORMANDIE
${Relation_Client}    Avenant 
${Description_Operation}    test
${Duree_Du_Chantier}    6 
${Montant_Des_Travaux}    1500
${Destination_Ouvrage}    Structure provisoire et démontable
${VRD}    VRD inclus 
${Type_travaux}    Travaux neufs  
${Categorie_Operation}    1
${Stade_Avancement}    Conception  
${Nom_Business}    0796004       
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Prestation}    CSPSBAT


*** Test Cases ***
23578
    Comment    étape 1.1
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    Comment étape 2.2 - 2.4
    Je lance l'application ${Application} ${Navigation}

    Je renseigne la valeur "${Nom_Compte}" sous le champ "Nom du Compte :"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Compte}']] >> nth=0
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Je clique sur "Effacer la sélection" >> nth=0
    Sleep    2
    Je renseigne la valeur "${Nom_Business}" sous le champ "Centre Budgétaire"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Business}']] >> nth=0
    Je renseigne la valeur "${Nom_Contact}" sous le champ "Contact principal pour cette Opportunité"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Contact}']] >> nth=0
    Sleep    2
    Je clique sur "Suivant" >> nth=0
    Je renseigne la valeur "${Nom_Opportunite}" sous le champ "Nom de l'Opportunité"
    Je sélectionne la valeur ${Relation_Client} dans la liste //*[contains(@class, 'field-element')]//*[name()='lightning-select'][.//*[contains(text(), "Avenant")]]//select
    Sleep    2
    Je clique sur //*[contains(text(), "Opportunité initiale")]/..//input
    Sleep    1
    Je clique sur //*[contains(text(), "Opportunité initiale")]/..//*[contains(@class, 'slds-listbox_vertical')]/*[2]
    Sleep    2
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Je clique sur //label[contains(@class, 'slds-radio')][.//*[contains(text(), 'Une prestation Contrôle Technique')]]
    Je renseigne la valeur "${Description_Operation}" sous le champ "Désignation de l'opération"
    Sleep    2
    Je renseigne la valeur "${Montant_Des_Travaux}" sous le champ "Montant des travaux (en euros)"
    Je renseigne la valeur "${Duree_Du_Chantier}" sous le champ "Durée du chantier (en mois)"
    Je sélectionne la valeur ${Destination_Ouvrage} dans la liste select[name="Facility_Type"]
    Je sélectionne la valeur ${VRD} dans la liste select[name="Screen_VRD"]
    Sleep    1
    Je sélectionne la valeur ${Type_travaux} dans la liste select[name="Work_Type"]
    Sleep    1
    Je sélectionne la valeur ${Stade_Avancement} dans la liste select[name="WorkProgress"]
    Sleep    1
    # Je sélectionne la valeur ${Categorie_Operation} dans la liste select[name="screen_OperationCategory"]
    Sleep    2
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Je sélectionne la valeur ${Categorie_Objet} dans la liste (//select)[1]
    Je sélectionne la valeur ${Type_Objet} dans la liste (//select)[2]
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Je clique sur "Suivant" >> nth=0
    Sleep    20
    ${iframe} =     Get Attribute    (//iframe[@title='accessibility title'])[1]    name
    # Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0
    Comment étape 3
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
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("CSPBIM")) >> nth=0
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> sb-actions:left-of(:text("CSPBIM")) >> nth=0
    Sleep    5
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    5
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> "Continuer" >> nth=0
    Sleep    10

    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("CSPBIM 1")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("CSPBIM 1")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    100
    Keyboard Key    press    Enter
    Sleep    3

    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Allongement de la durée des travaux")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Allongement de la durée des travaux")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Allongement de la durée des travaux")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    10
    Keyboard Key    press    Enter
    Sleep    3

    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Allongement de la durée des travaux")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]

    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"] >> nth=1
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    0
    Keyboard Key    press    Enter
    Sleep    3

    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    20
    Je clique sur "Modifier les lignes" >> nth=0
    Sleep    15
    ${iframe} =     Get Attribute    (//iframe[@title='accessibility title'])[1]    name
    ${Montant_SE-FDOSS_Initial}    Get Text    iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@field, "SBQQ__NetTotal__c")]/div[@class="r"]
    
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Montant client cible")) >> nth=0   10000
    Keyboard Key    press    Enter
    Get Text    iframe[name="${iframe}"] >>> input:right-of(:text("Montant client cible")) >> nth=0    ==    10 000,00
    Get Text    iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@field, "SBQQ__NetTotal__c")]/div[@class="r"]    ==    ${Montant_SE-FDOSS_Initial}
    Comment etape 16
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Annuler")
    Sleep    20
    # ${allOngletsDetails}=    Get Elements    //li[@title='Détails']
    # FOR    ${OngletDetails}    IN    @{allOngletsDetails}
    #     Run Keyword And Ignore Error    Je clique sur ${OngletDetails}
    # END
    
    Scroll To Element    "TVA, facturation et délai de paiement"    
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1 Journée']/../../..//lightning-formatted-text    ==    EUR 1 200,00
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1/2 Journée']/../../..//lightning-formatted-text     ==    EUR 700,00


    Comment etape 14
    # Je clique sur "Générer un document"
