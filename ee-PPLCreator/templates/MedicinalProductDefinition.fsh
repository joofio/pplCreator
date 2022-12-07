{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: mp{{ row["Ravimi nimetus"]| regex_replace('[^A-Za-z0-9]+', '')  }}
InstanceOf: PPLMedicinalProductDefinition
Title: "Medicinal Product {{ row["Ravimi nimetus"]}}"
Description: "{{row["Müügiloa number"]}} {{ row["Ravimi nimetus"]}}"
Usage: #example

//* id = "{{row['id']}}" 

// MPID in our example data has been EE-[number from LOC-ID]-[Medication card number]
//* identifier[pmsid].value = "{{row['identifier_pmsid']}}" 
* identifier[mpid].value = "EE-{{row['Müügiloa hoidja organisatsiooni asukoha LOC ID']| replace('LOC-','')}}-{{row['Ravimikaardi number']}}"

* type = http://hl7.org/fhir/medicinal-product-type#MedicinalProduct "Medicinal Product"

* domain = http://hl7.org/fhir/medicinal-product-domain#100000000012 "Human use"

* status.coding[0] = $200000005003#{{ row["Müügiloa staatus"]  }} "{{ row["Müügiloa staatus"]  }}"

//{{ "* indication = \"{}\"".format(row.indication) if row.indication|string !="nan"}}

//Default: 200000005004 'Current'
//* legalStatusOfSupply = $100000072051#{{row['statusSuplyID']}} "{{row['statusSuply']}}"
* legalStatusOfSupply = $100000072051#100000072084 "Medicinal Product subject to medical prescription"

* combinedPharmaceuticalDoseForm = $200000000004#{{ row["Ravimvorm"]|get_data_dictionary_info(200000000004,"RMS termini id","RMS nimi eesti keeles")  }} "{{ row["Ravimvorm"]  }}"


* classification[atc].coding[who] = $who-atc##{{ row["ATC kood"]}} "{{ row["ATC kood"]}}"


* name.productName = "{{ row["Ravimi nimetus"]  }} {{ row["Ravimi tugevus"]  }} {{ row["Manustatav ravimvorm"]  }}"
* name.namePart[invented].part = "{{ row["Ravimi nimetus"]  }}"
* name.namePart[strength].part = "{{ row["Ravimi tugevus"]  }}"
* name.namePart[doseForm].part = "{{ row["Manustatav ravimvorm"]  }}"

* name.countryLanguage.country = $100000000002#100000000388 "Republic of Estonia"
* name.countryLanguage.language = $100000072057#100000072172  "Estonian"

{%- endif %}
{%- endfor %}