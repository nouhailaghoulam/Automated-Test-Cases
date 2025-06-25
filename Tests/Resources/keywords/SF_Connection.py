import re
import logging
import subprocess
logger = logging.getLogger(__name__)


def getAuthenticatedSalesforceURL():
    """
    Cette fonction exécute la connexion à l'org Salesforce via JWT et récupère l'URL de l'org.
    
    Returns:
    str: L'URL d'accès à l'org Salesforce si tout se passe bien, sinon un message d'erreur.
    """
    # Première commande : connexion à l'org Salesforce avec JWT
    login_command = "sf org login jwt --username menad.chabi.ext@bureauveritas.com.uat --jwt-key-file ./Tests/Resources/data/server.key --client-id 3MVG931doue2KUvx99U1uvH8e_.CykFNNrHrwb7KGCmgTTepVmm7eK4NWYuslNxIEjBlgh_oxsvbCeIheMYkX"

    # Exécuter la commande de connexion
    login_process = subprocess.run(login_command, shell=True, capture_output=True, text=True)
    # Afficher la sortie de la première commande
    logger.info("Sortie de la commande de connexion :")
    logger.info(login_process.stdout)

    # Vérifier si la connexion a réussi
    if login_process.returncode != 0:
        logger.error("Erreur lors de la connexion.")
        logger.error(login_process.stderr)
        raise AssertionError(f"FAILED -- Commande 'sf org login jwt' EN ERREUR")


    # Deuxième commande : ouverture de l'interface Lightning dans l'org Salesforce
    open_command = "sf org open --path lightning -o menad.chabi.ext@bureauveritas.com.uat -r"

    # Exécuter la commande et capturer la sortie
    open_process = subprocess.run(open_command, shell=True, capture_output=True, text=True)

    # Récupérer la sortie et chercher l'URL dans le texte
    output = open_process.stdout
    # print(output)
    # Utilisation d'une expression régulière pour extraire l'URL
    url_pattern = r"https://[^\s]+"
    url_match = re.search(url_pattern, output)

    if url_match:
        return url_match.group(0)  # Retourner l'URL trouvée
    else:
        raise AssertionError(f"FAILED -- URL non trouvée dans la sortie de la commande 'sf org open'")