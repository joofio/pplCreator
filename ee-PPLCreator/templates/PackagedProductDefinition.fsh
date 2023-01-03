{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

{% set ns = namespace() %}
{% set ns.mpone = row['Ravimi nimetus'] %}

{% set ns.mpthree= row['Ravimi tugevus'] %}
{% set ns.ppdone = row['Pakendikood'] %}


{% set ns.mp_name_to_has= ns.mpone ~ns.mpthree  %}
{% set ns.ppd_name_to_has= ns.mpone ~ns.mpthree ~ns.ppdone  %}


Instance: ppd-{{ ns.ppd_name_to_has| create_hash_id}}
InstanceOf: PPLPackagedProductDefinition
Title: "{{ row["Ravimi nimetus"] }} - {{row["Ravimi tugevus"]}} - {{ row["Pakendi suurus"] }}"
Description: "{{ row["Ravimi nimetus"] }} - {{row["Ravimi tugevus"]}} - {{ row["Pakendi suurus"] }}"
Usage: #example
//* id = "{{row['id']}}" 

* identifier[pcid].value = "EE-{{row['Müügiloa hoidja organisatsiooni asukoha LOC ID']| replace('LOC-','')}}-{{row['Ravimikaardi number']}}-{{row['Pakendikood']}}"

* name = "{{ row["Ravimi nimetus"] }} - {{row["Ravimi tugevus"]}} - {{ row["Pakendi suurus"] }}"


* description = ""

* status = #active
{% if row["Müügiloa kehtivuse alguse kuupäev"]|string == "nan" %}
{{ "// ERROR[3] - no statusDate INDEX:{}".format(index+1)  }}
{% else %} 
* statusDate = "{{ row["Müügiloa kehtivuse alguse kuupäev"]|format_datetime }}"
{%- endif %}


{% if row["quantity"]|string !="nan"  %}

//Pakendi suurus
* containedItemQuantity = {{ row["Pakendi suurus"]|get_by_regex("\d+") }} $200000000014#{{ row["Pakendi suurus"]| get_by_regex("[A-Za-z]+")|get_data_dictionary_info(200000000014,"RMS termini id","RMS nimi eesti keeles")}} "{{ row["Pakendi suurus"]| get_by_regex("[A-Za-z]+")}}"

{%- endif %}


* marketingStatus.country = $100000000002#100000000388 "Republic of Estonia"
* marketingStatus.status = $100000072052#100000072083 "Marketed"

* package
  * quantity = 1
  * type = $100000073346#100000073498 "Box"
  

  * package.
    * type = $100000073346#{{ row["Sisepakendi liik"]|get_data_dictionary_info(100000073346,"RMS termini id","RMS nimi eesti keeles") }} "{{ row["Sisepakendi liik"] }}"
    * containedItem.item.reference = Reference(mid-{{ ns.mp_name_to_has| create_hash_id}})
    * containedItem.amount.value = {{ row["Pakendi suurus"]|get_by_regex("\d+") }}
    {% for idx in range(0,row["Sisepakendi materjal"].count(",")+1) %} 

    * material[+] = $200000003199#{{ row["Sisepakendi materjal"].split(",")[idx]|strip_spaces|get_data_dictionary_info(200000003199,"RMS termini id","RMS termini nimi") }} "{{ row["Sisepakendi materjal"].split(",")[idx] }}"

  {%- endfor %}
  
// for: {{ ns.mp_name_to_has }}
* packageFor = Reference(mp-{{ ns.mp_name_to_has| create_hash_id}})

// Reference to Organization: MAH
//* manufacturer = Reference({{ row['Müügiloa hoidja organisatsiooni ORG ID'] }})

{%- endif %}
{%- endfor %}