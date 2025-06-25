*** Variables ***

#    NAVIGATOR SETTINGS :
${HEADLESS}=            False
${NAVIGATOR}=           chromium
${NAV_ARGS}=            ["--disable-notifications"]
${NAV_W}=               1920  
${NAV_H}=               1080
${NAV_LOC}=             fr-FR
${NAV_timeout}=         20 seconds

#    GENERAL TEST EXECUTION SETTINGS : 
${TAKE_SCREENSHOTS}     True

#Activer/Desactiver les keywords des smoke tests
${DEBUG} =    True