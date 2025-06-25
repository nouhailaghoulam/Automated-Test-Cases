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
${Nom_Business}    0797524      
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Domaine}    Publique
${Origine_piste}    Appel entrant
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Type_ERP}    Refuge de montagne
${Prestation1}    AM-RTV
 
 
*** Test Cases ***
BV_23392
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
    Sleep    10
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
    Sleep    3
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    1/6 - Les Prestations et Prix doivent être complétés
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
    Comment etape 6
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Sleep    2
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Surface de 0 à 350 m²")) >> nth=0
 
    Je clique sur iframe[name="${iframe}"] >>> [name="Surface de 0 à 350 m²"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Surface de 0 à 350 m²"] >> [id="myinput"] >> nth=0    10
    Je clique sur iframe[name="${iframe}"] >>> div:below(:text("Unité")) >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> "Facturations Complémentaires" >> nth=0
    Comment etape 7
    Je clique sur iframe[name="${iframe}"] >>> span:left-of(:text("AM-RTV-Facturations complémentaires")) >> nth=0
    Comment etape 8
    ${elements}=    Get Elements    iframe[name="${iframe}"] >>> div.firstField >> span[id='me']
    ${filtered_elements}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        ${not_in}=    Run Keyword And Return Status    Should Not Contain    ${filtered_elements}    ${text}
        ${matches}=    Run Keyword And Return Status    Should Match Regexp    ${text}    ^(Prélèvement|Analyse).*
        ${condition}=    Evaluate    ${not_in} and ${matches}
        Run Keyword If    ${condition}    Append To List    ${filtered_elements}    ${text}
    END
    
    FOR    ${text}    IN    @{filtered_elements}
        ${checkbox}=    Get Element    iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("${text}")) >> nth=0
        ${is_checked}=    Get Attribute    ${checkbox}    aria-checked
        IF    "${is_checked}" == "false"
            Je clique sur ${checkbox}
            Sleep    1
        END
    END

 
    Comment etape 9
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    2
    Comment etape 10
    Je sélectionne la valeur Bureaux Services dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Nature d’établissement")) >> nth=0
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    15
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    2
 
    Comment etape 11
    Scroll To Element    "TVA, facturation et délai de paiement"
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1 Journée']/../../..//lightning-formatted-text    ==    EUR 900,00
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1/2 Journée']/../../..//lightning-formatted-text     ==    EUR 450,00
    Get Text    //span[@class='test-id__field-label' and text()='Minimum de facturation']/../../..//lightning-formatted-text     ==    EUR 200,00
    Sleep    3
    Comment etape 12
    Scroll To Element    "Détails de l'offre"
    Je clique sur "Echéancier"
    Comment etape 13
    Sleep    2
    Je clique sur "Modifier Afficher les échéanciers par prestation"
    Je clique sur //input[@type='checkbox' and @name='GLOBAL_ShowBillingSchedule__c']
    Je clique sur //button[@name='SaveEdit']
    Sleep    2
    Reload
    Sleep    6
    Je clique sur "Echéancier"
    Reload
    Sleep    6
    Je clique sur "Echéancier"
    Sleep    2
    Je verifie la presence de //th[@data-cell-value="A la commande (Hors prestations complémentaire)" and @class="private-ssr-placeholder-class" and @role="rowheader"]
    Je verifie la presence de //th[@data-cell-value="A la remise du rapport (Hors prestations complémentaire)" and @class="private-ssr-placeholder-class" and @role="rowheader"]
    Je verifie la presence de //th[@data-cell-value="A la remise du rapport (Hors prestations complémentaire)" and @class="private-ssr-placeholder-class" and @role="rowheader"]
    Sleep    3
    # Comment etape 14
    # Je clique sur "Générer un document"
    # Sleep    125
    # Je clique sur //button[@title="Fermer APXTConga4__Conga Composer"]
    # Comment etape 15
    # Reload
    # Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//div[@class='filerow']//span[contains(text(), '.pdf') and contains(@title, 'pdf')]
    # Comment etape 16
    # Log    ${CURDIR}
    # ${latest_pdf_file}    Get Latest Pdf File    ${CURDIR}/../../Tests/Resources/data/
    # Log    ${latest_pdf_file}
    # # Pdf verification_23392    ${latest_pdf_file}
    # Sleep    2