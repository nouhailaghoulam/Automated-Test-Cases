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
${Prestation}    COPRECBA
${Message}    Bonjour, ceci est un message
 
*** Test Cases ***
BV_33190
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
    Comment etape 2.8
    Je clique sur "Une prestation Contrôle Technique"
    Comment etape 2.9
    Sleep    2
    Je renseigne la valeur "${Description_Operation}" sous le champ "Description de l'opération"
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
    Comment etape 2.10
    Je clique sur "Suivant"
    Sleep    5
    Comment etape 4.1
    Scroll To Element    "Opportunity Information"    
    ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    ##################################################
    Sleep    5
    Je clique sur "Devis CPQ (1)"
    Sleep    5
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..    
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
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=2
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Sleep    10
    Comment etape 8
    Sleep    5
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("L")) >> nth=0    
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    10
    Comment etape 15
    Modification Devis ligne COPRECBA avec prix 1700
    Modification Devis ligne Allongement de la durée des travaux avec prix 10
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    10
    Comment etape 23
    Je clique sur "Echéancier"
    Reload
    Sleep    10
    Je clique sur "Echéancier"
    Sleep    3
    Comment etape 23
    Je verifie la presence de //tr[th[@data-cell-value='A la commande'] and td[@data-cell-value='0.2']] 
    Je verifie la presence de //tr[th[@data-cell-value="A la phase conception"] and td[@data-cell-value='0.3']]
    Je verifie la presence de //tr[th[@data-cell-value='Au démarrage de la phase travaux'] and td[@data-cell-value='0.2']]
    Je verifie la presence de //tr[th[@data-cell-value='Tous les 2 mois (phase travaux)'] and td[@data-cell-value='0.3']]
    Comment etape 23
    scroll to Element    //tr[th[@data-cell-value='Lors de la 1ère facturation']]
    Je verifie la presence de //tr[th[@data-cell-value='Lors de la 1ère facturation'] and td[@data-cell-value='85']]
    Je verifie la presence de //tr[th[@data-cell-value='Lors de la 1ère facturation'] and td[@data-cell-value='1']]

    
