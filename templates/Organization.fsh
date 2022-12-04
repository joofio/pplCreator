{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}


Instance: org-{{ row["type"] | lower | regex_replace('[^A-Za-z0-9]+', '') }}-{{ row["name"] | lower | regex_replace('[^A-Za-z0-9]+', '') }}-{{ data["dictionary"]["MajorName"]|lower}}
InstanceOf: PPLOrganization
Title: "{{ row["name"]  }} as {{ row["type"]  }}"
Description: "{{ row["name"]  }} as {{ row["type"]  }}"
Usage: #example
* id = "{{row['id']}}" 
* identifier[loc].value = "{{row['identifier']}}"
* name = "{{row['name']}}"

{%- endif %}
{%- endfor %}
