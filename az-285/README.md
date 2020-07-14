# Azure 285

https://github.com/eerkunt/terraform-compliance/issues/285

Issues checking item in a list.

Expected: If a setting is missing, the scenario should fail; If all settings exist, the scenario should pass

Result: NOW FIXED! :)

## Running the test:

1. Authenticate to Azure `az login`
2. cd to the solution directory `cd solution`
3. `terraform init`
4. `terraform plan -out plan.out`
5. `terraform-compliance -f ../tests -p plan.out`

## Versions

| Product | Version | 
| --- | --- |
| Terraform | v0.12.20 |
| Terraform Compliance | 1.2.9 | 

