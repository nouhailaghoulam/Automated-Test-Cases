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
${Navigation}    Devis
${NumDevis}    Q-1830348     
${Nom_Opportunite}    NewOpName
${Description_Operation}    test
${Montant_Des_Travaux}    2100
${Reference}    test


*** Test Cases ***
23585
    # Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Enzo}
    Je me connecte a Salesforce avec le user ${USER_SALESFORCE_Robot}
    ########################################################################
    Comment etape 1.1
    Je lance l'application ${Application} ${Navigation}
    Comment etape 4
    Je renseigne le champ //input[@placeholder='Recherchez dans cette liste...'] avec la valeur ${NumDevis}
    Keyboard Key    press    Enter
    Je clique sur //a[contains(@title,'${NumDevis}')]
    Sleep    3
    Comment etape 5
    Je clique sur //button[contains(@class,'slds-button slds-button_icon-border-filled')]//lightning-primitive-icon
    Je clique sur //span[text()='Dupliquer le Devis']
    Sleep    3
    Comment etape 6
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    3
    Comment etape 7
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    3
    Comment etape 8
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    10
    Comment etape 10
    Je renseigne la valeur "${Nom_Opportunite}" sous le champ "Nom de l'Opportunité"
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    3
    Comment etape 11
    Je clique sur "Une prestation Contrôle Technique"
    Sleep    5
    Je renseigne la valeur "${Description_Operation}" sous le champ "Désignation de l'opération"
    Je renseigne la valeur "${Montant_Des_Travaux}" sous le champ "Montant des Travaux (en euros)"
    Sleep    2
    Comment etape 12
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    2
    Comment etape 13
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    5
    Comment etape 14
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep    5
    Comment etape 15
    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep   5
    Run Keyword And Ignore Error    Je clique sur //div[contains(@class, "windowViewMode-normal")]//button[contains(text(), "Suivant")]
    Sleep   5
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Je clique sur iframe[name="${iframe}"] >>> "Ajouter un groupe" >> nth=0
    Sleep    2
    Je clique sur iframe[name="${iframe}"] >>> h2[id='groupHeaderName']
    Keyboard Input    insertText    123456789
    Keyboard Key    press    Enter
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep   10
    Comment etape 16
    Je clique sur "${Nom_Opportunite}"
    Sleep   5
    Scroll To Element    //button[@title='Modifier Référence de la Consultation']
    Je clique sur //button[@title='Modifier Référence de la Consultation']
    Je renseigne le champ //label[text()='Référence de la Consultation']/following::input[@name='GLOBAL_RefRFP__c'] avec la valeur ${Reference}
    Je clique sur //button[@name='SaveEdit']
    Sleep    5
    Comment etape 17
    Je clique sur "Fermer ${Nom_Opportunite} | Opportunité"
    Je clique sur "Modifier les lignes" >> nth=1
    Comment etape 18
    ${iframe} =     Get Attribute    //div[contains(@class,'slds-template_iframe')]/iframe[@title='accessibility title']    name
    Je clique sur iframe[name="${iframe}"] >>> paper-menu-button[id='menuButton']
    Je clique sur iframe[name="${iframe}"] >>> "Cloner le groupe"
    Comment etape 19
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@class, "drawerContainer")] >> nth=0
    Je clique sur iframe[name="${iframe}"] >>> div.container:has(:text("Modification manuelle")) >> div[id="formatted"]
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")] >> nth=0
    Sleep    1
    Je clique sur iframe[name="${iframe}"] >>> div[field="SBQQ__ProductName__c"]:has(:text("FDOSC")) >> xpath=following-sibling::div[contains(@field, "SBQQ__ListPrice__c")] >> nth=0
    Keyboard Input    insertText    0
    Keyboard Key    press    Enter
    Sleep    3
    Je clique sur iframe[name="${iframe}"] >>> paper-button.--desktop:has-text("Enregistrer")
    Sleep   20
    Comment etape 20
