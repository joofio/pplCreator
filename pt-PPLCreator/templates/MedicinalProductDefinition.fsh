{% for index,row in data["data"]["Titular-Medicine"].iterrows() %}

{% set ns = namespace() %}

{% set ns.atc_ema = row["Código ATC\n(ATC code)"]|string %}
{% set ns.atc_spor = row["ATC-RMS ID 1.13.3"]|string %}

Instance: mp-{{ row["MED ID"]}}
InstanceOf: PPLMedicinalProductDefinition
Title: "Medicinal Product {{row["Nome PMS"]}}"
Description: "{{row["Nome PMS"]}} ({{ row["MED ID"]}})"
Usage: #example

//* id = "{{row['id']}}" 

// MPID ID??
//* identifier[pmsid].value = 
//* identifier[mpid].value = 

* type = http://hl7.org/fhir/medicinal-product-type#MedicinalProduct "Medicinal Product"

* domain = $100000000004#100000000012 "Human use"

* status.coding[0] = $200000005003#200000005005 "Provisional"


* legalStatusOfSupply = $100000072051#100000072084 "Medicinal Product subject to medical prescription"

//* combinedPharmaceuticalDoseForm = ""

{% for idx in range(0,ns.atc_ema.count(";")+1) %} 

* classification[+] = $who-atc#{{ ns.atc_ema.split(";")[idx]|trim}} ""
* classification[atc][+].coding[ema] = $100000093533#{{ ns.atc_spor.split(";")[idx]|trim}} ""

{%- endfor %}




* name.productName = "{{ row["Nome PMS"]  }}"
* name.part[invented].part = "{{ row["Full name 1.14.1"]  }}"
* name.part[strength].part = "{{ row["Dosagem \n(Dosege)"]  }}"
* name.part[doseForm].part = "{{ row["Forma Farmacêutica \n(Pharmaceutical form)"]  }}"

* name.usage.country.coding[ema].code = #100000000501
* name.usage.country.coding[ema].display = "Portuguese Republic"

{%- endfor %}
