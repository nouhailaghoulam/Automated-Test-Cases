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
${Nom_Opportunite}    Test
${Domaine}    Bureau
${prix_moyen_float}        50
${prix_moyen}         50
${Origine_piste}    Appel entrant
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Type_ERP}    Refuge de montagne
${Prestation1}    EL-VP
${Type_Document}    Annexe Périmètre    
${FICHIER}    ${CURDIR}/../../Tests/Resources/ChargerDoc/
${FLECHE_ELVP}       //tr[.//span[contains(text(),"EL-VP")]]//button[contains(@class,"slds-button") and @aria-haspopup="true"]
${STYLET_MONTANT}    //div[contains(text(),"Montant unitaire STE par intervention")]/following::button[contains(@class,"edit")][1]
${CHAMP_MONTANT}     //div[contains(text(),"Montant unitaire STE par intervention")]/following::input[1]
*** Test Cases ***
BV_33192
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
    Je clique sur "Suivant" >> nth=0
    Sleep    3
    Comment etape 2.10
    Je clique sur "Suivant" >> nth=0
    Sleep    3
    Comment etape 2.11
    Run Keyword And Continue On Failure    Je verifie la presence de //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number[contains(text(), '5')] >> nth=0
    Comment etape 3.1 & 3.2
    ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    ##################################################    
    Comment etape 3.3
    Sleep    3
    Je clique sur "Devis CPQ (1)"
    Sleep    3
    Reload
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..
    Sleep    5
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    1/6 - Les Prestations et Prix doivent être complétés
    Comment etape 3.4
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
    Scroll To Element    "Opportunity Details"
    Run Keyword And Continue On Failure    Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    25\xa0%
    Sleep    3
    Comment etape 4
    Scroll To Element    "Opportunity Information"
    Sleep    5
    Je clique sur "Devis CPQ (1)"
    Sleep    2
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..    
    Sleep    2
    # ##################################################################################
    # verif ERP
    Comment etape 7
    Je clique sur //a[contains(@title, '${Nom_Compte}')]
    Sleep     3  
    Scroll To Element  "Objectifs KPI"
    Sleep      1
    Je clique sur //lst-common-list-internal[.//span[contains(text(), "ERP IDs")]]//a[@href][.//*[substring(normalize-space(text()), string-length(normalize-space(text())) - 1) = "CT"]]
    Sleep       1
    Je verifie la presence de (//records-record-layout-item[contains(@field-label, 'Search Type')])[1]//dd//lightning-formatted-text[normalize-space(text()) != 'C']
    Sleep    2
    # ##################################################################################
    Je clique sur (//div[contains(@role, 'tablist')]//a[contains(@title, '${Nom_Opportunite}')])[1]
    Sleep    2
    Comment etape 8
    Je clique sur "Modifier les lignes"
    Sleep    5
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}
 
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
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Sleep    3
    Comment etape 9
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0   TEST
    Je clique sur iframe[name="${iframe}"] >>> paper-button:not(#pcSave):has-text("Enregistrer")
    Sleep      2
    Je sélectionne la valeur Bureaux Services dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Nature d’établissement")) >> nth=0
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
   
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Bureaux")) >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> [name="Bureaux"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Bureaux"] >> [id="myinput"] >> nth=0    5
    Sleep    1s
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:right-of(:text("Sous traitance Externe (STE)")) >> nth=0  
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep     2
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Montant unitaire STE")) >> nth=0    50
    Sleep     1
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep      4
    Comment etape 7
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Bureaux")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> css=img#checkbox
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Bureaux")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> css=img#checkbox
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Bureaux")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> css=img#checkbox
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Bureaux")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    5
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("Bureaux")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    150
    Keyboard Key    press    Enter
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrement rapide" >> nth=0
    Sleep   3
    #  Je clique sur    iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrement rapide")
    Sleep    5
    ${all_divs_PrixHoraireMoyen}=    Get Elements    iframe[name="${iframe}"] >>> sb-field-set-table-item.--desktop >> div:right-of(:text("Prix horaire moyen"))
 
    ${prix_moyen}=    Set Variable    ${EMPTY}
    FOR    ${div}    IN    @{all_divs_PrixHoraireMoyen}
    ${text}=    Get Text    ${div}
    ${text}=    Strip String    ${text}
    Run Keyword If    '${text}' != ''    Set Variable    ${prix_moyen}    ${text}
    Exit For Loop If    '${text}' != ''
    END
 
    # Should Not Be Empty    ${prix_moyen}    Le prix horaire moyen est vide !
 
    # ${prix_moyen_float}=    Convert To Number    ${prix_moyen.replace(",", ".")}
    Should Be Equal As Numbers    ${prix_moyen_float}    50.0    msg=❌ Le prix horaire moyen est ${prix_moyen_float}, attendu: 50.0
    Log    ✅ Le prix horaire moyen est exactement 50.00.
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("EL-VP")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div:has(div.label:has-text("Montant unitaire STE par intervention")) >> div#formatted:has(span:has-text("50,00 EUR")) >> nth=0
    Keyboard Key         press           Control+A
    Keyboard Key         press           Delete
    Keyboard Input       insertText      70
    Keyboard Key         press           Enter
    Sleep  1
    Je clique sur iframe[name="${iframe}"] >>> text=Prix horaire moyen
    Sleep  3
    # Je clique sur iframe[name="${iframe}"] >>> "Calculer" >> nth=0
    Sleep   3
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrement rapide" >> nth=0
    # ✅ Dynamic wait instead of Sleep
  
    # Wait Until Element Contains  iframe[name="${iframe}"] >>> sb-field-set-table-item.--desktop >> div:right-of(:text("Prix horaire moyen"))    40,00    
    #     Sleep          10
  
    #     ${all_divs_PrixHoraireMoyen}=    Get Elements    iframe[name="${iframe}"] >>> sb-field-set-table-item.--desktop >> div:right-of(:text("Prix horaire moyen"))
  
    #     ${prix_moyen}=    Set Variable    ${EMPTY}
  
  #     FOR    ${div}    IN    @{all_divs_PrixHoraireMoyen}
  
  #     ${text}=    Get Text    ${div}
  
  #     ${text}=    Strip String    ${text}
  
  #     Run Keyword If    '${text}' != ''    Set Variable    ${prix_moyen}    ${text}
  
  #     Exit For Loop If    '${text}' != ''
  
  #     END
  
  # # Convert and assert
  
  #     # ${prix_moyen_float}=    Convert To Number    ${prix_moyen.replace(",", ".")}
  
  #     Should Be Equal As Numbers    ${prix_moyen_float}    40.00    msg=❌ Le prix horaire moyen est ${prix_moyen_float}, attendu: 40.00
  
  #     Log    ✅ Le prix horaire moyen est exactement 40.00
  
  #     Sleep    2
   Sleep    1
   Je clique sur iframe[name="${iframe}"] >>> "Enregistrement rapide" >> nth=0
  
    # ✅ Attente dynamique que la valeur soit mise à jour
      # Wait Until Keyword Succeeds    10x    1s    Prix Horaire Moyen Doit Être Mis à Jour
  
  
      ${divs}=    Get Elements    iframe[name="${iframe}"] >>> sb-field-set-table-item.--desktop >> div:right-of(:text("Prix horaire moyen"))
      FOR    ${div}    IN    @{divs}
          ${text}=    Get Text    ${div}
          ${text}=    Strip String    ${text}
          Exit For Loop If    '${text}' == '40,00'
      END
    Should Be Equal As Strings    ${text}    40,00
  
  # Ensuite, vérification numérique
   ${prix_moyen_float}=    Convert To Number    ${text.replace(",", ".")}
   Should Be Equal As Numbers    ${prix_moyen_float}    40.00    msg=❌ Le prix horaire moyen est ${prix_moyen_float}, attendu: 40.00
  
  
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep      4