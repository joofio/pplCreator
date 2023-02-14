{% for index,row in data["data"]["Pharmaceutical Product"].iterrows() %}

{% set ns = namespace() %}

{% set ns.route_id = row["Route of Administration 6.6 RMS-ID"]|string %}

Instance: ap-{{row["MED ID"]}}
InstanceOf: PPLAdministrableProductDefinition
Title: "Administrable product {{row["MED ID"]|get_data_from_sheet(data["data"],"Titular-Medicine","Nome PMS","MED ID")}}"
Description: "{{row["MED ID"]|get_data_from_sheet(data["data"],"Titular-Medicine","Nome PMS","MED ID")}}"
Usage: #example

* status = #active

* formOf = Reference(mp-{{row["MED ID"]}})

* administrableDoseForm = $200000000004#{{ row["administrableDoseForm 6.2 RMS-ID"]}} "{{ row["administrableDoseForm 6.2\t Descrição \n(description)"] }}"
* unitOfPresentation = $200000000014#{{row["Unit of presentation 6.3 RMS-ID"]}} "{{row["Unit of presentation 6.3\t Descrição \n(description)"] }}"


//reference to ManufacturedProduct 
* producedFrom = Reference(mid-{{row["MED ID"]}})


{% for idx in range(0,ns.route_id.count(";")+1) %} 

* routeOfAdministration[+].code = $100000073345#{{ ns.route_id.split(";")[idx]|trim}} "{{ row["Route of Administration 6.6 Descrição \n(description)"].split(";")[idx]|trim }}"
{%- endfor %}

{%- endfor %}
