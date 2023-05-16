import requests
from os import listdir
import json


FOLDER = "ee-PPLCreator-v2/fhir-data/fsh-generated/resources"
FOLDER = "pt-PPLCreator/fhir-data/fsh-generated/resources"

SERVER = "http://fhir.hl7.pt:8080/fhir/"


ORDER_LIST = [
    "Organization",
    "MedicinalProductDefinition",
    "ManufacturedItemDefinition",
    "RegulatedAuthorization",
    "AdministrableProductDefinition",
    "Ingredient",
    "PackagedProductDefinition",
]

for item in ORDER_LIST:
    for file in listdir(FOLDER):
        res = file.split("-")[0]
        if res == item:
            f = open(FOLDER + "/" + file)
            data = json.load(f)
            id_ = data["id"]
            x = requests.put(SERVER + "/" + res + "/" + id_, json=data)
            # print(x.status_code)
            if x.status_code == 400:
                print(res)
                print(x.text)
