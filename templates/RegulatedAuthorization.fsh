{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: authorization{{ row["name"]| lower | regex_replace('[^A-Za-z0-9]+', '') }}
InstanceOf: PPLRegulatedAuthorization
Title: "Regulated Authorization for {{ row["name"] }}"
Description: "Regulated Authorization for {{ row["name"] }}"
Usage: #example

* id = "{{row['id']}}" 

//* identifier.system = $spor-prod
* identifier.value = "{{ row["identifier"] }}"
//* identifier.use = #official

// Reference to MedicinalProductDefinition:
{% if data["turn"] != "1" %}
* subject = Reference({{data["references"]["MedicinalProductDefinition"][0][0]}})
{% endif %}
* type = $220000000060#{{ row["typeID"] }} "{{ row["type"] }}"

* region = $100000000002#{{ row["regionID"] }} "{{ row["region"] }}"

* status = $100000072049#{{ row["statusID"] }} "{{ row["status"] }}"
* statusDate = "{{ row["statusDate"] }}"
{% set ns  = namespace(referenced=False) -%}

{% if data["turn"] != "1" %}
{% for refs in data["references"]["Organization"] %} 
{% if refs[0].startswith("marketingauthorisationholder") %}
{% set ns.referenced=True -%}

* holder = Reference({{refs[0]}})
{%- endif %}
{%- endfor %}

{% if not ns.referenced  %}

* holder = Reference({{data["references"]["Organization"][0][0]}})
{%- endif %}

{%- endif %}

{%- endif %}
{%- endfor %}



{% if data["turn"] != "1" %}
{% for refs in data["references"]["Organization"] %} 
{% if refs[0].startswith("medicinesregulatoryauthority") %}
 // Reference to Organization: EMA
* regulator = Reference({{refs[0]}})
{%- endif %}
{%- endfor %}
{%- endif %}


