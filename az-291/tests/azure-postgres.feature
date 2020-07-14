Feature: Database resources must use approved configurations according to the CIS benchmark
  - Ensure server parameter X is set to X for PostgreSQL Database Server

  @noskip_at_lines_23_24_25_26_27_28
  Scenario Outline: Ensure postgres configurations exist for PostgreSQL Database Server
    Given I have azurerm_postgresql_server defined
    Given I have any resource defined
    When its type is azurerm_postgresql_configuration
    When its name is <config_name>
    Then it must have value
    Then its value must match the "<value>" regex

    Examples:
      | config_name           | value             |
      | log_checkpoints       | on                |
      | log_connections       | on                |
      | log_disconnections    | on                |
      | log_duration          | on                |
      | connection_throttling | on                |
      | log_retention_days    | ^([4-9]\|\d{2,})$ |