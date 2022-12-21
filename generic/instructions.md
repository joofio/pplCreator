## Instructions

Create Xlsx file with each tab the information for the Resource like:

*    AdministrableProductDefinition
*    RegulatedAuthorization
*    Organization
*    Ingredient
*    MedicinalProductDefinition
*    ManufacturedItemDefinition
*    PackagedProductDefinition

Then run the creator.py with 3 arguments:
* data_file = place where the xlsx is
* template_folder = folder of the templates
* output_folder = where to place the data created


turns into something like:  
```python creator.py betaklav.xlsx templates/ fsh/```