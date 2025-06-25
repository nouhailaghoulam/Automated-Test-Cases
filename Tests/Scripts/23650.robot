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
${Nom_Business}    0796004
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Origine_piste}    Appel entrant
${Montant_Des_Travaux}    2100
# ${VRD}    Hors VRD 
${Domaine}    Publique
${Description_Operation}    test
${Type_travaux}    Travaux neufs 
${Stade_Avancement}    Conception  
${Categorie_Operation}    1
${Categorie_Etablissement}    Habitation
${Type_ERP}    REF Refuge de montagne
${Installation_Electrique}    Basse Tension à puissance limitée (P<=36 KvA)
${Prestation}    COPRECMI
${Reference_Consult}    test

*** Test Cases ***
23650
    Comment    etape 2.1
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    ##################################################
    Fermer tous les onglets
    Comment etape 2.2
    Je lance l'application ${Application} ${Navigation}
    ###################################################
    Comment etape 2.3
    Je clique sur "${Nom_Compte}"
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
    Comment etape 2.7
    Je clique sur "Suivant" >> nth=0
    Sleep    10
    Comment etape 2.8
    Je renseigne la valeur "${Nom_Opportunite}" sous le champ "Nom de l'Opportunité"
    Sleep    1
    Je renseigne la valeur "${Domaine}" sous le champ "Domaine d'intervention"
    Sleep    1
    Je sélectionne la valeur ${Origine_piste} dans la liste select[name=screen_OpptySource]
    Je clique sur "Suivant" >> nth=0
    Sleep    10
    Comment etape 2.9
    Je clique sur "Une prestation Contrôle Technique"
    Sleep    1
    Comment etape 2.10
    Je renseigne la valeur "${Description_Operation}" sous le champ "Description de l'opération"
    Sleep    1
    Je renseigne la valeur "${Montant_Des_Travaux}" sous le champ "Montant des travaux (en euros)"
    # Sleep    1
    # Je sélectionne la valeur ${VRD} dans la liste select[name="screen_VRD"]
    Sleep    1
    Je sélectionne la valeur ${Type_travaux} dans la liste select[name="screen_WorkType"]
    Sleep    1
    Je sélectionne la valeur ${Stade_Avancement} dans la liste select[name="screen_WorkProgress"]
    Sleep    1
    Je sélectionne la valeur ${Categorie_Operation} dans la liste select[name="screen_OperationCategory"]
    Sleep    2
    Comment etape 2.12
    Je clique sur "Suivant"
    Sleep    5
    Je clique sur "Suivant"
    Sleep    5
    Comment etape 2.13
    # Scroll To Element    "Opportunity Details"    
    # Run Keyword And Continue On Failure    Get Text    //span[@class='test-id__field-label' and text()='Probabilité (%)']/../../..//lightning-formatted-number >> nth=1   ==    5\xa0%

    Run Keyword And Continue On Failure    Je verifie la presence de //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number[contains(text(), '5')] >> nth=0
    Run Keyword And Continue On Failure    Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//li[contains(@class, 'slds-is-current')]//*[contains(text(), 'Opportunité')]
    
    Sleep    2
    Comment etape 3
    Scroll To Element    "Opportunity Information"    
    Je clique sur "Modifier Référence de la Consultation"
    Je renseigne la valeur "${Reference_Consult}" sous le champ "Référence de la Consultation"
    Je clique sur //button[@name='SaveEdit']
    Comment etape 4.1
    ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    ##################################################
    Sleep    2
    Je clique sur "Devis CPQ (1)"
    Sleep    2
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..    
    Comment etape 4.3
    Get Text    lightning-formatted-text:below(:text('Conditions préalables pour soumettre ou envoyer le devis')) >> nth=0    ==    1/6 - Les Prestations et Prix doivent être complétés
    Comment etape 4.4
    Je clique sur //div[p[contains(text(), 'Opportunité')]]//a
    Scroll To Element    "Opportunity Details"    
    Run Keyword And Continue On Failure    Get Text     //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number >> nth=0    ==    25\xa0% 
    Sleep    2
    Comment etape 5
    Scroll To Element    "Opportunity Information" 
    Sleep    2
    Je clique sur "Devis CPQ (1)"
    Sleep    2
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..    
    Sleep    2
    Je clique sur "Modifier les lignes"
    Sleep    5
    Comment etape 6
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
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Sleep    3
    Comment etape 7
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("SEI")) >> nth=0  
    Sleep    2
    Comment etape 8
    Je clique sur iframe[name="${iframe}"] >>> "Missions Connexes" >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("DiagVent")) >> nth=0  
    Je clique sur iframe[name="${iframe}"] >>> span:left-of(:text("DiagVent")) >> nth=0 
    Sleep    2
    Comment etape 9
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Diagvent 1 : Vérification de la complétude et de la bonne mise en route de l’installation de ventilation selon le protocole « DiagVent »")) >> nth=0  
    Je clique sur iframe[name="${iframe}"] >>> span:left-of(:text("Diagvent 1 : Vérification de la complétude et de la bonne mise en route de l’installation de ventilation selon le protocole « DiagVent »")) >> nth=0 
    Sleep    2
    Comment etape 10
    Je clique sur iframe[name="${iframe}"] >>> span:below(:text("Commentaire")) >> nth=0
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    Test
    Je clique sur iframe[name="${iframe}"] >>> paper-button:not(#pcSave):has-text("Enregistrer")
    Je clique sur iframe[name="${iframe}"] >>> paper-tab:right-of(:text("Détails de la prestation")) >> nth=0
    Sleep    2
    Comment etape 11
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Vérification des performances de l’installation de ventilation")) >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Comment etape 12
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Comment etape 13 & 14
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    10
    Comment etape 15
    Modification Devis ligne Diagvent 1 : Vérification de la avec prix 10
    Comment etape 16
    Modification Devis ligne Vérification des performances avec prix 10
    Comment etape 17
    Modification Devis ligne Allongement de la durée des travaux avec prix 10
    Comment etape 18
    Modification Devis ligne FDOSC avec prix 0
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    # Affiche une poppup rouge et ne passe pas a la page suivante
    Sleep    10
    Comment etape 19
    # ajuster le xpath selon notre test
    # Scroll To Element    "TVA, facturation et délai de paiement"
    # Get Text     //lightning-formatted-text[text()='EUR 1 200,00'] [2]
    # Get Text    //lightning-formatted-text[text()='EUR 700,00'] [2]
    ${allOngletsDetails}=    Get Elements    //li[@title='Détails']
    FOR    ${OngletDetails}    IN    @{allOngletsDetails}
        Run Keyword And Ignore Error    Je clique sur ${OngletDetails}
    END
    Scroll To Element    "TVA, facturation et délai de paiement"    
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1 Journée']/../../..//lightning-formatted-text    ==    EUR 1 200,00
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1/2 Journée']/../../..//lightning-formatted-text     ==    EUR 700,00
    Comment etape 20
    # Je clique sur "Générer un document"