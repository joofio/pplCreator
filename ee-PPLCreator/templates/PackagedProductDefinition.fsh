{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: ppd-{{ row["Ravimi nimetus"]| lower | regex_replace('[^A-Za-z0-9]+', '')}}
InstanceOf: PPLPackagedProductDefinition
Title: "{{ row["Ravimi nimetus"] }}"
Description: "{{ row["Ravimi nimetus"] }}"
Usage: #example
//* id = "{{row['id']}}" 

* identifier[pcid].value = "MPID-{{ row["Pakendikood"] }}"

* name = "{{ row["Ravimi nimetus"] }}"




* status = #active
* statusDate = "{{ row["Müügiloa kehtivuse alguse kuupäev"]|format_datetime }}"
{{ "// ERROR[3] - no statusDate INDEX:{}".format(index+1) if row["Müügiloa kehtivuse alguse kuupäev"]|string == "nan" }}

{% if row["quantity"]|string !="nan"  %}

//Pakendi suurus
* containedItemQuantity = {{ row["Pakendi suurus"]|get_by_regex("\d+") }} $200000000014#{{ row["Pakendi suurus"]| get_by_regex("[A-Za-z]+")|get_data_dictionary_info(200000000014,"RMS termini id","RMS nimi eesti keeles")}} "{{ row["Pakendi suurus"]| get_by_regex("[A-Za-z]+")}}"

{%- endif %}


* marketingStatus.country = $100000000002#100000000388 "Republic of Estonia"
* marketingStatus.status = $100000072052#100000072083 "Marketed"

* package
  * quantity = {{ row["Pakendi suurus"]|get_by_regex("\d+") }}

  {% for idx in range(0,row["Sisepakendi materjal"].count(",")+1) %} 

  * material[+] = $200000003199#{{ row["Sisepakendi materjal"].split(",")[idx]|strip_spaces|get_data_dictionary_info(200000003199,"RMS termini id","RMS termini nimi") }} "{{ row["Sisepakendi materjal"].split(",")[idx] }}"

{%- endfor %}

  * package.type = $100000073346#{{ row["Sisepakendi liik"]|get_data_dictionary_info(100000073346,"RMS termini id","RMS nimi eesti keeles") }} "{{ row["Sisepakendi liik"] }}"

  
//reference to MedicinalProductDefinition: EU/1/97/049/001 Karvea 75 mg tablet
* packageFor = Reference(mp{{ row["Ravimi nimetus"]| regex_replace('[^A-Za-z0-9]+', '')  }})
// Reference to Organization: MAH
* manufacturer = Reference({{ row['Müügiloa hoidja organisatsiooni ORG ID'] }})

{%- endif %}
{%- endfor %}