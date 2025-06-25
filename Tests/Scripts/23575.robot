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
${Installation_Electrique}    Basse Tension à puissance limitée (P<=36 KvA)
${SourcePrincipale}    F&A - FR BVC - Challenge BV à la carte
${Prestation1}    EL-CONS
${Prestation2}    FDOSC
${Message}    Bonjour, ceci est un message
 
*** Test Cases ***
BV_23575
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
    Comment etape 3
    Je clique sur "Modifier Source principale de campagne"
    Je renseigne la valeur "${SourcePrincipale}" sous le champ "Source principale de campagne"
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${SourcePrincipale}']]
    Je clique sur //button[@name='SaveEdit']
    Sleep    5
    Comment etape 4.1
    Scroll To Element    "Opportunity Information"    
    ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    ##################################################
    Je clique sur "Devis CPQ (1)"
    Sleep    2
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..    
    Comment etape 4.3
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
    Je clique sur //a[text()='Paragraphe du contrat']
    Je clique sur "Modifier Précisions complémentaires"
    Je renseigne le champ //div[@role='textbox'] avec la valeur ${Message}
    Upload File By Selector    //div[@aria-label='Précisions complémentaires']//input[@type='file']    ${CURDIR}/../../Tests/Resources/data/test.png
    Je clique sur //button[@name='SaveEdit']
    Sleep    2
    Comment etape 6
    Je clique sur "Modifier les lignes"
    Sleep    10
    Comment etape 7
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}
    # Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation1}
    END
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> [id="search"] >> nth=3
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Sleep    3
    Comment etape 8
    Run Keyword And Continue On Failure    Get Selected Options    iframe[name="${iframe}"] >>> select:right-of(:text("Comptage électrique")) >> nth=0   label    ==    ${Installation_Electrique}
    Comment etape 9
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Je sélectionne la valeur Bureaux Services dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Nature d’établissement")) >> nth=0
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    Sleep    2
    # Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Superficie"))
    ${allCheckbox_Superficie}=    Get Elements    iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Superficie"))
    FOR    ${checkboxSuperficie}    IN    @{allCheckbox_Superficie}
        ${status}=      Run Keyword And Return Status    Je clique sur ${checkboxSuperficie}
        Exit For Loop If    '${status}' == 'True'  
    END
 
    Je clique sur iframe[name="${iframe}"] >>> [name="Superficie"] >> "0,00" >> nth=0
    Type Text   iframe[name="${iframe}"] >>> [name="Superficie"] >> [id="myinput"] >> nth=0    5
    Sleep    2
    Comment etape 10
    Je clique sur iframe[name="${iframe}"] >>> "Facturations Complémentaires" >> nth=0
    Sleep    1
    # Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Facturations complémentaires")) >> nth=0
    ${allCheckbox_Facturations}=    Get Elements    iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Facturations complémentaires"))
    FOR    ${checkboxFacturations}    IN    @{allCheckbox_Facturations}
        ${status}=      Run Keyword And Return Status    Je clique sur ${checkboxFacturations}
        Exit For Loop If    '${status}' == 'True'  
    END
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    5
    Comment etape 11
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Keyboard Input    insertText    0
    Keyboard Key    press    Enter
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    3
    Comment etape 12
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    # Je clique sur iframe[name="${iframe}"] >>> button[tooltip="Supprimer la ligne"] >> nth=1
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    # Sleep    5
    # Comment etape 13
    # Je clique sur "Modifier les lignes"
    # ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    # Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0
    # Comment etape 14
    # ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    # FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
    #     Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation2}
    # END
    # Sleep    1
    # Je clique sur iframe[name="${iframe}"] >>> [id="search"] >> nth=3
    # Sleep    2
    # Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    # Sleep    1
    # Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    # Sleep    1
    # Comment etape 15
    # Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    10
    Comment etape 16
    # Je clique sur "Détails"
    ${allOngletsDetails}=    Get Elements    //li[@title='Détails']
    FOR    ${OngletDetails}    IN    @{allOngletsDetails}
        Run Keyword And Ignore Error    Je clique sur ${OngletDetails}
    END
    Scroll To Element    "TVA, facturation et délai de paiement"    
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1 Journée']/../../..//lightning-formatted-text    ==    EUR 1 200,00
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1/2 Journée']/../../..//lightning-formatted-text     ==    EUR 700,00
 
    ####################################
    #FAIRE GENERATION DU DOC ET VERIF PDF
    ####################################
 
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
 
    Comment etape 21
    Je verifie la presence de //ul[@role='listbox']//a[@aria-selected="true"]//span[contains(text(), 'Brouillon')]
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    6/6 - Le Devis est prêt à être envoyé ou soumis pour approbation
    Sleep    3
 
    Comment etape 22
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
    Sleep    2
    Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//li[contains(@class, 'slds-is-current')]//*[contains(text(), 'Devis en préparation')]
    Sleep    1
 
    Comment etape 23
    Je clique sur //a[contains(@title, 'Q-')]
    Sleep    2
    Je clique sur //button[contains(text(), 'Passer au statut "émis"')]
    Sleep    2
    Je clique sur //footer//button/span[contains(text(), 'Enregistrer')]
    Sleep    5
    Je verifie la presence de //ul[@role='listbox']//a[@aria-selected="true"]//span[contains(text(), 'Émis')]
    # FAIRE VERIF DU MAIL RECU PAR LE CLIENT
 
    Comment etape 24
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
    Sleep    2
    Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//li[contains(@class, 'slds-is-current')]//*[contains(text(), 'Devis émis')]
    Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    70\xa0%
    Sleep    1
 
    Comment etape 25
    Je clique sur //a[contains(@title, 'Q-')]
    Sleep    2
    Je clique sur //li[contains(@data-name, 'In Review')]//a
    Sleep    1
    Je clique sur //button[./span[contains(text(), 'Marquer Statut en cours')]]
    Sleep    3
 
    Comment etape 26
    Je clique sur "Modifier les lignes" >> nth=0
 
    Comment etape 27
    Sleep    5
    # ${iframe} =     Get Attribute    (//iframe[@title='accessibility title'])[1]    name
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Superficie")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Superficie")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Superficie")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    3
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    300
    Keyboard Key    press    Enter
    Sleep    3
 
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    20
 
    # Comment etape 28
    # Run Keyword And Continue On Failure    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    4/6 - Le Devis doit être généré
 
    # FAIRE SUITE QUAND SOLUTION POUR GENERATION DU DOCUMENT
    ####################################