---
title: About the azure_web_app_functions Resource
platform: azure
---

# azure_web_app_functions

Use the `azure_web_app_functions` InSpec audit resource to test properties related to Azure functions for a resource group or the entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

This resource interacts with API versions supported by the resource provider.
This resource will use the latest version unless the `api-version` is defined as a resource parameter.

For more information, refer to [`azure_generic_resource`](azure_generic_resource.md).

Unless defined, this resource uses the `azure_cloud` global endpoint and the default values for the HTTP client. For more information, refer to the resource pack [README](../../README.md).

## Availability

### Installation

This resource is available in the [InSpec Azure resource pack](https://github.com/inspec/inspec-azure).
For an example `inspec.yml` file and how to set up your Azure credentials, refer to resource pack [README](../../README.md#Service-Principal).

## Syntax

An `azure_web_app_functions` resource block returns all Azure functions, either within a Resource Group (if provided), or within an entire Subscription.

```ruby
describe azure_web_app_functions(resource_group: 'my-rg', site_name: 'function-app-http') do
  #...
end
```

or

```ruby
describe azure_web_app_functions(resource_group: 'my-rg', site_name: 'function-app-http') do
  #...
end
```

## Parameters

`resource_group`
: Name of the Azure resource group that the targeted resource resides in.

`site_name`
: Name of the Azure Function App to test.

## Properties

|Property       | Description                                                                          | Filter Criteria<superscript>*</superscript> |
|---------------|--------------------------------------------------------------------------------------|-----------------|
| ids           | A list of the unique resource ids.                                                   | `id`            |
| names         | A list of all the key vault names.                                                   | `name`          |
| types         | A list of types of all the functions.                                                | `type`           |
| locations     | A list of locations for all the functions.                                           | `location`       |
| properties    | A list of properties for all the functions.                                          | `properties`     |

<superscript>*</superscript> For information on how to use filter criteria on plural resources, refer to [FilterTable usage](https://github.com/inspec/inspec/blob/master/dev-docs/filtertable-usage.md).

## Examples

### Loop Through Functions by Their IDs

```ruby
azure_web_app_functions(resource_group: 'my-rg', site_name: 'function-app-http').ids.each do |id|
  describe azure_web_app_function(resource_id: id) do
    it { should exist }
  end
end
```

### Test That There Are Functions That Includes a Certain String in Their Names (Client Side Filtering)

```ruby
describe azure_web_app_functions(resource_group: 'my-rg', site_name: 'function-app-http').where { name.include?('queue') } do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no functions are in the resource group
describe azure_web_app_functions(resource_group: 'MyResourceGroup', site_name: 'function-app-http') do
  it { should_not exist }
end

# Should exist if the filter returns at least one key vault
describe azure_web_app_functions(resource_group: 'MyResourceGroup', site_name: 'function-app-http') do
  it { should exist }
end
```
## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be setup with a `contributor` role on the subscription you wish to test.
