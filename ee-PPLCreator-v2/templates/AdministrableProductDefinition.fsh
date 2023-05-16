{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

{% set ns = namespace() %}
{% set ns.one = row['Ravimi nimetus'] %}
{% set ns.two = row['Ravimvorm'] %}
{% set ns.three= row['Ravimi tugevus'] %}
{% set ns.name_to_has= ns.one ~ ns.two ~ns.three  %}



Instance: ap-{{row["Müügiloa number"]|trim| create_hash_id}}
InstanceOf: PPLAdministrableProductDefinition
Title: "Administrable product {{row['Ravimi nimetus']}}-{{row['Ravimvorm']}}-{{row['Ravimi tugevus	']}}"
Description: " {{row['Ravimi nimetus']}}-{{row['Ravimvorm']}}-{{row['Ravimi tugevus	']}}"
Usage: #example

* status = #active

* formOf = Reference(mp-{{row["Müügiloa number"]|trim| create_hash_id}})
//RMS nimi eesti keeles->RMS termini nimi
* administrableDoseForm = $200000000004#{{ row["Manustatav ravimvorm"]|get_data_dictionary_info(200000000004,"RMS termini id","RMS termini nimi")}} "{{ row["Manustatav ravimvorm"] }}"
* unitOfPresentation = $200000000014#{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+")|get_data_dictionary_info(200000000014,"RMS termini id","RMS termini nimi")}} "{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+") }}"

{% if data["turn"] != "1" %}

//reference to MedicinalProductDefinition: EU/1/97/049/001 Karvea 75 mg tablet
* producedFrom = Reference({{data["references"]["ManufacturedItemDefinition"][0][0]}})

{% endif %}

* routeOfAdministration.code = $100000073345#{{ row["Manustamisviisid"]|get_data_dictionary_info(100000073345,"RMS termini id","RMS termini nimi")}} "{{ row["Manustamisviisid"] }}"

 
{%- endif %}
{%- endfor %}