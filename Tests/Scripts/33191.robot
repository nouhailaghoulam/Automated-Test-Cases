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
${Prestation1}    EL-CONS
${Motif de perte ou d'annulation}    Perdu - Modalités du contrat incompatibles
${Type_Document}    Annexe Périmètre    
${FICHIER}    ${CURDIR}/../../Tests/Resources/ChargerDoc/
*** Test Cases ***
BV_33191
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
    Run Keyword And Ignore Error    Je clique sur //label[contains(text(), 'Opportunité initiale')]/..//button[contains(@title, 'Effacer la sélection')]
    Sleep    2
    Je renseigne la valeur "${Devis}" sous le champ "Opportunité initiale"
    Sleep     2
    Comment etape 2.9
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[contains(@title, '${Devis}')]]
    Sleep    3
    Je clique sur "Suivant" >> nth=0
    sleep   3
    Comment etape 2.10
 
    Je clique sur "Une prestation Contrôle Technique"
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
    Je sélectionne la valeur ${Categorie_Operation} dans la liste (//select[@class='slds-select'])[4]
    Sleep    2
 
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Comment etape 2.12
    Je clique sur "Suivant" >> nth=0
    Sleep    3
    Comment etape 2.13 & 2.14
    # Run Keyword And Continue On Failure    Je verifie la presence de //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number[contains(text(), '5')] >> nth=0
    Sleep       1
    Scroll To Element    "Construction - France"  
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
 
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    1/6 - Les Prestations et Prix doivent être complétés
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
    # Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation1}
    END
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> [id="search"] >> nth=3
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Sleep     5
    Comment etape 9
 
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0   TEST
    Sleep    2
    Je sélectionne la valeur Bureaux Services dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Nature d’établissement")) >> nth=0
    Sleep    3
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Test
    Je clique sur iframe[name="${iframe}"] >>> paper-button:not(#pcSave):has-text("Enregistrer")
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> "Installations / Equipements" >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Superficie")) >> nth=0  
    Sleep     2
    Je clique sur iframe[name="${iframe}"] >>> span:below(:text("Unité")) >> nth=1
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    5
    Sleep     3
    # Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Comment etape 10 & 11
 
    Sleep          3
    Modification Devis ligne Superficie avec prix 500
    Sleep               3
    Comment etape 12
    Modification Devis ligne FDOSC avec prix 0
    Sleep       3
 
    # Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
 
    Sleep         3
    Comment etape 13
 
    Je clique sur "Echéancier"
    Comment etape 14
    Je verifie la presence de //tr[th[@data-cell-value="A l'issue de l'intervention"] and td[@data-cell-value='1']]
   
    Sleep    50