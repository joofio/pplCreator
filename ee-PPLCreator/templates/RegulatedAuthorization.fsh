{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

{% set ns = namespace() %}
{% set ns.mpone = row['Ravimi nimetus'] %}
{% set ns.mpthree= row['Ravimi tugevus'] %}
{% set ns.mp_name_to_has= ns.mpone ~ns.mpthree  %}


Instance: auth-for-{{ ns.mp_name_to_has| create_hash_id}}
InstanceOf: PPLRegulatedAuthorization
Title: "Regulated Authorization for {{ row["Toimeaine"] }}"
Description: "Regulated Authorization for {{ row["Toimeaine"] }}"
Usage: #example

//* id = "{{row['id']}}" 

//* identifier.system = $spor-prod
* identifier.value = "{{ row["Müügiloa number"] }}"
//* identifier.use = #official

// Reference to MedicinalProductDefinition:

//MPD
* subject = Reference(mp-{{ ns.mp_name_to_has| create_hash_id}})


* type = $220000000060#220000000061 "Marketing Authorisation"

* region = $100000000002#100000000388 "Republic of Estonia"

* status = $100000072049#{{row["Müügiloa staatus"]|get_data_dictionary_info(100000072049,"RMS termini id","RMS termini nimi")}}  "{{ row["Müügiloa staatus"] }}"


{% if row["Müügiloa kehtivuse alguse kuupäev"]|string == "nan" %}
{{ "// ERROR[3] - no statusDate INDEX:{}".format(index+1)  }}
{% else %} 
* statusDate = "{{ row["Müügiloa kehtivuse alguse kuupäev"]|format_datetime }}"
{%- endif %}

* holder = Reference({{ row['Müügiloa hoidja organisatsiooni ORG ID'] }})

{%- endif %}

{%- endfor %}


