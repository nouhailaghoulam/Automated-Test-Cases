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
${Description_Operation}    test
${Duree_Du_Chantier}    6
${Montant_Des_Travaux}    2100
${Stade_Avancement}    Conception  
${Centre_Budget}    0796004        
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Categorie_Operation}    1
${Domaine_Intervention}    Usine  
${Type_travaux}    Travaux neufs    
${Origine_Piste}    Appel entrant    
${Categorie_Etablissement}    Habitation
${Type_ERP}    REF Refuge de montagne
${Installation_Electrique}    Non renseigné
${SourcePrincipale}    F&A - FR BVC - Challenge BV à la carte
${Prestation}    CC-BIMBA
${Message}    Bonjour, ceci est un message
 
*** Test Cases ***
BV_23582
    Comment    étape 1.1
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    ####################################################
    Je lance l'application ${Application} ${Navigation}
    ####################################################
    Comment étape 2.3
    Je clique sur "${Nom_Compte}"
    Comment étape 2.4
    Je clique sur "Nouvelle Opportunité"
    Comment étape 2.5
    Je clique sur "Suivant"
    Sleep    2
    Comment étape 2.6
    Je renseigne la valeur "${Centre_Budget}" sous le champ "Centre Budgétaire"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Centre_Budget}']]
    Je renseigne la valeur "${Nom_Contact}" sous le champ "Contact principal pour cette Opportunité"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Contact}']]
    Sleep    2
    Comment etape 2.7
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Comment etape 2.8
    Je renseigne la valeur "${Nom_Opportunite}" sous le champ "Nom de l'Opportunité"
    Je renseigne la valeur "${Domaine_Intervention}" sous le champ "Domaine d'intervention"
    Je sélectionne la valeur ${Origine_Piste} dans la liste select[name="screen_OpptySource"]
 
    Je clique sur //button[@class="slds-button slds-button_brand"]
    Sleep    10
    Comment etape 2.9
    Je clique sur "Une prestation Contrôle Technique"
    Comment etape 2.10
    Je renseigne la valeur "${Description_Operation}" sous le champ "Description de l'opération"
    Sleep    2
    Je renseigne la valeur "${Montant_Des_Travaux}" sous le champ "Montant des travaux (en euros)"
    Sleep    2
    Je sélectionne la valeur ${Type_travaux} dans la liste select[name="screen_WorkType"]
    Sleep    1
    Je sélectionne la valeur ${Stade_Avancement} dans la liste select[name="screen_WorkProgress"]
    Sleep    1
    Je sélectionne la valeur ${Categorie_Operation} dans la liste select[name="screen_OperationCategory"]
    Sleep    2
    Comment etape 2.12
    Je clique sur "Suivant"
    Je clique sur "Suivant"
    Sleep    2
    Comment etape 2.13
    Run Keyword And Continue On Failure    Je verifie la presence de //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number[contains(text(), '5')] >> nth=0
    Run Keyword And Continue On Failure    Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//li[contains(@class, 'slds-is-current')]//*[contains(text(), 'Opportunité')]
    Sleep    2
    Comment etape 4.1
    Scroll To Element    "Opportunity Information"    
    ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    ##################################################
    Je clique sur "Devis CPQ (1)"
    Sleep    8
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..    
    Comment etape 4.3
    Sleep    8
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    1/6 - Les Prestations et Prix doivent être complétés
    Comment etape 4.4
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
    Scroll To Element    "Opportunity Details"    
    Run Keyword And Continue On Failure    Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    25\xa0%   
    Comment etape 5
    Scroll To Element    "Opportunity Information"
    Sleep    2
    Je clique sur "Devis CPQ (1)"
    Sleep    2
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/.. 
    Sleep    5
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
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    5
    Comment etape 11
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("CC-BIM 1")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("CC-BIM 1")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("CC-BIM 1")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    1000
    Keyboard Key    press    Enter
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    10
    Comment etape 12
    Je clique sur //button[contains(@title, 'Modifier Envoyer le devis via Salesforce ?')]
    Sleep    3
    Je clique sur //button[contains(@aria-label, 'Envoyer le devis via Salesforce ?')]
    Sleep    1
    Je clique sur //lightning-base-combobox-item[contains(@data-value, 'No')]
    Sleep    4
    Je clique sur //button[@name='SaveEdit']
    Sleep    5
    Comment etape 31
    Je verifie la presence de //ul[@role='listbox']//a[@aria-selected="true"]//span[contains(text(), 'Brouillon')]
    # Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    6/6 - Le Devis est prêt à être envoyé ou soumis pour approbation
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
    Comment etape 13
    Sleep         10
    Scroll To Element    "Montant(s) et Remise(s) du Devis"
    Sleep         5
    Je clique sur //button[@title="Modifier Motif de perte ou raison de l'annulation"]
    Sleep    3
    # Je clique sur //button[contains(@aria-label, 'Motif de perte ou raison de l'annulation')]
    Je clique sur //button[@aria-label="Motif de perte ou raison de l'annulation"]
    Sleep    1
    # Je clique sur //lightning-base-combobox-item[contains(@data-value, 'Lost - Terms & Conditions')]
    Je clique sur //lightning-base-combobox-item[@data-value="Lost - Terms & Conditions"]
    Sleep    4
    Je clique sur //button[@name='SaveEdit']
    Sleep    4
    #     Sleep    5
    Je clique sur //div[p[contains(text(),'Opportunité')]]//a
    Sleep      5
    # Scroll To Element  "Équipe de l'opportunité"
    Scroll To Element    "Opportunity Conclusion"
    Sleep      2
    Je verifie la presence de (//lightning-formatted-text[text()='Perdu - Modalités du contrat incompatibles'])[1]
    Sleep    5
    Je clique sur //a[contains(@title, 'Q-')]
    Sleep      2
    Je clique sur //a[@data-tab-name='Rejected']
    Sleep     2
    Je clique sur //span[text()='Marquer Statut en cours']
    Sleep       3
    Je clique sur //div[p[contains(text(),'Opportunité')]]//a
    Sleep       3
    Reload
    Sleep       8
    Scroll To Element   "Nouveau devis"    
    Je verifie la presence de //ul[@role='listbox']//span[contains(text(), 'Fermé - Perdu')]
