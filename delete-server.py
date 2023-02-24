import requests


URL_BASE = "http://fhir.hl7.pt:8080/fhir/"


RESOURCES_TO_DELETE = [
    "Composition",
    "Ingredient",
    "PackagedProductDefinition",
    "AdministrableProductDefinition",
    "RegulatedAuthorization",
    "ManufacturedItemDefinition",
    "Organization",
    "MedicinalProductDefinition",
]
h = {"Cache-Control": "no-cache", "Pragma": "no-cache"}
for resource in RESOURCES_TO_DELETE:
    print("Deleting {}...".format(resource))
    url = URL_BASE + resource
    data = requests.get(url + "?_count=500", headers=h)
    # print(data.json())
    if "entry" in data.json().keys():
        for entry in data.json()["entry"]:
            # print(entry)
            r = requests.delete(
                url + "/" + entry["resource"]["id"] + "?_cascade=delete"
            )
            # print(r.status_code)
            if r.status_code in [409, 400]:
                print(r.text)
    #   print()
    else:
        print("No entries found for {}".format(resource))
