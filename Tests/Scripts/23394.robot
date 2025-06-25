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
${Nom_Opportunite}    MyNewOp
${Domaine}    Publique
${Origine_piste}    Appel entrant
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Type_ERP}    Refuge de montagne
${Prestation1}    MD-VP
${Type_Document}    Annexe Périmètre    
${FICHIER}    ${CURDIR}/../../Tests/Resources/data/Annexe Perimetre.docx

 
*** Test Cases ***
BV_23394
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
    Sleep    2
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
    Scroll To Element    "Opportunity Details"
    Run Keyword And Continue On Failure    Je verifie la presence de //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number[starts-with(text(), '5')] >> nth=0
    Comment etape 3.1 & 3.2
    ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    ##################################################    
    Comment etape 3.3
    Sleep    3
    Je clique sur "Devis CPQ (1)"
    Sleep    3
    Reload
    Sleep    5
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
    Sleep    3
    Comment etape 4
    Scroll To Element    "TVA, facturation et délai de paiement"
    Je clique sur "Modifier Cocher ici pour modifier le type TVA :"
    Je clique sur //input[@type='checkbox' and @name="Global_ChangeLocation__c"]
    Je clique sur //button[@name='SaveEdit']    
    Je clique sur "Modifier Type de TVA"
    Je clique sur //button[@type="button" and @aria-label="Type de TVA"]
    Je clique sur "Saint Martin (particuliers)"
    Je clique sur //button[@name='SaveEdit'] 
    Sleep    2
    Comment etape 5
    Scroll To Element    "Détails de l'offre"
    Je clique sur "Modifier les lignes"
    Sleep    15
    Comment etape 6
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}
    # Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0
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
    Comment etape 7
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."

    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Sleep    2
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    Sleep    2
    Je sélectionne la valeur 12 - Annuelle dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Modification de la périodicité")) >> nth=0
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Arbres à cardans")) >> nth=0
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [name="Arbres à cardans"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Arbres à cardans"] >> [id="myinput"] >> nth=0    10
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Centrifugeuses de laboratoire")) >> nth=0
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [name="Centrifugeuses de laboratoire"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Centrifugeuses de laboratoire"] >> [id="myinput"] >> nth=0    10
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Comment etape 8
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Comment etape 9
    Je clique sur "Echéancier"
    Comment etape 10
    Je clique sur "Modifier Afficher les échéanciers par prestation"
    Je clique sur //input[@type='checkbox' and @name='GLOBAL_ShowBillingSchedule__c']
    Je clique sur //button[@name='SaveEdit']
    Sleep    10
    Reload
    Sleep    5
    Je clique sur "Echéancier"
    # Sleep    15
    Je clique sur "Afficher les actions" >> nth=0
    # Je clique sur //tr[.//th[contains(@data-label, "Type d'échéance")] and .//*[contains(text(), "A l'issue de l'intervention")]]//button[.//span[contains(text(), "Afficher les actions")]]
    Je clique sur //div[@class="slds-dropdown__item"][.//span[text()="Modifier"]]
    Comment etape 11
    Je clique sur //label[contains(text(),'échéance')]/following-sibling::div//button[@title='Effacer la sélection']
    Je renseigne la valeur "A la commande" sous le champ "Type d'échéance"
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = 'A la commande']] >> nth=0
    Sleep    10
    Clear Text    //input[@name="GLOBAL_Percentage__c"]
    Je renseigne la valeur "50" sous le champ "Pourcentage"
    Sleep    3
    Je clique sur //button[@type='submit' and text()='Enregistrer']
    Sleep    15
    Comment etape 12
    # Lorsque je lance tle script depuis le debut il a du mal a trouvers ce bouton
    # Mais lorsque que je le coupe et passe en debug ca passe
    Je clique sur "Nouveau" >> nth=0
    Comment etape 13
    #Ne s'affiche plus depuis que j'ai changé de CB
    # Je renseigne la valeur "A la remise du livrable" sous le champ "Type d'échéance"
    # Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = 'A la remise du livrable']] >> nth=0
    Sleep    3
    Clear Text    //input[@name="GLOBAL_Percentage__c"]
    Je renseigne la valeur "50" sous le champ "Pourcentage"
    Sleep    3
    Je clique sur //button[@type='submit' and text()='Enregistrer']
    Sleep    2
    Comment etape 14
    Reload
    Sleep    3
    Comment etape 15
    # Je clique sur //select[option[@value="FileType.Annexe Périmètre"]]
    # Sleep    1
    Je sélectionne la valeur ${Type_Document} dans la liste select[name=Type_de_document]
    Comment etape 16
    # joindre fichier
    Upload File By Selector    input[type="file"] >> nth=0    ${FICHIER}
    Sleep    5
    Comment etape 17
    Je clique sur "Terminer" >> nth=0
    Comment etape 18
    Scroll To Element    "TVA, facturation et délai de paiement"
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1 Journée']/../../..//lightning-formatted-text    ==    EUR 900,00
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1/2 Journée']/../../..//lightning-formatted-text     ==    EUR 450,00
    Get Text    //span[@class='test-id__field-label' and text()='Minimum de facturation']/../../..//lightning-formatted-text     ==    EUR 200,00
    Sleep    2
    # Comment etape 19
    # Je clique sur "Générer un document"
    # Sleep    125
    # Je clique sur //button[@title="Fermer APXTConga4__Conga Composer"]
    # Comment etape 20
    # Reload
    # Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//div[@class='filerow']//span[contains(text(), '.pdf') and contains(@title, 'pdf')]
    # Sleep    3
    # Comment etape 21
    # # Log    ${CURDIR}
    # # ${latest_pdf_file}    Get Latest Pdf File    ${CURDIR}/../../Tests/Resources/data/
    # # Log    ${latest_pdf_file}
    # # Pdf verification_23394    ${latest_pdf_file}
    # Sleep    2