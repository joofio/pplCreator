{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: ap-{{row['name']|lower|regex_replace('[^A-Za-z0-9]+', '')}}
InstanceOf: PPLAdministrableProductDefinition
Title: "Administrable product {{row['name']}}"
Description: "{{row['name']}}"
Usage: #example

* id = "{{row['id']}}" 
//* identifier.system = $phpid
* identifier.value = "{{row['identifier']}}" 

* status = #{{row['status']}}

{% if data["turn"] != "1" %}
* formOf = Reference({{data["references"]["MedicinalProductDefinition"][0][0]}})
{%- endif %}

* administrableDoseForm = $200000000004#{{ row["doseFormID"] }} "{{ row["doseForm"] }}"
* unitOfPresentation = $200000000014#{{ row["unit_presentationID"] }} "{{ row["unit_presentation"] }}"

//this is just manufactured with extra steps?

{% if data["turn"] != "1" %}

//reference to MedicinalProductDefinition: EU/1/97/049/001 Karvea 75 mg tablet
* producedFrom = Reference({{data["references"]["ManufacturedItemDefinition"][0][0]}})

{% endif %}

* routeOfAdministration.code = $100000073345#{{row["routeID"]}} "{{ row["route"] }}"

//* routeOfAdministration.targetSpecies.code = $spor-rms#{{row["target_speciesID"]}} "{{ row["target_species"] }}"
 
{%- endif %}
{%- endfor %}