*** Settings ***
Library    Browser
Library    Collections
Library    DateTime

# Environnement & paramètres généraux : 
Resource  ${CURDIR}/../settings/settings.resource

Documentation    Ce fichier contient les mots-clés techniques communs entre les tests

*** Variables ***
${timeout} =    30s

*** Keywords ***

Use Existing Browser
    Run Keyword If    '${DEBUG}'=='True'    Connect To Browser    wsEndpoint=http://127.0.0.1:9222    browser=chromium    use_cdp=True
 

Lancer un nouveau navigateur
    New Browser    ${NAVIGATOR}    headless=${HEADLESS}  timeout=${NAV_timeout}  args=${NAV_ARGS}
    
    #Definition du context suivant les variables de la taille de la fenêtre du navigateur dans les options "settings.resource"
    ${WH_SET}=  Set Variable If  "${NAV_W}" == "${EMPTY}" and "${NAV_H}" == "${EMPTY}"  False  True
    Run Keyword If  ${WH_SET}   New Context  viewport={'width': ${NAV_W}, 'height': ${NAV_H}}  locale=${NAV_LOC}    acceptDownloads=True
    Run Keyword If  not ${WH_SET}  New Context  viewport=${None}  locale=${NAV_LOC}    acceptDownloads=True
    Set Browser Timeout  ${NAV_timeout}
    
Je clique sur ${element}
    Wait For Elements State    ${element}    visible    ${timeout}
    Wait For Elements State    ${element}    enabled    ${timeout}
    Click    ${element}
    Take Screenshot    filename=EMBED
    
J'attends que l'élément ${element} soit affiché
    Wait For Elements State   ${element}    visible    ${timeout}
    Take Screenshot    filename=EMBED

Je renseigne le champ ${selector} avec la valeur ${input}
    Type Text   ${selector}    ${input}    delay=50 ms
    Take Screenshot    filename=EMBED

Je sélectionne la valeur ${value} dans la liste ${list}
    Select Options By    ${list}  text    ${value}
    Take Screenshot    filename=EMBED

Je sélectionne la valeur numéro ${value} dans la liste ${list}
    Select Options By    ${list}  value    ${value}
    Take Screenshot    filename=EMBED

Je verifie la presence de ${field}
    Wait For Elements State    ${field}    visible
    Take Screenshot    filename=EMBED

Je renseigne la valeur "${value}" sous le champ ${field}
    ${xpath} =    Set Variable    input:below(:text(${field})) >> nth=0
    Run Keyword And Ignore Error    Scroll To Element    ${xpath}
    Type Text   ${xpath}   ${value}
    Take Screenshot    filename=EMBED

Je renseigne la valeur "${value}" à droite du champ ${field}
    ${xpath} =    Set Variable    input:right-of(:text(${field})) >> nth=0
    Run Keyword And Ignore Error    Scroll To Element    ${xpath}
    Type Text   ${xpath}   ${value}
    Take Screenshot    filename=EMBED

Je clique sous le champ ${field}
    ${xpath} =    Set Variable    input:below(:text(${field})) >> nth=0
    Run Keyword And Ignore Error    Scroll To Element    ${xpath}
    Click    ${xpath}
    Take Screenshot    filename=EMBED

#DEBUG TESTS
DEBUG - Screenshot
    Run Keyword If    '${DEBUG}'=='True'    Run Keyword And Continue On Failure    Take Screenshot    filename=EMBED

Comment ${commentaire}
    BuiltIn.Comment    ${commentaire}
    Take Screenshot    filename=EMBED
