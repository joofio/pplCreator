{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

{% for idx in range(0,row["Toimeaine"].count(",")+1) %} 

{% set ns = namespace() %}
{% set ns.ingone = row['Toimeaine'].split(",")[idx] %}
{% set ns.ingtwo = row["Ravimi nimetus"] %}
{% set ns.ingthree= row['Ravimi tugevus'].split(",")[idx] %}

{% set ns.ing_name_to_has= ns.ingone ~ ns.ingtwo ~ns.ingthree  %}

{% set ns.one = row['Ravimi nimetus'] %}
{% set ns.two = row['Ravimvorm'] %}
{% set ns.three= row['Ravimi tugevus'] %}
{% set ns.name_to_has= ns.one ~ ns.two ~ns.three  %}


Instance: ingredient-{{ ns.ing_name_to_has| create_hash_id}}
InstanceOf: PPLIngredient
Title: "{{ ns.ing_name_to_has}}"
Description: "ingredient {{row["Toimeaine"].split(",")[idx]}} with strength {{ row["Ravimi tugevus"].split(",")[idx]}} for {{ row["Ravimi nimetus"]}}"
Usage: #example

* role = $100000072050#100000072072 "active"
* status = #active
* substance.code.concept = $sms#{{ row["Toimeaine"].split(",")[idx]|strip_spaces|get_data_dictionary_info("substance","Concept Code","National Description")  }} "{{ row["Toimeaine"].split(",")[idx]|strip_spaces  }}"

//full: {{row["Ravimi tugevus"].split(",")[idx]}}
{{ "// ERROR[4] - strengths and principles are wrong for INDEX:{}".format(index+1) if row["Toimeaine"].split(",")|length != row["Ravimi tugevus"].split(",")|length }}

* substance.strength.presentationRatio.numerator = {{ row["Ravimi tugevus"].split(",")[idx]| get_by_regex("(\d+|\.)")  }}  $100000110633#{{ row["Ravimi tugevus"].split(",")[idx]| get_by_regex("[a-z]+")|get_data_dictionary_info(100000110633,"RMS termini id","Termini sümbol")}}  "{{ row["Ravimi tugevus"].split(",")[idx]| get_by_regex("[a-z]+") }}"
* substance.strength.presentationRatio.denominator = 1 $200000000014#{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+")|get_data_dictionary_info(200000000014,"RMS termini id","RMS nimi eesti keeles")}} "{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+") }}"

{{"// ERROR[5] - reference strengths and principles are wrong for INDEX:{}".format(index+1) if row["Referentstoimeaine"].split(",")|length != row["Referentstoimeaine tugevus"].split(",")|length }}
//full: {{row["Referentstoimeaine tugevus"].split(",")[idx]}}
* substance.strength.referenceStrength.strengthRatio.numerator  = {{ row["Referentstoimeaine tugevus"].split(",")[idx]| get_by_regex("(\d+|\.)")  }}  $100000110633#{{ row["Referentstoimeaine tugevus"].split(",")[idx]| get_by_regex("[a-z]+")|get_data_dictionary_info(100000110633,"RMS termini id","Termini sümbol")}} "{{ row["Referentstoimeaine tugevus"].split(",")[idx]| get_by_regex("[a-z]+") }}"
* substance.strength.referenceStrength.strengthRatio.denominator =  1 $200000000014#{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+")|get_data_dictionary_info(200000000014,"RMS termini id","RMS nimi eesti keeles")}} "{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+") }}"
* substance.strength.referenceStrength.substance.concept = $sms#{{ row["Toimeaine"].split(",")[idx]|strip_spaces|get_data_dictionary_info("substance","Concept Code","National Description")  }} "{{ row["Toimeaine"].split(",")[idx]|strip_spaces  }}"

// Reference to products item
//{{ ns.name_to_has}}
* for[0] = Reference(mp-{{row["Müügiloa number"]|trim| create_hash_id}})
* for[+] = Reference(ap-{{row["Müügiloa number"]|trim| create_hash_id}})
* for[+] = Reference(mid-{{row["Müügiloa number"]|trim|create_hash_id}})


{%- endfor %}

{%- endif %}
{%- endfor %}