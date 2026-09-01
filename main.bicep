param location string = 'centralindia'

resource stg 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'stlabtz${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
  }
}
