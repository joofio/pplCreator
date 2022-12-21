{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: mp{{ row["productname"]| regex_replace('[^A-Za-z0-9]+', '')  }}
InstanceOf: PPLMedicinalProductDefinition
Title: "Medicinal Product {{ row["productname"]}}"
Description: "EU/1/97/049/001 {{ row["productname"]}}"
Usage: #example

* id = "{{row['id']}}" 

* identifier[pmsid].value = "{{row['identifier_pmsid']}}" 
* identifier[mpid].value = "{{row['identifier_mpid']}}" 

* type = http://hl7.org/fhir/medicinal-product-type#{{row['typeID']}} "{{row['type']}}"

* domain = http://hl7.org/fhir/medicinal-product-domain#{{row['domainID']}} "{{row['domain']}}"

* status.coding[0] = $200000005003#{{ row["status"]  }} "{{ row["status"]  }}"

{{ "* indication = \"{}\"".format(row.indication) if row.indication|string !="nan"}}


* legalStatusOfSupply = $100000072051#{{row['statusSuplyID']}} "{{row['statusSuply']}}"

* combinedPharmaceuticalDoseForm = $200000000004#{{ row["combinedPharmaceuticalDoseFormID"]  }} "{{ row["combinedPharmaceuticalDoseFormID"]  }}"

{% if row["classification_atc_ema"]|string != 'nan' %}
{% for idx in range(0,row["classification_atc_ema"].count("|")+1) %} 

* classification[atc].coding[ema] = $100000093533#{{ row["classification_atc_ema"].split("|")[idx]}} "{{ row["classification_atc_ema_texts"].split("|")[idx]}}"

{%- endfor %}
{%- endif %}

{% if row["classification_atc_who"]|string != 'nan' %}
{% for idx in range(0,row["classification_atc_who"].count("|")+1) %} 

* classification[atc].coding[who] = $who-atc#{{ row["classification_atc_who"].split("|")[idx]}} "{{ row["classification_atc_who_texts"].split("|")[idx]}}"

{%- endfor %}
{%- endif %}


* name.productName = "{{ row["productname"]  }}"
* name.namePart[invented].part = "{{ row["inventedNamePart"]  }}"
* name.namePart[strength].part = "{{ row["StrengthPart"]  }}"
* name.namePart[doseForm].part = "{{ row["PharmaceuticalDosePart"]  }}"

* name.countryLanguage.country = $100000000002#{{ row["countryCode"]  }} "{{ row["country"]  }}"
* name.countryLanguage.language = $100000072057#{{ row["languageID"]  }}  "{{ row["language"]  }}"
  

{%- endif %}
{%- endfor %}