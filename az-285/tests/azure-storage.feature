Feature: Storage resources must use approved configurations according to the CIS benchmark
  - Ensure 'Trusted Microsoft Services' is enabled for Storage Account access

  Scenario: Ensure 'Trusted Microsoft Services' is enabled for Storage Account access
    Given I have azurerm_storage_account defined
    Then it must contain network_rules
    And it must contain bypass
    And any of its values must match the "(^AzureServices$)" regex