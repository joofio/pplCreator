{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: {{row['DEN_TITOLARE']}}{{row["ORG_ID"]}}
InstanceOf: PPLOrganization
Title: "{{ row["DEN_TITOLARE"]  }}"
Description: "{{ row["DEN_TITOLARE"]  }} MAH"
Usage: #example
* id = "{{row['ORG_ID'] }}" 
//* identifier[loc].value = "{{row['Müügiloa hoidja organisatsiooni asukoha LOC ID']}}"
* name = "{{row["DEN_TITOLARE"]  }}"

{%- endif %}
{%- endfor %}
