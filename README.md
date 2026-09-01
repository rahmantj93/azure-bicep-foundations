![Validate Bicep](https://github.com/rahmantj93/azure-bicep-foundations/actions/workflows/validate.yml/badge.svg)

# azure-bicep-foundations

A parameterised Bicep template that deploys an Azure Storage account with
a hardened TLS configuration.

Azure creates storage accounts with a minimum TLS version of 1.0 by default.
This template sets it explicitly to 1.2, so the secure configuration is
recorded in code rather than left to a platform default.

The deployment region is a parameter rather than a hardcoded value, so the
same template can target different regions without being edited.

## Prerequisites

- Azure CLI (`az version` to verify)
- An Azure subscription with permission to create resources
- VS Code with the Bicep extension (recommended)

## Usage

Compile the template and check for syntax errors:

```bash
az bicep build --file main.bicep
```

Preview what the deployment would change, without applying it:

```bash
az deployment group what-if \
  --resource-group <your-resource-group> \
  --template-file main.bicep
```

Deploy:

```bash
az deployment group create \
  --resource-group <your-resource-group> \
  --template-file main.bicep
```

Override the region at deployment time:

```bash
az deployment group create \
  --resource-group <your-resource-group> \
  --template-file main.bicep \
  --parameters location=westeurope
```

## Continuous integration

Every push and pull request to `main` compiles the template with
`az bicep build`, so syntax and schema errors are caught before merge.

Deployment previews (`what-if`) are run locally rather than in CI. Automating
them would require a service principal, and app registration is disabled in
the Entra tenant this subscription belongs to.

This is a useful illustration of Azure's two separate permission planes.
The account used here holds the Owner role on the subscription, which grants
full control over resources through Azure RBAC. Registering an application is
a Microsoft Entra ID operation, governed by directory roles and tenant-level
settings. Full authority in one plane confers nothing in the other.