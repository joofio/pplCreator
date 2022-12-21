{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: ppd-{{ row["name"]| lower | regex_replace('[^A-Za-z0-9]+', '')}}
InstanceOf: PPLPackagedProductDefinition
Title: "{{ row["name"] }}"
Description: "{{ row["name"] }}"
Usage: #example
* id = "{{row['id']}}" 

* identifier[pcid].value = "{{ row["identifier"] }}"

* name = "{{ row["name"] }}"

//* type = $spor-rms#{{ row["typeID"] }} "{{ row["type"] }}"
//* type = $spor-rms#100000155527


* status = #{{ row["status"]|lower }}
{{ "* statusDate = \"{}\"".format(row.statusDate) if row.statusDate|string !="nan"}}

{% if row["quantity"]|string !="nan"  %}

* containedItemQuantity = {{ row["quantityValue"]}} $200000000014#{{ row["quantityUnitID"]}} "{{ row["quantityUnit"]}}"

{%- endif %}

{{ "* description = \"{}\"".format(row.description) if row.description|string !="nan"}}
{{ "* copackagedIndicator = {}".format(row.copackagedIndicator|lower) if row.copackagedIndicator|string !="nan"}}

* marketingStatus.country = $100000000002#100000000388 "Republic of Estonia"
* marketingStatus.status = $100000072052#100000072083 "Marketed"

* package
 // * identifier.system = $spor-prod
 // * identifier.value = "{{ row["packaging_identifier"] }}"
  * type = $100000073346#{{ row["Packaging_typeID"] }} "{{ row["Packaging_type"] }}"
  * quantity = {{ row["packaging_quantity"] }}
  * material = $200000003199#{{ row["packaging_materialID"] }} "{{ row["packaging_material"] }}"
{% if row["inside_packaging_type"]|string != "nan" %}

  * package.type = $100000073346#{{ row["Packaging_typeID"] }} "{{ row["Packaging_type"] }}"
  * package.quantity = {{ row["packaging_quantity"] }}
{% for idx in range(0,row["packaging_materialID"].count("|")+1) %} 

  * package.material[+] = $200000003199#{{ row["packaging_materialID"].split("|")[idx] }} "{{ row["packaging_material"].split("|")[idx] }}"

{%- endfor %}
{%- endif %}

  
//reference to MedicinalProductDefinition: EU/1/97/049/001 Karvea 75 mg tablet
{% if data["turn"] != "1" %}
* packageFor = Reference({{data["references"]["MedicinalProductDefinition"][0][0]}})
{% endif %}
 // Reference to Organization: MAH
{% if data["turn"] != "1" %}
* manufacturer = Reference({{data["references"]["Organization"][0][0]}})
{% endif %}

{%- endif %}
{%- endfor %}