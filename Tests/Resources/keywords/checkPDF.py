import re
from pypdf import PdfReader
import pymupdf
import requests
import time
import os
import logging
logger = logging.getLogger(__name__)


def pdf_verification(path):
    flag_assertionFailed = False
    pdf_reader = PdfReader(path)
    content = ""

    for page in range(len(pdf_reader.pages)):
        content += pdf_reader.pages[page].extract_text()

    # Vérification des titres
    titles = [
        "TARIF",
        "PÉRIMÈTRE DES PRESTATIONS",
        "RECAPITULATIF\\s*DES\\s*PRESTATIONS\\s*PROPOSÉES",
        "POUR COMMANDER",
        # "DURÉE DU CONTRAT",
        "CONTENU DES PRESTATIONS",
        "RÉALISATION DES PRESTATIONS",
        "REMISE DES LIVRABLES",
        "DISPOSITIONS A PRENDRE PAR LE CLIENT",
        "SÉCURITÉ ET PLAN DE PRÉVENTION",
        "MODALITÉS DE PAIEMENT ET FACTURATION",
        "ANNEXES"
    ]

    for title in titles:
        regex_pattern = re.escape(title).replace("\\\\s\\*", "\\s*")
        regex = re.compile(regex_pattern, re.IGNORECASE | re.DOTALL)
        if not re.search(regex, content):
            logger.error(f"Le titre '{title}' n'a pas été trouvé dans le document.")
            flag_assertionFailed = True
        else:
            logger.info(f"Le titre '{title}' a été trouvé dans le document.")
        
    # # Vérification des phrases
    # phrases = [
    #     " Conditions Générales de services Bureau Veritas Exploitation Zone France (CGSF-BVE)",
    # ]

    # for phrase in phrases:
    #     regex_pattern = re.escape(phrase)
    #     regex_pattern = regex_pattern.replace(r'\ ', r'\s*')  # Autorise plusieurs espaces
    #     regex_pattern = regex_pattern.replace(r'\(', r'\(')  # Échappe les parenthèses
    #     regex_pattern = regex_pattern.replace(r'\)', r'\)')  # Échappe les parenthèses
    #     regex = re.compile(regex_pattern, re.IGNORECASE | re.DOTALL)
    #     if not re.search(regex, content):
    #         logger.error(f"La phrase '{phrase}' n'a pas été trouvée dans le document.")
    #         flag_assertionFailed = True
    #     else:
    #         logger.info(f"La phrase '{phrase}' a été trouvée dans le document.")

    # # Vérification des liens
    # pdf_document = pymupdf.open(path)
    # all_links = []

    # for page_num in range(len(pdf_document)):
    #     page = pdf_document.load_page(page_num)
    #     links = page.get_links()
    #     all_links.extend(links)

    # for link in all_links:
    #     url = link.get('uri', '')
    #     if url:
    #         try:
    #             response = requests.get(url)
    #             if response.status_code == 200:
    #                 logger.info(f"Link OK: {url}")
    #             else:
    #                 logger.warning(f"Link broken - Status {response.status_code}: {url}")
    #         except requests.RequestException as e:
    #             logger.error(f"Error checking link {url}: {e}")
    #             flag_assertionFailed = True
    #     else:
    #         logger.warning("Empty or invalid URL found")

    # # Vérification des formats
    # regex_decimals = re.compile(r"\(TTC\) +: +[0-9]+,[0-9]{2} +€")
    # if re.search(regex_decimals, content):
    #     logger.info(f"Le format des décimales TTC a été trouvé.")
    # else:
    #     logger.error(f"Le format des décimales TTC n'a pas été trouvé.")
    #     flag_assertionFailed = True

    # regex_modalite_paiement = re.compile(
    #     r"Les +prix +sont +revalorisés +annuellement"
    #     + r" +selon +les +termes +du"
    #     + r" +contrat +cadre +Q-[0-9]"
    # )
    # if re.search(regex_modalite_paiement, content):
    #     logger.info(f"La modalité de paiement a été trouvée.")
    # else:
    #     logger.error(f"La modalité de paiement n'a pas été trouvée.")
    #     flag_assertionFailed = True
    
    # if flag_assertionFailed:
    #     raise AssertionError(f"Au moins une erreur est survenue")

        
def get_latest_pdf_file(directory):
    files = [os.path.join(directory, f) for f in os.listdir(directory) if f.endswith('.pdf')]
    latest_file = max(files, key=os.path.getctime)
    return latest_file