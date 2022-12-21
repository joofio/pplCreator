{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: mp{{ row["CODICE_MEDICINALE"]| regex_replace('[^A-Za-z0-9]+', '')  }}
InstanceOf: PPLMedicinalProductDefinition
Title: "Medicinal Product {{ row["DENOM_MEDICINALE"]}}"
Description: "{{row["CODICE_MEDICINALE"]}} {{ row["DENOM_MEDICINALE"]}}"
Usage: #example

//* id = "{{row['id']}}" 

// MPID in our example data has been EE-[number from LOC-ID]-[Medication card number]
//* identifier[pmsid].value = "{{row['identifier_pmsid']}}" 
* identifier[mpid].value = "IT-{{row['CODICE_MEDICINALE']}}"

* type = http://hl7.org/fhir/medicinal-product-type#MedicinalProduct "Medicinal Product"

* domain = http://hl7.org/fhir/medicinal-product-domain#100000000012 "Human use"

* status.coding[0] = $200000005003#Valid "Valid"

//{{ "* indication = \"{}\"".format(row.indication) if row.indication|string !="nan"}}

//Default: 200000005004 'Current'
//* legalStatusOfSupply = $100000072051#{{row['statusSuplyID']}} "{{row['statusSuply']}}"
* legalStatusOfSupply = $100000072051#100000072084 "Medicinal Product subject to medical prescription"

* combinedPharmaceuticalDoseForm = $200000000004#{{ row["TRM_ID_200000000004_200000000007 - Pharmaceutical Dose Form/Combined Term"]  }} "{{ row["DESCRIZIONE_FORMA_FARM"]  }}"


* classification[atc].coding[who] = $who-atc##{{ row["CODICE_ATC"]}} "{{ row["DESCRIZIONE_PA"]}}"


* name.productName = "{{ row["DENOM_MEDICINALE"]  }}  {{ row["DESCRIZIONE_FD"]  }}"
* name.namePart[invented].part = "{{ row["DENOM_MEDICINALE"]  }}"
//* name.namePart[strength].part = "{{ row["Ravimi tugevus"]  }}"
* name.namePart[doseForm].part = "{{ row["DESCRIZIONE_FD"]  }}"

* name.countryLanguage.country = $100000000002#100000000430 "Italian Republic"
* name.countryLanguage.language = $100000072057#100000072194  "Italian"

{%- endif %}
{%- endfor %}