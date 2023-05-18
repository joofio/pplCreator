{% for index,row in data["data"]["Titular-Medicine"].iterrows() %}


Instance: {{row["Titular AIM - OMS LOC-ID 2.8\n(SPOR-OMS LOC-ID)"]}}
InstanceOf: PPLOrganization
Title: "{{ row["Nome Titular AIM\n(Titular name AIM)"]  }}"
Description: "{{ row["Nome Titular AIM\n(Titular name AIM)"]  }} MAH"
Usage: #example
* id = "{{row['Titular AIM - OMS LOC-ID 2.8\n(SPOR-OMS LOC-ID)'] }}" 
* identifier[loc].value = "{{row['Titular AIM - OMS LOC-ID 2.8\n(SPOR-OMS LOC-ID)']}}"
* name = "{{ row["Nome Titular AIM\n(Titular name AIM)"]  }}"

{%- endfor %}
