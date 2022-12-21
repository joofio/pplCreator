{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: ppd-{{ row["ID_PACKAGE"]| lower | regex_replace('[^A-Za-z0-9]+', '')}}
InstanceOf: PPLPackagedProductDefinition
Title: "{{ row["DESCRIZ_CONFEZIONE"] }}"
Description: "{{ row["DESCRIZ_CONFEZIONE"] }}"
Usage: #example
//* id = "{{row['id']}}" 

* identifier[pcid].value = "MPID-{{ row["DESCRIZ_CONFEZIONE"] }}"

* name = "{{ row["DESCRIZ_CONFEZIONE"] }}"




* status = #active
* statusDate = "{{ row["DATETIME_AGGIORNAMENTO"]|format_datetime("%d/%m/%y %H:%M") }}"

{% if row["quantity"]|string !="nan"  %}

//Pakendi suurus
* containedItemQuantity = {{ row["QTA_CONTENUTO_PACKAGE"]|get_by_regex("\d+") }} 
{%- endif %}


* marketingStatus.country = $100000000002#100000000430 "Italian Republic"
* marketingStatus.status = $100000072052#100000072083 "Marketed"

* package
  * quantity = {{ row["QTA_CONTENUTO_PACKAGE"]|get_by_regex("\d+") }}

  {% for idx in range(0,row["QTA_CONTENUTO_PACKAGE"].count(",")+1) %} 

  * material[+] = $200000003199#

{%- endfor %}

  * package.type = $100000073346#

  
//reference to MedicinalProductDefinition: EU/1/97/049/001 Karvea 75 mg tablet
* packageFor = Reference(mp{{ row["QTA_CONTENUTO_PACKAGE"]| regex_replace('[^A-Za-z0-9]+', '')  }})
// Reference to Organization: MAH
* manufacturer = Reference({{ row['ORG_ID'] }})

{%- endif %}
{%- endfor %}