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
${Nom_Compte}    BNP Paribas Fortis Film Finance
${Relation_Client}    Avenant 
${Description_Operation}    test
${Duree_Du_Chantier}    6 
${Montant_Des_Travaux}    1500
${Destination_Ouvrage}    Structure provisoire et démontable 
${Categorie_Operation}    1
${Stade_Avancement}    Conception  
${Nom_Business}    0796004 BTS Bouche Du Rhone      
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Categorie_Objet}    Immobilier
${Type_travaux}    Travaux neufs
${Prestation1}    EOLEGC
${Prestation2}    EL-CONS
${SourcePrincipale}    F&A - FR BVC - Challenge BV à la carte
${Domaine}    bureau


*** Test Cases ***
23581
    Comment    étape 1
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    Comment étape 2
    Je lance l'application ${Application} ${Navigation}
    Comment étape 3
    Sleep    2
    Fill Text    text=Nom du compte : >> nth=1    BNP Paribas Fortis Film Finance
    Sleep    3
    Keyboard Key    press    Enter
    Sleep    1
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Compte}']] >> nth=0
    Sleep    2
    Je clique sur "Effacer la sélection" >> nth=1
    Sleep    2
    Je renseigne la valeur "${Nom_Business}" sous le champ "Centre Budgétaire"
    Sleep    2
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${Nom_Business}']] >> nth=0
    Sleep    2
    Fill Text    xpath=(//input[@placeholder='Recherchez dans cette liste...'])[1]    Test AUTO - emailtestautocgi@gmail.com
    Sleep    3
    Keyboard Key    press    Enter
    Sleep    2
    Je clique sur (//span[@class='slds-checkbox_faux'])[3]
    Sleep    3
    Fill Text    xpath=(//input[@placeholder='Recherchez dans cette liste...'])[2]    test acn
    Sleep    3
    Keyboard Key    press    Enter
    Sleep    2
    Je clique sur (//span[@class='slds-checkbox_faux'])[5]
    Sleep    2
    Je clique sur "Suivant" >> nth=1
    Sleep    5
    Comment    étape 4
    Je renseigne la valeur "${SourcePrincipale}" sous le champ "Source principale de campagne"
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${SourcePrincipale}']]
    Sleep    2
    Je clique sur (//span[@class='slds-radio_faux'])[3]
    Sleep    2
    Je clique sur "Suivant" >> nth=1
    Sleep    3
    Comment    étape 4
    Je renseigne la valeur "${Domaine}" sous le champ "Domaine d'intervention"
    Sleep    2
    Je clique sur "Suivant" >> nth=1
    Sleep    5
    Comment    étape 4
    Je clique sur //label[contains(@class, 'slds-radio')][.//*[contains(text(), 'Une prestation Contrôle Technique')]]
    Sleep    1
    Je renseigne la valeur "${Description_Operation}" sous le champ "Description de l'opération"
    Sleep    2
    Je renseigne la valeur "${Montant_Des_Travaux}" sous le champ "Montant des travaux (en euros)"
    Je renseigne la valeur "${Duree_Du_Chantier}" sous le champ "Durée du chantier (en mois)"
    Sleep    1
    Je sélectionne la valeur ${Type_travaux} dans la liste select[name="screen_WorkType"]
    Sleep    1
    Je sélectionne la valeur ${Stade_Avancement} dans la liste select[name="screen_WorkProgress"]
    Sleep    2
    Je sélectionne la valeur ${Categorie_Operation} dans la liste select[name="screen_OperationCategory"]
    Sleep    2
    Je clique sur "Suivant" >> nth=1
    Sleep    5
    Je clique sur "Suivant" >> nth=1
    Sleep    20
    Comment    étape 4
    Sleep    20
    ${iframe} =     Get Attribute    (//iframe[@title='accessibility title'])[1]    name
    # Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0
    Comment étape 3
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation1}
    END
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> [id="search"] >> nth=3
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner et ajouter plus" >> nth=0
    Comment étape 3
    Sleep    5
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Sleep    2
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("UO (1UO = 1h)")) >> nth=0    2
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("GED")) >> nth=0
    sleep       2
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    10
    Comment etape 10
    ${allInputs_RechercheDesProduits}=    Get Elements    iframe[name="${iframe}"] >>> input[placeholder='Recherche des produits']
    FOR    ${RechercheDesProduits}    IN    @{allInputs_RechercheDesProduits}
        Run Keyword And Ignore Error    Type Text    ${RechercheDesProduits}   ${Prestation2}
    END
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> [id="search"] >> nth=3
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Sleep    3
    Comment etape 11
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    # Je sélectionne la valeur Bureaux Services dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Nature d’établissement")) >> nth=0
    Sleep    2
    Je sélectionne la valeur Non renseigné dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Comptage électrique")) >> nth=0
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    Sleep    2
    # Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Superficie"))
    ${allCheckbox_Superficie}=    Get Elements    iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Superficie"))
    FOR    ${checkboxSuperficie}    IN    @{allCheckbox_Superficie}
        ${status}=      Run Keyword And Return Status    Je clique sur ${checkboxSuperficie}
        Exit For Loop If    '${status}' == 'True'  
    END
 
    Je clique sur iframe[name="${iframe}"] >>> [name="Superficie"] >> "0,00" >> nth=0
    Type Text   iframe[name="${iframe}"] >>> [name="Superficie"] >> [id="myinput"] >> nth=0    250
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    8
    Comment etape 11
    Modification Devis ligne FDOSC avec prix 0
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    10
    Comment etape 12
    Scroll To Element    "TVA, facturation et délai de paiement"    
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1 Journée']/../../..//lightning-formatted-text    ==    EUR 1 200,00
    Get Text    //span[@class='test-id__field-label' and text()='Vacation supplémentaire 1/2 Journée']/../../..//lightning-formatted-text     ==    EUR 700,00
    Sleep    3
    # champ revion des prix n'est pas visivle
    ${count}=    Get Element Count    text="Revision des prix"
    Should Be Equal As Integers    ${count}    0
    Sleep    3
    Comment etape 5
    Je clique sur //button[contains(@class,'slds-button slds-button_icon-border-filled')]//lightning-primitive-icon
    Je clique sur //span[text()='Dupliquer le Devis']
    Sleep    20
    Comment etape 6
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    20
    Comment etape 7
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    20
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    10
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    10
    Je clique sur "Une prestation Contrôle Technique"
    Sleep    10
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    10
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    20
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    20
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    10





    

    

    



    