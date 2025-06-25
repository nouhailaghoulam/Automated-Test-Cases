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
${Nom_Compte}     CHOC MARKET
${Nom_Business}    0797524       
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Prestation}    EL-VP
${Approbateur}    Ilham YASSINE
${Domaine}    Publique
${Statut}    Opportunité
${Origine_piste}    Appel entrant
${Ville}    Paris
${Adresse}    8 rue de la Comédie
${Cp}    75001
${Type_ERP}    Refuge de montagne
${PERC}    30
${Message}    Bonjour, ceci est un message
${Etendu_prestation}    Ceci est une prestation étendue


*** Test Cases ***
34371
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    #################################################
    Je lance l'application ${Application} ${Navigation}
    ####################################################
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
    # Comment etape 3
    # Scroll To Element    "Opportunity Conclusion"
    # Click    //button[@title='Modifier Durée du contrat (mois)']
    # Sleep    1
    # Je renseigne la valeur "12" sous le champ "Durée du contrat (mois)"
    # Sleep    3
    # Je clique sur //button[@name='SaveEdit']
    # Sleep    10
    Comment etape 5.1
    ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    ##################################################
    Comment etape 5.3
    Je clique sur //a[.//*[contains(text(), 'Devis CPQ')]]
    Sleep    10
    Je clique sur //tr[@class='slds-hint-parent']//a[.//*[contains(text(), 'Q-')]]/..
    Comment etape 6
    Je clique sur "Modifier les lignes" >> nth=0
    Sleep    15
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Log    ${iframe}

    # BOUTON NON NECESSAIRE SELON LES USERS
    # Je clique sur iframe[name="${iframe}"] >>> "Ajouter des prestations" >> nth=0
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
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=1
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Sleep    10
    Comment etape 9
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    ${Etendu_prestation}
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Sleep    5
    Je sélectionne la valeur Bureaux Services dans la liste iframe[name="${iframe}"] >>> select:right-of(:text("Nature d’établissement")) >> nth=0
    Type Text    iframe[name="${iframe}"] >>> input:right-of(:text("Modifier les heures (hors Extensions)")) >> nth=0    2
    
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Bureaux")) >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> [name="Bureaux"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Bureaux"] >> [id="myinput"] >> nth=0    5
    Sleep    1s
    Sleep    1s
    Keyboard Key    press    Tab
    Sleep    1s
    Keyboard Key    press    Enter    #Pour cocher la case "Locaux sociaux"
    # Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("Locaux sociaux")) >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> [name="Locaux sociaux"] >> "0,00" >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [name="Locaux sociaux"] >> [id="myinput"] >> nth=0    5
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    10
    Comment etape 12
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrement rapide")
    Sleep    10
    Comment etape 12
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    10
    Comment etape 13
    Je verifie la presence de "ATTENTION: Le client fait l'objet d'une facturation 100% à la commande, l'échéancier n'est pas modifiable sur ce devis."
    Comment etape 23
    Sleep    5
    Je clique sur "Echéancier"
    Sleep    3
    Comment etape 23
    Je verifie la presence de //tr[th[@data-cell-value='A la commande'] and td[@data-cell-value='1']]
    Sleep    3
    # Vérifier Que Le Bouton Modifier N Existe Pas
    # ${result}=    Get Element Count    text="Modifier"
    # Should Be Equal As Integers    ${result}    0
    # Wait For Elements State    Xpath=//span[contains(text(),'${Prestation}')]/../../../../../../../../..//tbody//button[@aria-haspopup='true'] >> nth=0    hidden    timeout=10s
    Comment etape 12
    Reload
    Sleep    5
    Je clique sur //button[contains(@title, 'Modifier Envoyer le devis via Salesforce ?')]
    Sleep    3
    Je clique sur //button[contains(@aria-label, 'Envoyer le devis via Salesforce ?')]
    Sleep    1
    Je clique sur //lightning-base-combobox-item[contains(@data-value, 'No')]
    Sleep    4
    Je clique sur //button[@name='SaveEdit']
    Sleep    5
    Je clique sur //button[contains(text(), 'Passer au statut "émis"')]
    Sleep    2
    Je clique sur //footer//button/span[contains(text(), 'Enregistrer')]
    Sleep    5
    Je clique sur //a[@data-tab-name='Accepted']
    Sleep     2
    Je clique sur //span[text()='Marquer Statut en cours']
    Sleep       3
    Je clique sur //div[p[contains(text(),'Opportunité')]]//a
    Sleep       3
    Reload
    Sleep       8
    # Scroll To Element   //span[text()='Référence du devis']   
    # Sleep       3 
    # Je verifie la presence de //input[starts-with(@value, 'WR-Q-')]



 # //lightning-formatted-text[text()='WR-Q-1835036']