
Instance: ingredient-
InstanceOf: PPLIngredient
Title: "ingredient--for-GENTAMICINA SOLFATO"
Description: "ingredient--for-GENTAMICINA SOLFATO"
Usage: #example

//* role = $100000072050# ""
//* status = #
* role = $100000072050#100000072072 "active"
* status = #active
//where to find?
* substance.code.concept = $sms# "GENTAMICINA SOLFATO"
// ERROR[4] - strengths and principles are wrong for INDEX:1

* substance.strength.presentationQuantity.lowNumerator = 0,423  $100000110633#100000110654 "g"
* substance.strength.presentationQuantity.highNumerator = 0,423  $100000110633#100000110654 "g"
