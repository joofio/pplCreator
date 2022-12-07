{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: mid-{{ row["Ravimi nimetus"] | lower | regex_replace('[^A-Za-z0-9]+', '') }}
InstanceOf: PPLManufacturedItemDefinition
Title: "Manufactured item {{ row["Ravimi nimetus"] }}"
Description: "{{ row["Ravimi nimetus"] }}"
Usage: #example


* status = #active
* manufacturedDoseForm = $200000000004#{{row["Toodetud ravimvorm"]|get_data_dictionary_info(200000000004,"RMS termini id","RMS nimi eesti keeles")}} "{{ row["Toodetud ravimvorm"] }}"

//{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+")}}

* unitOfPresentation = $200000000014#{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+")|get_data_dictionary_info(200000000014,"RMS termini id","RMS nimi eesti keeles")}} "{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+") }}"


* manufacturer = Reference({{row['Müügiloa hoidja organisatsiooni ORG ID']}})

{%- endif %}
{%- endfor %}