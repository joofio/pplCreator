{% for index,row in data["data"]["ManufacturedItem"].iterrows() %}

{% set ns = namespace() %}

{% set ns.ing_id = row["Ingredient ID"]|string %}

{% if ns.ing_id|string != "nan" %}
{% for idx in range(0,ns.ing_id.count(";")+1) %} 
{% set ns.ing_name = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Nome Substância\n(Substance name)","Ingredient ID") %}
{% set ns.ing_strength = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Tipo Ingrediente\n(Ingredient role)","Ingredient ID") %}

{% set ns.ing_reference_descr = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Descrição\n(Description)","Ingredient ID") %}
{% set ns.ing_reference_id = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","EU-SMS/SRS","Ingredient ID") %}
{% set ns.ing_sms_id = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","EU-SMS/SRS.1","Ingredient ID") %}

{% set ns.num_value = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Numerator value","Ingredient ID") %}
{% set ns.num_unit = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Numerator unities RMS ID","Ingredient ID") %}
{% set ns.num_unit_desc = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Numerator unity","Ingredient ID") %}

{% set ns.den_value = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Denominator value","Ingredient ID") %}
{% set ns.den_unit = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Denominator unities RMS ID","Ingredient ID") %}
{% set ns.den_unit_desc = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Denominator unity","Ingredient ID") %}

{% set ns.ref_num_value = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Numerator value.2","Ingredient ID") %}
{% set ns.ref_num_unit = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Numerator unities RMS ID.2","Ingredient ID") %}
{% set ns.ref_num_unit_desc = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Numerator unity.2","Ingredient ID") %}

{% set ns.ref_den_value = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Denominator value.2","Ingredient ID") %}
{% set ns.ref_den_unit = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Denominator unities RMS ID.2","Ingredient ID") %}
{% set ns.ref_den_unit_desc = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Denominator unity.2","Ingredient ID") %}


{% if ns.ing_name|string != "None" %}

//{{ns.ing_name}}//{{ns.ing_id}}

Instance: ingredient-{{ ns.ing_name|create_hash_id}}
InstanceOf: PPLIngredient
Title: "{{ ns.ing_name}}"
Description: "ingredient {{ns.ing_name}} with strength {{ ns.ing_strength}} for {{ row["MED ID"]}}"
Usage: #example

* role = $100000072050#100000072072 "active"
* status = #active
* substance.code.concept = $sms#{{ns.ing_sms_id|int}} "{{ns.ing_name}}"

{% if ns.num_value|string != "nan" %}

//num_value !=Nan
* substance.strength.presentationRatio.numerator = {{ ns.num_value }}  $100000110633#{{ ns.num_unit|int}}  "{{ ns.num_unit_desc }}"
* substance.strength.presentationRatio.denominator = {{ ns.den_value }}  $100000110633#{{ ns.den_unit|int}}  "{{ ns.den_unit_desc }}"
{% else %}

{% set ns.num_value = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Numerator value.1","Ingredient ID") %}
{% set ns.num_unit = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Numerator unities RMS ID.1","Ingredient ID") %}
{% set ns.num_unit_desc = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Numerator unity.1","Ingredient ID")%}

{% set ns.den_value = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Denominator value.1","Ingredient ID") %}
{% set ns.den_unit = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Denominator unities RMS ID.1","Ingredient ID") %}
{% set ns.den_unit_desc = ns.ing_id.split(";")[idx]|float| get_data_from_sheet(data["data"],"Ingredient","Denominator unity.1","Ingredient ID") %}


* substance.strength.presentationRatio.numerator = {{ ns.num_value }}  $100000110633#{{ ns.num_unit|int}}  "{{ ns.num_unit_desc }}"
* substance.strength.presentationRatio.denominator = {{ ns.den_value }}  $100000110633#{{ ns.den_unit|int}}  "{{ ns.den_unit_desc }}"

{% endif %}
* substance.strength.referenceStrength.strengthRatio.numerator = {{ ns.ref_num_value }}  $100000110633#{{ ns.ref_num_unit|int}}  "{{ ns.ref_num_unit_desc }}"
* substance.strength.referenceStrength.strengthRatio.denominator =  {{ ns.ref_den_value }}  $100000110633#{{ ns.ref_den_unit|int}}  "{{ ns.ref_den_unit_desc }}"
* substance.strength.referenceStrength.substance.concept = $sms#{{ns.ing_reference_id}} "{{ns.ing_reference_descr}}"

// Reference to products item

* for[0] = Reference(mp-{{row["MED ID"]}})
* for[+] = Reference(ap-{{row["MED ID"]}})
* for[+] = Reference(mid-{{row["MED ID"]}})

{% else  %}
{{"//ERROR[7] - No Ingredient Id for ns.ing_id at INDEX:{}".format(index+1) }}
{% endif %}

{%- endfor %}
{%- endif %}

{%- endfor %}