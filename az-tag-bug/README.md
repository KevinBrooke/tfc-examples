# Azure tag test issue

The test is looking for tags on the VM resources, "backmeup" and "terraform"

Expected: The windowsservers-pass module should pass the test but the linuxservers-fail module should fail both tag tests.

Result: The tests all pass...

```
Feature: Virtual machines must use approved configurations  /tests/azure-vm.feature
    In order to keep consistency between resources
    As engineers
    We'll enforce the virtual machine configurations

    Scenario Outline: Ensure that VM specific tags are defined
        Given I have azurerm_virtual_machine defined
        When it has tags
        Then it must contain tags
        Then it must contain <tag>
        And its value must match the "<value>" regex

    Examples:
        | tag       | value        |
        | backmeup  | (true|false) |
        | terraform | (true)       |

1 features (1 passed)
2 scenarios (2 passed)
10 steps (10 passed)
```

####From the plan
windowsservers-pass
```
# module.windowsservers-pass.azurerm_virtual_machine.vm-windows[0] will be created
  + resource "azurerm_virtual_machine" "vm-windows" {
     + availability_set_id              = (known after apply)
     + delete_data_disks_on_termination = false
     + delete_os_disk_on_termination    = false
     + id                               = (known after apply)
     + license_type                     = (known after apply)
     + location                         = (known after apply)
     + name                             = "mywinvm-vmWindows-0"
     + network_interface_ids            = (known after apply)
     + resource_group_name              = "tfctagcheck-rg"
     + tags                             = {
         + "backmeup"    = "false"
         + "customer"    = "foo"
         + "environment" = "dev"
         + "foo"         = "bar"
         + "project"     = "bar"
         + "terraform"   = "true"
```

linuxservers-fail
```
# module.linuxservers-fail.azurerm_virtual_machine.vm-linux[0] will be created
  + resource "azurerm_virtual_machine" "vm-linux" {
      + availability_set_id              = (known after apply)
      + delete_data_disks_on_termination = false
      + delete_os_disk_on_termination    = false
      + id                               = (known after apply)
      + license_type                     = (known after apply)
      + location                         = (known after apply)
      + name                             = "myvm-vmLinux-0"
      + network_interface_ids            = (known after apply)
      + resource_group_name              = "tfctagcheck-rg"
      + tags                             = {
          + "customer"    = "foo"
          + "environment" = "dev"
          + "foo"         = "bar"
          + "project"     = "bar"
```

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
| Terraform Compliance | 1.2.5 | 