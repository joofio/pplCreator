{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

{% set ns = namespace() %}

{% set ns.one = row['Ravimi nimetus'] %}
{% set ns.two = row['Ravimvorm'] %}
{% set ns.three= row['Ravimi tugevus'] %}
{% set ns.name_to_has= ns.one ~ ns.two ~ns.three  %}


Instance: mid-{{row["Müügiloa number"]| trim|create_hash_id}}
InstanceOf: PPLManufacturedItemDefinition
Title: "Manufactured item {{ ns.name_to_has }}"
Description: "{{ row["Ravimi nimetus"] }}"
Usage: #example


* status = #active
* manufacturedDoseForm = $200000000004#{{row["Toodetud ravimvorm"]|get_data_dictionary_info(200000000004,"RMS termini id","RMS nimi eesti keeles")}} "{{ row["Toodetud ravimvorm"] }}"

//{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+")}}

* unitOfPresentation = $200000000014#{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+")|get_data_dictionary_info(200000000014,"RMS termini id","RMS nimi eesti keeles")}} "{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+") }}"


//* manufacturer = Reference({{row['Müügiloa hoidja organisatsiooni ORG ID']}})

{%- endif %}
{%- endfor %}