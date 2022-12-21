{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

{% set ns = namespace() %}


{% set ns.one = row['DENOM_MEDICINALE'] %}
{% set ns.two = row['DESCRIZIONE_FD'] %}
{% set ns.three= row['DESCRIZ_CONFEZIONE'] %}
{% set ns.name_to_has= ns.one ~ ns.two ~ns.three  %}



Instance: ap-{{ ns.name_to_has| create_hash_id}}
InstanceOf: PPLAdministrableProductDefinition
Title: "Administrable product {{row['DENOM_MEDICINALE']}}-{{row['DESCRIZIONE_FD']}}-{{row['DESCRIZ_CONFEZIONE']}}"
Description: " {{row['DENOM_MEDICINALE']}}-{{row['DESCRIZIONE_FD']}}-{{row['DESCRIZ_CONFEZIONE']}}"
Usage: #example


* status = #active

//MPD
* formOf = Reference(mp{{ row["DESCRIZIONE_FORMA_FARM"]| regex_replace('[^A-Za-z0-9]+', '')  }})

* administrableDoseForm = $200000000004#{{row["TRM_ID_200000000004_200000000007 - Pharmaceutical Dose Form/Combined Term"]}} "{{ row["DESCRIZIONE_FORMA_FARM"] }}"
//* unitOfPresentation = $200000000014#{{ row["unit_presentationID"] }} "{{ row["unit_presentation"] }}"

{% if data["turn"] != "1" %}

//reference to MedicinalProductDefinition: EU/1/97/049/001 Karvea 75 mg tablet
* producedFrom = Reference({{data["references"]["ManufacturedItemDefinition"][0][0]}})

{% endif %}

* routeOfAdministration.code = $100000073345#{{row["TERM_ID_100000073345 - Routes and Methods of Administration"]}} "{{ row["DESCRIZIONE_VIA_SOMMIN"] }}"

 
{%- endif %}
{%- endfor %}