*** Settings ***
Library          Browser
Library          OperatingSystem
Library          ${CURDIR}/../../Tests/Resources/keywords/checkPDF.py
Resource         ${CURDIR}/../../Tests/Resources/env/users.resource
Resource         ${CURDIR}/../../Tests/Resources/keywords/Methodes_Techniques.robot
Resource         ${CURDIR}/../../Tests/Resources/keywords/Methodes_SALESFORCE.robot

*** Variables ***
${Nom_Compte}     BNP Paribas Fortis Film Finance

*** Test Cases ***
Brouillon
    Lancer un nouveau navigateur
    New Page    https://pypi.org/project/robotframework/#files
    # Je clique sur "robotframework-7.2.tar.gz" >> nth=0
    ${href} =    Set Variable    files.pythonhosted.org/packages/04/77/bdd9474f19fad4c285971169342924dae415fb4a5e49a488636acdbec08d/robotframework-7.2.tar.gz
    Log    ${href}
    Download    ${href}    saveAs=${CURDIR}/../../Tests/Resources/data/robotframework-7.2.tar.gz
    File Should Exist    ${CURDIR}/../../Tests/Resources/data/robotframework-7.2.tar.gz
    Sleep    10s