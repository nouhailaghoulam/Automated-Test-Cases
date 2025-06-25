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
${Nom_Compte}     SOS OXYGENE NORMANDIE
${Nom_Business}          0797524    
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    Test
${Domaine}    Bureau
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
${Search_Type_Label}     Search Type
${Valeur_Attendue}       C
${Montant_Des_Travaux}   1234
${Prestation1}   EL-VP
${Type_Document}    Annexe Périmètre    
${FICHIER}    ${CURDIR}/../../Tests/Resources/ChargerDoc/
${Etendu_prestation}    Ceci est une prestation étendue
*** Test Cases ***
BV_33369
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
    # verif ERP
    Sleep     3  
    Scroll To Element  "Objectifs KPI"
    Sleep      3
    Je clique sur //span[text()='FLEX-3634112-FR-C']
    Sleep      3
    Je verifie la presence de (//lightning-formatted-text[text()='C'])[2]
    Sleep    2
    Comment etape 7
    Je clique sur //div[@class='tabBarContainer']//a[contains(@title, '${Nom_Compte}')]
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
    Comment etape 5.1
    ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    ##################################################
    Comment etape 5.3
    Je clique sur //a[.//*[contains(text(), 'Devis CPQ')]]
    Sleep    10
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..
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
    Sleep     3
    Je clique sur iframe[name="${iframe}"] >>> [id="search"] >> nth=3
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Sleep    3
    Comment etape 9
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    ${Etendu_prestation}
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Je sélectionne la valeur Bureaux Services dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Nature d’établissement")) >> nth=0
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    
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
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
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
    Je clique sur //button[contains(@title, 'Modifier Envoyer le devis via Salesforce ?')]
    Sleep    3
    Je clique sur //button[contains(@aria-label, 'Envoyer le devis via Salesforce ?')]
    Sleep    1
    Je clique sur //lightning-base-combobox-item[contains(@data-value, 'No')]
    Sleep    3
    Je clique sur //button[@name='SaveEdit']
    Sleep    5
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
    Sleep    8
    Comment etape 7
    Run Keyword And Continue On Failure    Get Text    lightning-formatted-text:below(:text("L'adresse du gestionnaire de bien doit être renseigné avant d'émettre le devis!")) >> nth=0 


    
    
