*** Settings ***
Library          Browser
# Library          ${CURDIR}/../../Tests/Resources/keywords/checkPDFBV.py
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
${Nom_Business}    0797951      
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Domaine}    Publique
${Origine_piste}    Appel entrant
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Type_ERP}    Refuge de montagne
${Prestation1}    FO-HE
${Etendu_prestation}    Ceci est une prestation étendue
${DateIntervention}    31/12/2025
 
 
*** Test Cases ***
BV_23390
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
    # Comment etape 2.9
    # Je clique sur //tr[.//*[contains(text(), "${Type_Objet}")] and .//*[contains(text(), "${Categorie_Objet}")] and .//*[contains(text(), "Sélectionner l'élément")]]//span[@class = 'slds-radio']
    ################
    #OU ALORS 
    # Je sélectionne la valeur ${Categorie_Objet} dans la liste (//select)[1]
    # Je sélectionne la valeur ${Type_Objet} dans la liste (//select)[2]
    ################
    # Je clique sur "Suivant" >> nth=0
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
    # Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    1/6 - Les Prestations et Prix doivent être complétés
    # Sleep    3
    Comment etape 3.4
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
    Scroll To Element    "Opportunity Details"
    Run Keyword And Continue On Failure    Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    25\xa0%
    Sleep    3
    Scroll To Element    "Opportunity Information"
    Je clique sur "Devis CPQ (1)"
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..
    Comment etape 4
    Je clique sur "Modifier les lignes"
    Sleep    15
    Comment etape 5
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}
 
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation1}
    END
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div.option >> nth=0
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Sleep    3
    Comment etape 8
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("HEve11-4 - Habilitation électrique - véhicules électriques ou hybrides : B1L, B2L, BCL , BRL, B1XL, B2XL... - Opérations d'ordre électrique ")) >> nth=0  
    Je clique sur iframe[name="${iframe}"] >>> span:left-of(:text("HEve11-4 - Habilitation électrique - véhicules électriques ou hybrides : B1L, B2L, BCL , BRL, B1XL, B2XL... - Opérations d'ordre électrique ")) >> nth=0 
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    ${Etendu_prestation}
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("UO (1UO = 1h)")) >> nth=0    2 
    Je clique sur iframe[name="${iframe}"] >>> span:below(:text("Commentaire")) >> nth=0
    Sleep    2
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Test
    Je clique sur iframe[name="${iframe}"] >>> paper-button:not(#pcSave):has-text("Enregistrer")
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    10
    Comment etape 8
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("EL MET 21-8 - Agent d'entretien habilité BS et BE Manoeuvres ")) >> nth=0  
    Je clique sur iframe[name="${iframe}"] >>> span:left-of(:text("EL MET 21-8 - Agent d'entretien habilité BS et BE Manoeuvres ")) >> nth=0 
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    ${Etendu_prestation}
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("UO (1UO = 1h)")) >> nth=0    2 
    Je clique sur iframe[name="${iframe}"] >>> span:below(:text("Commentaire")) >> nth=0
    Sleep    2
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Test
    Je clique sur iframe[name="${iframe}"] >>> paper-button:not(#pcSave):has-text("Enregistrer")
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> sb-datepicker:right-of(:text("Date de l'intervention")) >> nth=0
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    ${DateIntervention}
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    10
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    10
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    15
    Comment etape 8
    Run Keyword And Continue On Failure    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    4/6 - Le Devis doit être généré
    Comment etape 8 
    # verifier que les champs sont vides 
    Scroll To Element    "TVA, facturation et délai de paiement"
    ${texte}=    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1 Journée']/../../..//lightning-formatted-text 
    Should Be Empty    ${texte}
    ${texte}=    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1/2 Journée']/../../..//lightning-formatted-text 
    Should Be Empty    ${texte}
    ${texte}=    Get Text    //span[@class='test-id__field-label' and text()='Minimum de facturation']/../../..//lightning-formatted-text 
    Should Be Empty    ${texte}
    Sleep    5


