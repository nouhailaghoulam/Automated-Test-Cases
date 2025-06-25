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
${Nom_Business}          0796004    
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    Test
${Domaine}    Bureau
${Devis}            Q-1830551
${Relation_Client}       Avenant
${Origine_piste}    Appel entrant
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Opportunité initiale}      structure provisoire démontable
${Categorie_Operation}   2
${Type_Objet}    Commerce
${Stade_Avancement}    Conception
${Type_ERP}    Refuge de montagne
${Type_travaux}    Travaux neufs
${Description de l'opération}    Testing
${Destination_ouvrage}        
${Montant_Des_Travaux}   1234
${Prestation1}    ATT-HAND
${Motif de perte ou d'annulation}    Perdu - Modalités du contrat incompatibles
${Type_Document}    Annexe Périmètre    
${FICHIER}    ${CURDIR}/../../Tests/Resources/ChargerDoc/
*** Test Cases ***
BV_33188
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
    Sleep    3
    Je sélectionne la valeur ${Relation_Client} dans la liste (//select[@class='slds-select'])[2]
    Sleep    3
    Comment etape 2.9
    Sleep    3
    Je clique sur "Suivant" >> nth=0
    sleep   3
    Comment etape 2.10
 
    Je clique sur "Une prestation de CSPS"
    Sleep    3
    Comment etape 2.11
    Je renseigne la valeur "${Description de l'opération}" sous le champ "Description de l'opération"
    Sleep    1
    Je renseigne la valeur "${Montant_Des_Travaux}" sous le champ "Montant des travaux (en euros)"
    Sleep    2
 
    Je sélectionne la valeur ${Type_travaux} dans la liste select[name="screen_WorkType"]
    Sleep    2
    Je sélectionne la valeur ${Stade_Avancement} dans la liste (//select[@class='slds-select'])[3]
    Sleep    2
    # Je sélectionne la valeur ${Categorie_Operation} dans la liste (//select[@class='slds-select'])[4]
    # Sleep    2
 
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Je clique sur "Une prestation Contrôle Technique"
    Comment etape 2.12
    Je clique sur "Suivant" >> nth=0
    Sleep    3
    Je clique sur "Suivant" >> nth=0
    # Comment etape 2.13 & 2.14
    # # Run Keyword And Continue On Failure    Je verifie la presence de //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number[contains(text(), '5')] >> nth=0
   
    Sleep    2
 
    Comment etape 3.1
    # # ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    # # ##################################################    
    Sleep    5
    Comment etape 4
 
    Je clique sur "Devis CPQ (1)"
    Sleep    10
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..    
    Comment etape 5
 
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
 
    Comment etape 6
 
    Scroll To Element    "Opportunity Details"  
    Run Keyword And Continue On Failure    Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    25\xa0%  
    Sleep    2
 
    Scroll To Element    "Opportunity Information"
    Sleep    5
   
    Je clique sur "Devis CPQ (1)"
    Sleep    2
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..    
    Sleep    2
 
    Comment etape 7
 
    Je clique sur "Modifier les lignes"
    Sleep    5
 
    Comment etape 8
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}  
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation1}  
    END
   
    Sleep    5
    Je clique sur iframe[name="${iframe}"] >>> [id="search"] >> nth=3
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Sleep          10
    # Je clique sur iframe[name="${iframe}"] >>> #popup i.sf-icon-close
    Comment etape 9
 
    #  Je clique sur iframe[name="${iframe}"] >>> button.slds-button:has-text("Annuler")
    Je clique sur iframe[name="${iframe}"] >>> #popup i.sf-icon-close
    Sleep       2
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0   TEST
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> paper-button:not(#pcSave):has-text("Enregistrer")
    Sleep    3
  #  Je clique sur iframe[name="${iframe}"] >>> "Annuler" >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    # Comment etape 10 & 11
 
    Sleep          3
    Modification Devis ligne ATT-HAND avec prix 300
    Sleep               3
    # # Modification Devis ligne ${Prestation1} avec prix 1700
    # Comment etape 12
    # # Modification Devis ligne FDOSC avec prix 0
    # Sleep       3
    # Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    10
    Comment etape 7
    Je clique sur "Echéancier"
    Sleep    3
    Je clique sur "Modifier les lignes" >> nth=0
    Sleep    5
    # ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    # Log    ${iframe}
    # Sleep    3
    # Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    10
    Reload
    Sleep    10
    Je clique sur "Echéancier"
    Sleep    2
    Je verifie la presence de //tr[th[@data-cell-value='A la commande'] and td[@data-cell-value='1']]
    Sleep    2
    # Je verifie la presence de //tr[th[@data-cell-value='FDOSC'] and td[@data-cell-value='1]]
    Je verifie la presence de //tr[th[@data-cell-value='Lors de la 1ère facturation'] and td[@data-cell-value='1']]
    Sleep    2
    Comment etape 7
    Je clique sur "Modifier les lignes" >> nth=0
    sleep    2
    # Modification Devis ligne ATT-HAND avec prix 500
    # Sleep    3
    
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}
    Comment etape 7
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("ATT-HAND")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> css=img#checkbox
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("ATT-HAND")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> css=img#checkbox
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("ATT-HAND")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    5
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("ATT-HAND")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    500
    Keyboard Key    press    Enter
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    # Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    # Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    10
    Comment etape 7
    Je clique sur "Modifier les lignes" >> nth=0
    Sleep    5
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    10
    Reload
    Sleep    10
    Comment etape 7
    Je clique sur "Echéancier"
    Sleep    8
    Je verifie la presence de //tr[th[@data-cell-value="A la commande"] and td[@data-cell-value="0.5"]]
    Sleep    3 
    Je verifie la presence de //tr[th[@data-cell-value="A l'issue de l'intervention"] and td[@data-cell-value="0.5"]]
    Sleep    3
    Comment etape 7
    Je clique sur //div[@class='tabBarContainer']//a[contains(@title, '${Nom_Opportunite}')]
    Sleep    3
    Je clique sur (//button[.//span[contains(text(),"Afficher plus d'actions")]])[1]
    Sleep    5
    Je clique sur //span[normalize-space(.)="Clone"]
    Sleep    3
    Je clique sur //input[@name="CloseDate"]
    Type Text    xpath=//input[@name="CloseDate"]    12/06/2027
    Sleep    2
    Scroll To Element    xpath=//label[contains(text(),"Montant global")]
    Sleep    3
    Scroll To Element    xpath=//input[@name="Amount"]
    Type Text            xpath=//input[@name="Amount"]    12345
    Sleep    3
    Je clique sur //button[@name='SaveEdit']
    Sleep    15
    ${count}=    Get Element Count    text="Description des travaux"
    Should Be True    ${count} > 0
    Sleep    10



    