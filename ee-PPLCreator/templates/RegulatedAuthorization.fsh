{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}


Instance: auth-for-{{ row["Toimeaine"]| lower | regex_replace('[^A-Za-z0-9]+', '')|create_hash_id }}
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
* subject = Reference(mp{{ row["Ravimi nimetus"]| regex_replace('[^A-Za-z0-9]+', '')  }})


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


