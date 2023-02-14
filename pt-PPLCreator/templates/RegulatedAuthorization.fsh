{% for index,row in data["data"]["Package"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}


{% set ns = namespace() %}
{% set ns.auth_name = row["MED ID"]|get_data_from_sheet(data["data"],"Titular-Medicine","Nome PMS","MED ID") %}
{% set ns.auth_pack =  row["Package description  4.2"] %}
{% set ns.auth_id= ns.auth_name ~ ns.auth_pack   %}


Instance: auth-{{ns.auth_id|create_hash_id}}
InstanceOf: PPLRegulatedAuthorization
Title: "Regulated Authorization for {{ ns.auth_name }} {{ ns.auth_pack }}"
Description: "Regulated Authorization for {{ ns.auth_name }} {{ ns.auth_pack }}"
Usage: #example

//* id = "{{row['MED ID']}}" 

//* identifier.system = $spor-prod
* identifier.value = "{{ row["Nº de Registo"] }}"
* identifier.use = #official

// Reference to MedicinalProductDefinition: {{ row["MED ID"] }}
* subject = Reference(mp-{{ row["MED ID"]  }})


* type = $220000000060#220000000061 "Marketing Authorisation"
* region = $100000000002#100000000501 "Portuguese Republic"
* status = $100000072049#100000072099  "Valid"


{{ "// ERROR[3] - no statusDate INDEX:{}".format(index+1) }}

* holder = Reference({{ row["MED ID"]|get_data_from_sheet(data["data"],"Titular-Medicine","Titular AIM - OMS LOC-ID 2.8\n(SPOR-OMS LOC-ID)","MED ID") }})
{%- endif %}

{%- endfor %}


