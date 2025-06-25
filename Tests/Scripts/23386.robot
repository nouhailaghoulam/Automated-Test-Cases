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
${Nom_Opportunite}    Devis accord cadre
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Prestation}    EL-1VP
${Type_Opportunite}    Accord Cadre - Direct
${Domaine_Intervention}    Usine
${Origine_Piste}    Appel entrant
${Type_Accord_Cadre}    Exclusif
${Business_garanti}    Garantie
${Pricing_Condition}    Référencement avec accord de prix
${Probabilite}    5000
${Type_Derp}    Refuge de montagne

*** Test Cases ***
23386
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    Je lance l'application ${Application} ${Navigation}
    ##################################################
    Comment etape 2.3
    Je clique sur "${Nom_Compte}"
    Sleep    5
    Comment etape 2.4
    Je clique sur ${BoutonNouvelleOpportunite}
    Sleep    1
    Comment etape 2.5
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Sleep    1
    Comment etape 2.6
    Je renseigne la valeur "${Nom_Business}" sous le champ "Centre Budgétaire"
    Sleep    1
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Business}']]
    Sleep    1
    Je renseigne la valeur "${Nom_Contact}" sous le champ "Contact principal pour cette Opportunité"
    Sleep    1
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Contact}']]
    Sleep    1
    Je clique sur //select[option[@value="ChoiceOpptyRecordType_Direct_Frame"]]
    Sleep    1
    Je sélectionne la valeur ${Type_Opportunite} dans la liste select[name=screenRecordType]
    Sleep    1
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Comment etape 2.7
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Comment etape 2.8
    Je renseigne la valeur "${Nom_Opportunite} " sous le champ "Nom de l'Opportunité"
    Je renseigne la valeur "${Domaine_Intervention} " sous le champ "Domaine d'intervention"
    Sleep    2
    Je clique sur //select[option[@value="PicklistOpptySource.Call In"]]
    Sleep    2
    Je sélectionne la valeur ${Origine_Piste} dans la liste select[name="screen_OpptySource"]
    Sleep    2
    Je clique sur //select[option[@value="picklistFAFrameworkType.Exclusive"]]
    Sleep    2
    Je sélectionne la valeur ${Type_Accord_Cadre} dans la liste select[name="screen_FAFramework_Type"]
    Sleep    2
    Je clique sur //select[option[@value="picklistFAGuaranteedBusiness.Guaranteed"]]
    Sleep    2
    Je sélectionne la valeur ${Business_garanti} dans la liste select[name="screen_FAGuaranteed_Business"]
    Sleep    2
    Je clique sur //select[option[@value="picklistFAPricingCondition.Framework agreement with pricing"]]
    Sleep    2
    Je sélectionne la valeur ${Pricing_Condition} dans la liste select[name="screen_FAPricing_Condition"]
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Sleep    2
    Comment etape 2.9
    Je renseigne la valeur "${Probabilite}" sous le champ "Montant Global"
    Sleep    2
    Comment etape 2.11
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Sleep    15
    Comment etape 2.12
    Scroll To Element    "Opportunity Details"
    Get Text     //span[@class='test-id__field-label' and text()='Étape']/../../..//lightning-formatted-text    ==    Opportunité
    Get Text     lightning-formatted-number:below(:text('Probabilité (%)')) >> nth=0    ==    5\xa0%
    Comment etape 3
    J'attends que l'élément //lightning-input[not(@checked)]//span[text()='Relance Auto'] soit affiché
    Comment etape 4
    J'attends que l'élément "Délai de Paiement" soit affiché
    Comment etape 5.1
    Scroll To Element    "Opportunity Information"
    ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_Derp} ${Installation_Electrique}
    ##################################################
    Comment etape 5.3
    Je clique sur //a[@data-navigation='enable' and contains(@href,'SBQQ__Quotes2__r/view')]
    Sleep    2
    Je clique sur //th[@data-label='Numéro du devis']//records-hoverable-link//a[@data-navigation='enable' and contains(@href,'/view')]
    Sleep    5
    J'attends que l'élément //records-highlights-details-item//lightning-formatted-text[text()='Brouillon'] soit affiché
    Sleep    2
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    1/6 - Les Prestations et Prix doivent être complétés
    Sleep    2
    Comment etape 5.4
    Je clique sur //p[@title='Opportunité']/following-sibling::p//a
    Sleep    2
    J'attends que l'élément //span[text()='Devis en préparation'] soit affiché
    Run Keyword And Continue On Failure    Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    25\xa0%
    Je clique sur //li//a//span[contains(text(),'Q-')]
    Sleep    2
    Comment etape 6
    Je clique sur "Modifier les lignes" >> nth=0
    Sleep    15
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}
    Comment etape 7
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation}
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
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    6
    
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
    Comment etape 9
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("SE-FDOSS")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("SE-FDOSS")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("SE-FDOSS")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Keyboard Input    insertText    0
    Keyboard Key    press    Enter
    Comment etape 10
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrement rapide")
    Sleep    30
    ${all_divs_Prix horaire moyen}=    Get Elements    iframe[name="${iframe}"] >>> sb-field-set-table-item.--desktop >> div:right-of(:text("Prix horaire moyen"))
    FOR    ${div}    IN    @{all_divs_Prix horaire moyen}
        ${prix_moyen}=    Get Text    ${div}
        Exit For Loop IF    '${prix_moyen}' != ''
    END 
    ${prix_moyen_float}    Convert To Number    ${prix_moyen.replace(",", ".")}
    Run Keyword If    ${prix_moyen_float} < 125    Log    "Le prix moyen (${prix_moyen_float}) est inférieur à 125."
    Run Keyword And Continue On Failure    Run Keyword If    ${prix_moyen_float} >= 125    Fail    "Le prix moyen (${prix_moyen_float}) est supérieur ou égal à 125."
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    10
    Comment etape 11
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    4/6 - Le Devis doit être généré
    Comment etape 12
    Scroll To Element    "TVA, facturation et délai de paiement"

    Je clique sur "Modifier Revision des prix"
    Sleep    1
    Je clique sur //*[contains(text(), 'Revision des prix')]/../..//input
    Sleep    1
    Je clique sur //button[@name='SaveEdit']
    Sleep    3

    Run Keyword And Continue On Failure    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1 Journée']/../../..//lightning-formatted-text    ==    EUR 900,00
    Run Keyword And Continue On Failure    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1/2 Journée']/../../..//lightning-formatted-text     ==    EUR 450,00
    Run Keyword And Continue On Failure    Get Text    //span[@class='test-id__field-label' and text()='Minimum de facturation']/../../..//lightning-formatted-text     ==    EUR 200,00
    Comment étape 13

    Je clique sur "Modifier Délai de paiement"
    Sleep    1
    Je clique sur //button[contains(@aria-label, 'Délai de paiement')]
    Sleep    1
    Je clique sur //*[contains(@data-value, 'A 45 jours, date de facture')]
    Sleep    1
    Je clique sur //button[@name='SaveEdit']
    Sleep    3

    Comment étape 14
    Je clique sur //p[@title='Opportunité']/following-sibling::p//a
    Sleep    2
    Get Text     //*[contains(@data-target-selection-name, 'Opportunity.Amount')]//lightning-formatted-text >> nth=0    ==    EUR 5 000,00
    Comment etape 15
    # Je clique sur "Générer un document"