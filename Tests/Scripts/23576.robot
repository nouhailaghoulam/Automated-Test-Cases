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
${Duree_Du_Chantier}    6 
${Montant_Des_Travaux}    2100
${Destination_Ouvrage}    Atelier/petite industrie
# ${VRD}    Hors VRD 
${Stade_Avancement}    Conception  
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Prestation}    COPRECBR
${Origine_piste}    Appel entrant
${Domaine}    Publique
${Description_Operation}    test
${Type_travaux}    Travaux neufs    
${Categorie_Operation}    1
${SourcePrincipale}    F&A - FR BVC - Challenge BV à la carte
${Categorie_Etablissement}    Habitation
${Type_ERP}    REF Refuge de montagne
${Installation_Electrique}    Basse Tension à puissance limitée (P<=36 KvA)
${DateIntervention}    31/12/2025
${Type_Echeance1}    A la fin de la phase conception
${Type_Echeance2}    Tous les mois (phase travaux)  
${Type_Echeance3}    A la fin de la phase travaux  
${Amount1}    957
${Amount2}    16633
${Amount3}    204

*** Test Cases ***
23576
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    ##################################################
    Fermer tous les onglets
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
    Sleep    8
    Comment etape 2.9
    Je clique sur "Une prestation Contrôle Technique"
    Sleep    5
    Comment etape 2.10
    Je renseigne la valeur "${Description_Operation}" sous le champ "Description de l'opération"
    Sleep    3
    Je renseigne la valeur "${Montant_Des_Travaux}" sous le champ "Montant des travaux (en euros)"
    Sleep    3
    # Je sélectionne la valeur ${VRD} dans la liste select[name="screen_VRD"]
    # Sleep    1
    Je sélectionne la valeur ${Type_travaux} dans la liste select[name="screen_WorkType"]
    Sleep    1
    Je sélectionne la valeur ${Stade_Avancement} dans la liste select[name="screen_WorkProgress"]
    Sleep    1
    Je sélectionne la valeur ${Categorie_Operation} dans la liste select[name="screen_OperationCategory"]
    Sleep    2
    Comment etape 2.11
    # Verif (cette page ne s'affiche pas)
    Comment etape 2.12
    Je clique sur "Suivant"
    Je clique sur "Suivant"
    Sleep    10
    Comment etape 2.13
    # Scroll To Element    "Opportunity Details"    
    # Run Keyword And Continue On Failure    Get Text    //span[@class='test-id__field-label' and text()='Probabilité (%)']/../../..//lightning-formatted-number >> nth=1   ==    5\xa0%
    # Sleep    2
    # Run Keyword And Continue On Failure    Je verifie la presence de //*[contains(@data-field-id, 'ProbabilityField')]//lightning-formatted-number[contains(text(), '5')] >> nth=0
    # Run Keyword And Continue On Failure    Je verifie la presence de //div[contains(@class, 'windowViewMode-maximized')]//li[contains(@class, 'slds-is-current')]//*[contains(text(), 'Opportunité')]
    Comment etape 3
    Scroll To Element    "Opportunity Details"
    Je clique sur "Modifier Source principale de campagne"
    Je renseigne la valeur "${SourcePrincipale}" sous le champ "Source principale de campagne"
    Je clique sur //lightning-base-combobox-item[.//lightning-base-combobox-formatted-text[@title = '${SourcePrincipale}']]
    Je clique sur //button[@name='SaveEdit']
    Comment etape 4.1
    Scroll To Element    "Opportunity Information"    
    ##################################################
    Creation Devis ${Categorie_Etablissement} ${Type_ERP} ${Installation_Electrique}
    ##################################################
    Sleep    2
    Je clique sur "Devis CPQ (1)"
    Sleep    2
    # A revoir le clique
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
    Sleep    10
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
    Je clique sur iframe[name="${iframe}"] >>> [id="checkboxContainer"] >> nth=2
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> "Sélectionner" >> nth=0
    Sleep    3
    Comment etape 7
    Je clique sur iframe[name="${iframe}"] >>> "Cliquer ici pour compléter ce champ."
    Clear Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0
    Type Text    iframe[name="${iframe}"] >>> [contenteditable="true"] >> nth=0    Renseignement TEST AUTO
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=1
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("STI")) >> nth=0  
    Sleep    2
    Comment etape 8
    Je clique sur iframe[name="${iframe}"] >>> "Missions Connexes" >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("ATT-HAND")) >> nth=0  
    Je clique sur iframe[name="${iframe}"] >>> span:left-of(:text("ATT-HAND")) >> nth=0  
    Comment etape 9
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:right-of(:text("Afficher la date précise")) >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    2 
    Comment etape 10
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("VENT20")) >> nth=0  
    Je clique sur iframe[name="${iframe}"] >>> span:left-of(:text("VENT20")) >> nth=0 
    Comment etape 11
    Je clique sur iframe[name="${iframe}"] >>> sb-datepicker:right-of(:text("Date de l'intervention")) >> nth=0
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    ${DateIntervention}
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:right-of(:text("Afficher la date précise")) >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> sb-option-cell:right-of(:text("Intervention")) >> nth=1
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Je clique sur iframe[name="${iframe}"] >>> paper-button:not(#pcSave):has-text("Enregistrer")
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    2
    Comment etape 12    
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:left-of(:text("CC-VT-PK")) >> nth=0  
    Je clique sur iframe[name="${iframe}"] >>> span:left-of(:text("CC-VT-PK")) >> nth=0 
    Comment etape 13
    Je clique sur iframe[name="${iframe}"] >>> sb-datepicker:right-of(:text("Date de l'intervention")) >> nth=0
    Keyboard Key    press    Control+A
    Keyboard Key    press    Delete
    Keyboard Input    insertText    ${DateIntervention}
    Je clique sur iframe[name="${iframe}"] >>> paper-checkbox:right-of(:text("Afficher la date précise")) >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Comment etape 14
    Je clique sur iframe[name="${iframe}"] >>> "Enregistrer" >> nth=0
    Sleep    15
    Comment etape 15
    Modification Devis ligne COPRECBR avec prix 17794
    Modification Devis ligne ATT-HAND avec prix 10
    Modification Devis ligne CC-VT-PK avec prix 10
    Modification Devis ligne VENT20 avec prix 10
    Modification Devis ligne Allongement de la durée des travaux avec prix 10
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep    10
    Comment etape 16
    Je clique sur "Echéancier"
    Comment etape 17
    Sleep    2
    Je clique sur //span[contains(text(),'COPRECBR')]/../../../../../../..//button[contains(@class, 'slds-button_neutral') and text()='Nouveau']
    Sleep    2
    Je renseigne la valeur "${Type_Echeance1}" sous le champ "Type d'échéance"
    Je clique sur //lightning-base-combobox-formatted-text[@title="A la fin de la phase conception"]
    Sleep    1
        # Je renseigne la valeur "${Amount1}" sous le champ "Amount"
    Type Text    //input[@name='TECH_Amount__c']   ${Amount1}
    Je clique sur //button[@type='submit' and text()='Enregistrer']
    Sleep    5
    Comment etape 18
    Sleep    2
    Je clique sur //span[contains(text(),'COPRECBR')]/../../../../../../..//button[contains(@class, 'slds-button_neutral') and text()='Nouveau']
    Sleep    2
    Je renseigne la valeur "${Type_Echeance2}" sous le champ "Type d'échéance"
    Je clique sur //lightning-base-combobox-formatted-text[@title="Tous les mois (phase travaux)"]
    Sleep    3
    # Je renseigne la valeur "${Amount2}" sous le champ "Amount"
    Type Text    //input[@name='TECH_Amount__c']   ${Amount2}
    Je clique sur //button[@type='submit' and text()='Enregistrer']
    Sleep    5
    Comment etape 19
    Je clique sur //span[contains(text(),'COPRECBR')]/../../../../../../..//button[contains(@class, 'slds-button_neutral') and text()='Nouveau']
    Sleep    2
    Je renseigne la valeur "${Type_Echeance3}" sous le champ "Type d'échéance"
    Je clique sur //lightning-base-combobox-formatted-text[@title="A la fin de la phase travaux"]
    Sleep    2
    # Je renseigne la valeur "${Amount3}" sous le champ "Amount"
    Type Text    //input[@name='TECH_Amount__c']   ${Amount3}
    Je clique sur //button[@type='submit' and text()='Enregistrer']
    Sleep    5
    Comment etape 20
    Je clique sur (//tr[th[@data-cell-value='A la commande'] and td[@data-cell-value='0.2']]//button)[4]
    Je clique sur "Supprimer" >> nth=0
    Sleep    3
    Je clique sur (//tr[th[@data-cell-value='A la phase conception'] and td[@data-cell-value='0.3']]//button)[4] 
    Je clique sur "Supprimer" >> nth=0
    Sleep    3
    Je clique sur (//tr[th[@data-cell-value='Tous les 2 mois (phase travaux)'] and td[@data-cell-value='0.3']]//button)[4]
    Je clique sur "Supprimer" >> nth=0
    Sleep    3
    Comment etape 21
    # Verif
    Je verifie la presence de //tr[th[@data-cell-value='A la fin de la phase conception'] and td[@data-cell-value='0.0538']] 
    Je verifie la presence de //tr[th[@data-cell-value='Tous les mois (phase travaux)'] and td[@data-cell-value='0.9348']]
    Je verifie la presence de //tr[th[@data-cell-value='A la fin de la phase travaux'] and td[@data-cell-value='0.0115']]
    Comment etape 22
    # Je clique sur "Générer un document"
    # Sleep    2