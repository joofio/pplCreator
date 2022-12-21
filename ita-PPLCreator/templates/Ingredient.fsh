{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: ingredient-
InstanceOf: PPLIngredient
Title: "ingredient-{{row["DESCRIZIONE_PA"].split(",")[idx]}}-for-{{ row["DESCRIZIONE_PA"]}}"
Description: "ingredient-{{row["DESCRIZIONE_PA"].split(",")[idx]}}-for-{{ row["DESCRIZIONE_PA"]}}"
Usage: #example


//* role = $100000072050#{{ row["roleID"]  }} "{{ row["role"]  }}"
//* status = #{{ row["status"]  }}
* role = $100000072050#100000072072 "active"
* status = #active
//where to find?
* substance.code.concept = $sms# "{{ row["DESCRIZIONE_PA"]}}"

{{ "// ERROR[4] - strengths and principles are wrong for INDEX:{}".format(index+1) if row["DESCRIZIONE_PA"] }}

{% if row["OPERATORE"] == "UGUALE A" and row["TERM_ID_100000110633 - Units of Measurement Denominatore"] | string != "nan" %}

* substance.strength.presentationRatio.numerator = {{ row["DOSAGGIO_QTA_MIN_NUM"]  }}  $100000110633#{{ row["TERM_ID_100000110633 - Units of Measurement Numeratore"] }} "{{row["SIGLA_UM_NUM"]}}"
* substance.strength.presentationRatio.denominator = {{ row["DOSAGGIO_QTA_MIN_DEN"]  }} $200000000014#{{row["TERM_ID_100000110633 - Units of Measurement Denominatore"] }} "{{row["SIGLA_UM_DEN"]}}"

{% elif row["OPERATORE"] == "UGUALE A" and row["TERM_ID_100000110633 - Units of Measurement Denominatore"] | string == "nan" %}

* substance.strength.presentationQuantity = {{ row["DOSAGGIO_QTA_MIN_NUM"]  }}  $100000110633#{{ row["TERM_ID_100000110633 - Units of Measurement Numeratore"] }} "{{row["SIGLA_UM_NUM"]}}"

{% elif row["OPERATORE"] == "RANGE"  %}

* substance.strength.presentationQuantity.lowNumerator = {{ row["DOSAGGIO_QTA_MIN_NUM"]  }}  $100000110633#{{ row["TERM_ID_100000110633 - Units of Measurement Numeratore"] }} "{{row["SIGLA_UM_NUM"]}}"
* substance.strength.presentationQuantity.highNumerator = {{ row["DOSAGGIO_QTA_MIN_NUM"]  }}  $100000110633#{{ row["TERM_ID_100000110633 - Units of Measurement Numeratore"] }} "{{row["SIGLA_UM_NUM"]}}"

{%- endif %}

{# 
//full: {{row["Referentstoimeaine tugevus"].split(",")[idx]}}
//* substance.strength.referenceStrength.strengthRatio.numerator  = {{ row["Referentstoimeaine tugevus"].split(",")[idx]| get_by_regex("(\d+|\.)")  }}  $100000110633#{{ row["Referentstoimeaine tugevus"].split(",")[idx]| get_by_regex("[a-z]+")|get_data_dictionary_info(100000110633,"RMS termini id","Termini sümbol")}} "{{ row["Referentstoimeaine tugevus"].split(",")[idx]| get_by_regex("[a-z]+") }}"
//* substance.strength.referenceStrength.strengthRatio.denominator =  1 $200000000014#{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+")|get_data_dictionary_info(200000000014,"RMS termini id","RMS nimi eesti keeles")}} "{{row["Pakendi suurus"].split(",")[0]|get_by_regex("[A-Za-z]+") }}"
//* substance.strength.referenceStrength.substance.concept = $sms#{{ row["Toimeaine"].split(",")[idx]|strip_spaces|get_data_dictionary_info("substance","Concept Code","National Description")  }} "{{ row["Toimeaine"].split(",")[idx]|strip_spaces  }}"

// Reference to products item
//MPD
//* for[0] = Reference(mp{{ row["Ravimi nimetus"]| regex_replace('[^A-Za-z0-9]+', '')  }})
#}


{%- endif %}
{%- endfor %}