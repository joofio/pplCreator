{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: {{row['Müügiloa hoidja organisatsiooni ORG ID']}}
InstanceOf: PPLOrganization
Title: "{{ row["Müügiloa hoidja organisatsioon"]  }}"
Description: "{{ row["Müügiloa hoidja organisatsioon"]  }} MAH"
Usage: #example
* id = "{{row['Müügiloa hoidja organisatsiooni ORG ID'] }}" 
* identifier[loc].value = "{{row['Müügiloa hoidja organisatsiooni asukoha LOC ID']}}"
* name = "{{row["Müügiloa hoidja organisatsioon"]  }}"

{%- endif %}
{%- endfor %}
