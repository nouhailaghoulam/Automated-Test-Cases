*** Settings ***
Library          Browser
Library          ${CURDIR}/../../Tests/Resources/keywords/checkPDF.py
Library          ${CURDIR}/../../Tests/Resources/keywords/SF_Connection.py
Resource         ${CURDIR}/../../Tests/Resources/env/users.resource
Resource         ${CURDIR}/../../Tests/Resources/env/env.resource
Resource         ${CURDIR}/../../Tests/Resources/or/OR.resource
Resource         ${CURDIR}/../../Tests/Resources/keywords/Methodes_Techniques.robot
Resource         ${CURDIR}/../../Tests/Resources/keywords/Methodes_Salesforce.robot

*** Variables ***
${Nom_Compte}     SOS OXYGENE NORMANDIE
${AccordCadre}     ""
${Nom_Business}    0797524       
${Nom_Contact}    Test AUTO - emailtestautocgi@gmail.com
${Nom_Opportunite}    MyNewOp
${Categorie_Etablissement}    Habitation
${Installation_Electrique}    Non renseigné
${Categorie_Objet}    Immobilier
${Type_Objet}    Commerce
${Prestation1}    EL-IN
${Prestation2}    EL-CONS
${Approbateur}    Ilham YASSINE

*** Test Cases ***
BV_AzurePipelineTest
    ${URL_SALESFORCE_Logged}    getAuthenticatedSalesforceURL
    Lancer un nouveau navigateur
    Comment etape 1.1
    New Page    ${URL_SALESFORCE_Logged}
    Sleep    5
    Go To    ${URL_SALESFORCE}
    DEBUG - Screenshot
    Comment etape 1.2
    # Se connecter avec le user ${USER_SALESFORCE_001}
    Sleep    10
    # Fermer tous les onglets
    Log    ${CURDIR}
    ${latest_pdf_file}    Get Latest Pdf File    ${CURDIR}/../../Tests/Resources/data/
    Log    ${latest_pdf_file}
    Pdf Verification    ${latest_pdf_file}