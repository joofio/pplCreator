{% for index,row in data["data"].iterrows() %}
{% if row["skip"] not in ['y', 'Y', 'x', 'X'] %}

Instance: ingredient-for-{{ data["dictionary"]["MajorName"]|lower}}-{{ row["name"]| lower | regex_replace('[^A-Za-z0-9]+', '') }}
InstanceOf: PPLIngredient
Title: "Ingredient-{{row["role"]| lower}} {{ row["name"]  }}"
Description: "{{ row["name"]  }}"
Usage: #example

* id = "{{row['id']}}" 

{% if row["identifier"]|string != "nan" %}

//* identifier.system = $ginas
//* identifier.value = "{{ row["identifier"]  }}"
//* identifier.use = #official
{%- endif %}

* role = $100000072050#{{ row["roleID"]  }} "{{ row["role"]  }}"

* status = #{{ row["status"]  }}

* substance.code.concept = $sms#{{ row["identifier"]  }} "{{ row["name"]  }}"

* substance.strength.presentationRatio.numerator = {{ row["presentationNumeratorValue"]  }} $100000110633#{{ row["StrengthNumeratorUnitID"]  }} "{{ row["StrengthNumeratorUnit"]  }}"
* substance.strength.presentationRatio.denominator = {{ row["presentationDenominatorValue"]  }} $200000000014#{{ row["StrengthDenominatorUnitId"]  }} "{{ row["StrengthDenominatorUnit"]  }}"
* substance.strength.referenceStrength.substance.concept = $sms#{{ row["referenceSubstanceID"]  }} "{{ row["referenceSubstance"]  }}"

* substance.strength.referenceStrength.strengthRatio.numerator = {{ row["referenceNumeratorValue"]  }} $100000110633#{{ row["StrengthNumeratorUnitID"]  }} "{{ row["StrengthNumeratorUnit"]  }}"
* substance.strength.referenceStrength.strengthRatio.denominator =  {{ row["referenceDenominatorValue"]  }} $200000000014#{{ row["StrengthDenominatorUnitId"]  }} "{{ row["StrengthDenominatorUnit"]  }}"


{% if data["turn"] != "1" %}
// Reference to products item
* for[0] = Reference({{data["references"]["ManufacturedItemDefinition"][0][0]}})
* for[+] = Reference({{data["references"]["MedicinalProductDefinition"][0][0]}})
* for[+] = Reference({{data["references"]["AdministrableProductDefinition"][0][0]}})
{%- endif %}


{%- endif %}
{%- endfor %}