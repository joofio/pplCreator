{% for index,row in data["data"]["Titular-Medicine"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}


Instance: auth-for-{{ row["Nome PMS"]| lower | regex_replace('[^A-Za-z0-9]+', '')|create_hash_id }}
InstanceOf: PPLRegulatedAuthorization
Title: "Regulated Authorization for {{ row["Nome PMS"] }}"
Description: "Regulated Authorization for {{ row["Nome PMS"] }}"
Usage: #example

//* id = "{{row['MED ID']}}" 

//* identifier.system = $spor-prod
//* identifier.value = "{{ row["MED ID"] }}"
//* identifier.use = #official

// Reference to MedicinalProductDefinition: {{ row["MED ID"] }}
* subject = Reference(mp-{{ row["MED ID"]  }})


* type = $220000000060#220000000061 "Marketing Authorisation"
* region = $100000000002#100000000501 "Portuguese Republic"
* status = $100000072049#100000072099  "Valid"


{{ "// ERROR[3] - no statusDate INDEX:{}".format(index+1) }}

* holder = Reference({{ row['Titular AIM - OMS LOC-ID 2.8\n(SPOR-OMS LOC-ID)'] }})

{%- endif %}

{%- endfor %}


