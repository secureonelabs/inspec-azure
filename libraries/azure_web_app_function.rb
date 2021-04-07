class AzureWebAppFunction < AzureGenericResource
  name 'azure_web_app_function'
  desc 'Verifies settings and configuration for an Azure Function'
  example <<-EXAMPLE
    describe azure_web_app_function(resource_group: 'rg-nm1', site_name: "my-site", function_name: 'HttpTriggerJS1') do
      it            { should exist }
      its('type')   { should cmp 'Microsoft.Web/sites/functions' }
    end
  EXAMPLE

  def initialize(opts = {})
    # Options should be Hash type. Otherwise Ruby will raise an error when we try to access the keys.
    raise ArgumentError, 'Parameters must be provided in an Hash object.' unless opts.is_a?(Hash)

    opts[:resource_provider] = specific_resource_constraint('Microsoft.Web/sites', opts)
    opts[:required_parameters] = %i(site_name)
    opts[:resource_path] = [opts[:site_name], 'functions'].join('/')
    opts[:resource_identifiers] = %i(function_name)

    # static_resource parameter must be true for setting the resource_provider in the backend.
    super(opts, true)
  end

  def to_s
    super(AzureWebAppFunction)
  end
end

# Provide the same functionality under the old resource name.
# This is for backward compatibility.
class AzurermWebAppFunction < AzureWebAppFunction
  name 'azurerm_web_app_function'
  desc 'Verifies settings for an Azure Virtual Network'
  example <<-EXAMPLE
    describe azurerm_web_app_function(resource_group: 'rg-nm1', site_name: "my-site", function_name: 'HttpTriggerJS1') do
      it            { should exist }
      its('type')   { should cmp 'Microsoft.Web/sites/functions' }
    end
  EXAMPLE

  def initialize(opts = {})
    Inspec::Log.warn Helpers.resource_deprecation_message(@__resource_name__, AzureWebAppFunction.name)
    # Options should be Hash type. Otherwise Ruby will raise an error when we try to access the keys.
    raise ArgumentError, 'Parameters must be provided in an Hash object.' unless opts.is_a?(Hash)

    # For backward compatibility.
    opts[:api_version] ||= '2018-02-01'
    super
  end
end
