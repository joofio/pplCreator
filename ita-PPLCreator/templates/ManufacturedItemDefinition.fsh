{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: mid-{{ row["CODICE_CONFEZIONE"] | lower | regex_replace('[^A-Za-z0-9]+', '') }}
InstanceOf: PPLManufacturedItemDefinition
Title: "Manufactured item {{ row["CODICE_CONFEZIONE"] }}"
Description: "{{ row["CODICE_CONFEZIONE"] }}"
Usage: #example


* status = #active
* manufacturedDoseForm = $200000000004#{{row["TRM_ID_200000000004_200000000007 - Pharmaceutical Dose Form/Combined Term"]}} "{{ row["DESCRIZIONE_FORMA_FARM"] }}"


{# 
* unitOfPresentation = $200000000014#{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+")}} "{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+") }}"
#}

* manufacturer = Reference({{row['ORG_ID']}})

{%- endif %}
{%- endfor %}