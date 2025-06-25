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
${Application}    CPQ Light
${Navigation}    CPQ Light
${Nom_Compte}     BNP Paribas Fortis Film Finance
${Designation}    MyNewOp 
   
${Duree_Du_Chantier}    6 
${Montant_Des_Travaux}    1500
${Type_De_Travaux}    Travaux neufs
${Destination_Ouvrage}    Atelier/petite industrie
${VRD}    VRD inclus 
${Stade_Avancement}    Conception  
${Nom_Business}    0796004       
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Prestation}    COPRECBA
${Approbateur}    Enzo Perbet
${Approbateur2}    Naïma ZEMMA
${Approbateur3}    Frederic FINET
${Ville}    Paris
${Adresse}    8 rue de la Comédie
${Cp}    75001
${Commentaire}    Ceci est un commentaire

*** Test Cases ***
BV_23577
    Comment    étape 1.1
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    Comment étape 2.2 - 2.4
    Je lance l'application ${Application} ${Navigation}
    Comment étape 2.5
    Sleep    2
    Je renseigne la valeur "${Nom_Compte}" sous le champ "Nom du Compte :"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Compte}']]
    Je clique sur "Suivant" >> nth=0
    Comment étape 2.6
    Sleep    2
    Je clique sur "Suivant" >> nth=0
    Comment étape 2.7
    Sleep    2
    Je clique sur "Effacer la sélection" >> nth=0
    Je renseigne la valeur "${Nom_Business}" sous le champ "Centre Budgétaire"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Business}']]
    Sleep    2
    Je renseigne la valeur "${Nom_Contact}" sous le champ "Contact principal pour cette Opportunité"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Contact}']]
    Je clique sur "Suivant" >> nth=0
    Comment étape 2.8
    Je renseigne la valeur "${Nom_Opportunite}" sous le champ "Nom de l'Opportunité"
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Comment étape 2.9
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Comment étape 2.10
    Je clique sur //span[@class="slds-radio"][input[@value="ChoiceConstructionCT"]]/label/span[@class="slds-radio_faux"]
    Sleep    5
    Comment étape 2.11
    Je renseigne la valeur "${Designation}" sous le champ "Désignation de l'opération"
    Je renseigne la valeur "${Duree_Du_Chantier}" sous le champ "Durée du chantier (en mois)"
    Je renseigne la valeur "${Montant_Des_Travaux}" sous le champ "Montant des Travaux (en euros)"
    Je clique sur //div[@class="slds-select_container"]/select[@name="Work_Type"]
    Sleep    1
    Je sélectionne la valeur ${Type_De_Travaux} dans la liste select[name="Work_Type"]
    Sleep    2
    Je clique sur //div[@class="slds-select_container"]/select[@name="Facility_Type"]
    Sleep    1
    Je sélectionne la valeur ${Destination_Ouvrage} dans la liste select[name="Facility_Type"]
    Sleep    2
    Je clique sur //div[@class="slds-select_container"]/select[@name="Screen_VRD"]
    Sleep    1
    Je sélectionne la valeur ${VRD} dans la liste select[name="Screen_VRD"]
    Sleep    2
    Je clique sur //div[@class="slds-select_container"]/select[@name="WorkProgress"]
    Sleep    1
    Je sélectionne la valeur ${Stade_Avancement} dans la liste select[name="WorkProgress"]
    Sleep    2
    Je clique sur "Suivant" >> nth=0
    Comment étape 2.12
    Je sélectionne la valeur ${Categorie_Objet} dans la liste (//select)[1]
    Je sélectionne la valeur ${Type_Objet} dans la liste (//select)[2]
    Je clique sur "Suivant" >> nth=0
    Sleep    2
    Comment étape 2.13
    Je clique sur "Suivant" >> nth=0
    Sleep    20
    Comment étape 2.14
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    # Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0
    Comment étape 3
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
    Comment étape 4
    Sleep    5
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("L")) >> nth=0    
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("STI")) >> nth=0  
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    15
    Comment étape 5
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")]
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> css=img#checkbox
    Sleep    1
    
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")]
    Keyboard Input    insertText    0
    Keyboard Key    press    Enter
    Sleep    2
    Take Screenshot    filename=EMBED
    Comment étape 6
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Montant client cible")) >> nth=0   350000
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    10
    #Tentative de re-clic si erreur du précédent
    Run Keyword And Ignore Error    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Take Screenshot    filename=EMBED
    Comment étape 7
    ${allOngletsDevis}=    Get Elements    //span[contains(text(),' | Devis') and not(contains(text(),'Fermer')) and not(contains(text(),'Actions'))]
    FOR    ${OngletDevis}    IN    @{allOngletsDevis}
        Run Keyword And Ignore Error    Je clique sur ${OngletDevis}
    END
    Je clique sur "Echéancier"
    Sleep    5
    Comment étape 8
    Je verifie la presence de //tr[th[@data-cell-value='A la commande'] and td[@data-cell-value='0.2']] 
    Je verifie la presence de //tr[th[@data-cell-value='A la phase conception'] and td[@data-cell-value='0.3']]
    Je verifie la presence de //tr[th[@data-cell-value='Au démarrage de la phase travaux'] and td[@data-cell-value='0.2']]
    Je verifie la presence de //tr[th[@data-cell-value='Tous les 2 mois (phase travaux)'] and td[@data-cell-value='0.3']] 
    Je verifie la presence de //tr[th[@data-cell-value='Lors de la 1ère facturation'] and td[@data-cell-value='1']] 

    Sleep    2
    Comment étape 9
    Run Keyword And Continue On Failure    Get Text    lightning-formatted-text:below(:text('Etape')) >> nth=0    ==    3/6 - Sélectionnez un approbateur
    Sleep    2
    Comment étape 10
    Je clique sur "Détails"
    Scroll To Element    "Représentant client"
    Je clique sur "Modifier Approbateur"
    Sleep    1
    Je clique sur //input[@placeholder="Recherchez dans les Personnes..."]
    Sleep    1
    Je renseigne le champ "Approbateur" avec la valeur ${Approbateur}
    Je clique sur //lightning-base-combobox-formatted-text[@title="${Approbateur}"]
    Sleep    2
    Je clique sur //button[text()='Enregistrer']
    Get Text    //h2[@class="slds-truncate slds-text-heading_medium" and text()="Nous avons rencontré un problème."]    ==    Nous avons rencontré un problème.
    Je clique sur //button[text()='Annuler']
    Comment étape 11
    Je clique sur "Modifier Approbateur"
    Sleep    1
    Je clique sur //input[@placeholder="Recherchez dans les Personnes..."]
    Sleep    2
    Je renseigne le champ "Approbateur" avec la valeur ${Approbateur2}
    Je clique sur //lightning-base-combobox-formatted-text[contains(@title,"${Approbateur2}")]
    Je clique sur //button[text()='Enregistrer']
    Comment étape 12
    Scroll To Element    "Détails de l'offre"
    Je clique sur //a//*[contains(text(), '${Nom_Opportunite}')]
    J'attends que l'élément //lightning-input[not(@checked)]//span[text()='Relance Auto'] soit affiché
    Comment étape 13
    Je clique sur "Modifier Adresse d'intervention"
    Type Text    //label[contains(text(), "Adresse d'intervention")]/..//textarea    ${Adresse}
    Je renseigne la valeur "${Ville}" sous le champ "Ville d'intervention"
    Je renseigne la valeur "${Cp}" sous le champ "Cp intervention"
    Sleep    1
    Je clique sur //button[@name='SaveEdit']
    Sleep    5
    Comment étape 14
    Je clique sur "Fermer ${Nom_Opportunite} | Opportunité"


    ###############################
    Sleep    5
    Je clique sur //button[contains(@title, 'Modifier Envoyer le devis via Salesforce ?')]
    Sleep    3
    Je clique sur //button[contains(@aria-label, 'Envoyer le devis via Salesforce ?')]
    Sleep    1
    Je clique sur //lightning-base-combobox-item[contains(@data-value, 'No')]
    Sleep    3
    Je clique sur //button[@name='SaveEdit']
    Sleep    5

    Comment etape 17
    Je clique sur //button[contains(text(), 'Soumettre pour approbation')]
    Sleep    3
    Je renseigne le champ //div[*/span[text()='Commentaires']]/..//textarea avec la valeur ${Commentaire}
    Sleep    1
    Je clique sur //h2[text()='Soumettre pour approbation']/../..//button[text()='Suivant']
    Sleep    3
    Je clique sur //button[contains(text(), 'Terminer')]
    Sleep    10

    Comment etape 18
    Scroll To Element    "TVA, facturation et délai de paiement"
    Je clique sur //header[.//div//span[contains(text(), 'Historique des approbations')]]/../div//a
    Je clique sur //a[@title='Rappeler']
    Sleep    2
    Je clique sur //button[./span[contains(text(), 'Rappeler')]]
    Sleep    3

    Comment etape 19
    Scroll To Element    "Identification du client"
    Je clique sur "Modifier Approbateur"
    Sleep    2
    Je clique sur //div[div/input[@data-value='${Approbateur2}']]/following-sibling::div//button[@title='Effacer la sélection'] >> nth=0
    Sleep    1
    Je clique sur //input[@placeholder="Recherchez dans les Personnes..."]
    Sleep    2
    Je renseigne le champ "Approbateur" avec la valeur ${Approbateur3}
    Je verifie la presence de //lightning-base-combobox-formatted-text[contains(@title,"${Approbateur3}")]/../../span[2]
    Je clique sur //lightning-base-combobox-formatted-text[contains(@title,"${Approbateur3}")]
    Je clique sur //button[text()='Enregistrer']


    ###############################



    # Je clique sur "Générer un document"
    # Sleep    5
    # ${iframe} =     Get Attribute    (//iframe[@title='accessibility title'])[1]    name
    # # ${ErreurGenerationDocument}    Get Element Count    iframe[name="${iframe}"] >>> //div[contains(text(),'Désolé, une erreur')]    ==    0
    # ${ErreurGenerationDocument}    Get Element Count    iframe[name="${iframe}"] >>> //div[contains(text(),'Désolé, une erreur')]
    # Take Screenshot    filename=EMBED

    # Comment    étape 17
    # ${latest_pdf_file}    Get Latest Pdf File    ${CURDIR}/../../Tests/Resources/data/
    # pdf_verification_23577    ${latest_pdf_file}
    # Sleep    5