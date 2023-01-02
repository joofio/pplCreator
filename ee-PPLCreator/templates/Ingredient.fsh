{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

{% for idx in range(0,row["Toimeaine"].count(",")+1) %} 

{% set ns = namespace() %}
{% set ns.one = row['Toimeaine'].split(",")[idx] %}
{% set ns.two = row["Ravimi nimetus"] %}
{% set ns.name_to_has= ns.one ~ ns.two  %}

{% set ns.mpone = row['Ravimi nimetus'] %}
{% set ns.mpthree= row['Ravimi tugevus'] %}
{% set ns.mp_name_to_has= ns.mpone ~ns.mpthree  %}

{% set ns.apone = row['Ravimi nimetus'] %}
{% set ns.aptwo = row['Ravimvorm'] %}
{% set ns.apthree= row['Ravimi tugevus'] %}
{% set ns.ap_name_to_has= ns.apone ~ ns.aptwo ~ns.apthree  %}




Instance: ingredient-{{ ns.name_to_has| create_hash_id}}

//Instance: ingredient-{{row["Toimeaine"].split(",")[idx]}}-for-{{ row["Ravimi nimetus"]}}
InstanceOf: PPLIngredient
Title: "ingredient-{{row["Toimeaine"].split(",")[idx]}}-for-{{ row["Ravimi nimetus"]}}"
Description: "ingredient-{{row["Toimeaine"].split(",")[idx]}}-for-{{ row["Ravimi nimetus"]}}"
Usage: #example


//* role = $100000072050#{{ row["roleID"]  }} "{{ row["role"]  }}"
//* status = #{{ row["status"]  }}
* role = $100000072050#100000072072 "active"
* status = #active
//where to find?
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
//MPD
* for[0] = Reference(mp-{{ ns.mp_name_to_has| create_hash_id}})
* for[+] = Reference(ap-{{ ns.ap_name_to_has| create_hash_id}})
* for[+] = Reference(mid-{{ ns.mp_name_to_has| create_hash_id}})


{%- endfor %}

{%- endif %}
{%- endfor %}