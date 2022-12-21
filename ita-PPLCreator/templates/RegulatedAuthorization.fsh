{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}


Instance: auth-for-{{ row["ID_PRODOTTO_FARMACEUTICO"]| lower | regex_replace('[^A-Za-z0-9]+', '')|create_hash_id }}
InstanceOf: PPLRegulatedAuthorization
Title: "Regulated Authorization for {{ row["ID_PRODOTTO_FARMACEUTICO"] }}"
Description: "Regulated Authorization for {{ row["ID_PRODOTTO_FARMACEUTICO"] }}"
Usage: #example

* id = "{{row['ID_PRODOTTO_FARMACEUTICO']}}" 

//* identifier.system = $spor-prod
* identifier.value = "{{ row["ID_PRODOTTO_FARMACEUTICO"] }}"
* identifier.use = #official

// Reference to MedicinalProductDefinition:

//MPD
* subject = Reference(mp{{ row["CODICE_MEDICINALE"]| regex_replace('[^A-Za-z0-9]+', '')  }})


* type = $220000000060#220000000061 "Marketing Authorisation"
* region = $100000000002#100000000430 "Italian Republic"
* status = $100000072049#100000072099  "Valid"


* statusDate = "{{ row["DATA_EFFICACIA_AUTOR"]|format_datetime(format_="%d/%m/%Y") }}"
{{ "// ERROR[3] - no statusDate INDEX:{}".format(index+1) if row["DATA_EFFICACIA_AUTOR"]|string == "nan" }}

* holder = Reference({{ row['ORG_ID'] }})

{%- endif %}

{%- endfor %}


