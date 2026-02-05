param virtualMachines_vm_admin_name string
param availabilitySets_aset_web_name string
param virtualMachines_vm_web_01_name string
param virtualMachines_vm_web_02_name string
param storageAccounts_sthawebkk_name string
param loadBalancers_Ib_web_public_name string
param publicIPAddresses_pip_lb_web_name string
param networkInterfaces_vm_admin843_name string
param networkSecurityGroups_nsg_web_name string
param publicIPAddresses_vm_admin_ip_name string
param networkInterfaces_vm_web_01993_name string
param networkInterfaces_vm_web_02193_name string
param vaults_vault_ml80zndm_name string
param networkSecurityGroups_vm_admin_nsg_name string
param virtualNetworks_vnet_contoso_weu_001_name string

resource networkSecurityGroups_nsg_web_name_resource 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: networkSecurityGroups_nsg_web_name
  location: 'westeurope'
  properties: {
    securityRules: [
      {
        name: 'Allow-HTTP'
        id: networkSecurityGroups_nsg_web_name_Allow_HTTP.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Allow-RDP-From-Admin'
        id: networkSecurityGroups_nsg_web_name_Allow_RDP_From_Admin.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '10.0.10.0/24'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Allow-LB-Probe'
        id: networkSecurityGroups_nsg_web_name_Allow_LB_Probe.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: 'AzureLoadBalancer'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 105
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_vm_admin_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: networkSecurityGroups_vm_admin_nsg_name
  location: 'westeurope'
  properties: {
    securityRules: [
      {
        name: 'RDP'
        id: networkSecurityGroups_vm_admin_nsg_name_RDP.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource publicIPAddresses_pip_lb_web_name_resource 'Microsoft.Network/publicIPAddresses@2024-07-01' = {
  name: publicIPAddresses_pip_lb_web_name
  location: 'westeurope'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '2'
    '1'
    '3'
  ]
  properties: {
    ipAddress: '52.236.159.52'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

resource publicIPAddresses_vm_admin_ip_name_resource 'Microsoft.Network/publicIPAddresses@2024-07-01' = {
  name: publicIPAddresses_vm_admin_ip_name
  location: 'westeurope'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '20.107.24.18'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

resource vaults_vault_ml80zndm_name_resource 'Microsoft.RecoveryServices/vaults@2025-02-01' = {
  name: vaults_vault_ml80zndm_name
  location: 'westeurope'
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {
    securitySettings: {
      softDeleteSettings: {
        softDeleteRetentionPeriodInDays: 14
        softDeleteState: 'Enabled'
        enhancedSecurityState: 'Enabled'
      }
      sourceScanConfiguration: {
        state: 'Disabled'
      }
    }
    redundancySettings: {
      standardTierStorageRedundancy: 'GeoRedundant'
      crossRegionRestore: 'Disabled'
    }
    publicNetworkAccess: 'Enabled'
    restoreSettings: {
      crossSubscriptionRestoreSettings: {
        crossSubscriptionRestoreState: 'Enabled'
      }
    }
  }
}

resource storageAccounts_sthawebkk_name_resource 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: storageAccounts_sthawebkk_name
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource virtualMachines_vm_admin_name_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: virtualMachines_vm_admin_name
  location: 'westeurope'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm_admin_name}_OsDisk_1_c7448fdf541c4c13b651d01e8eced883'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_vm_admin_name}_OsDisk_1_c7448fdf541c4c13b651d01e8eced883'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_vm_admin_name
      adminUsername: 'azureuser'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_admin843_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource loadBalancers_Ib_web_public_name_resource 'Microsoft.Network/loadBalancers@2024-07-01' = {
  name: loadBalancers_Ib_web_public_name
  location: 'westeurope'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: 'pip-lb-frondend'
        id: '${loadBalancers_Ib_web_public_name_resource.id}/frontendIPConfigurations/pip-lb-frondend'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_pip_lb_web_name_resource.id
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'pool-web-servers'
        id: loadBalancers_Ib_web_public_name_pool_web_servers.id
        properties: {
          loadBalancerBackendAddresses: [
            {
              name: 'rg-project-ha-web-weu-001_vm-web-02193ipconfig1'
              properties: {}
            }
            {
              name: 'rg-project-ha-web-weu-001_vm-web-01993ipconfig1'
              properties: {}
            }
          ]
        }
      }
    ]
    loadBalancingRules: [
      {
        name: 'rele-web-80'
        id: '${loadBalancers_Ib_web_public_name_resource.id}/loadBalancingRules/rele-web-80'
        properties: {
          frontendIPConfiguration: {
            id: '${loadBalancers_Ib_web_public_name_resource.id}/frontendIPConfigurations/pip-lb-frondend'
          }
          frontendPort: 80
          backendPort: 80
          enableFloatingIP: false
          idleTimeoutInMinutes: 4
          protocol: 'Tcp'
          enableTcpReset: false
          loadDistribution: 'Default'
          disableOutboundSnat: true
          enableConnectionTracking: false
          backendAddressPool: {
            id: loadBalancers_Ib_web_public_name_pool_web_servers.id
          }
          backendAddressPools: [
            {
              id: loadBalancers_Ib_web_public_name_pool_web_servers.id
            }
          ]
          probe: {
            id: '${loadBalancers_Ib_web_public_name_resource.id}/probes/probe-web-http'
          }
        }
      }
    ]
    probes: [
      {
        name: 'probe-web-http'
        id: '${loadBalancers_Ib_web_public_name_resource.id}/probes/probe-web-http'
        properties: {
          protocol: 'Http'
          port: 80
          requestPath: '/'
          intervalInSeconds: 5
          numberOfProbes: 1
          probeThreshold: 1
          noHealthyBackendsBehavior: 'AllProbedDown'
        }
      }
    ]
    inboundNatRules: []
    outboundRules: []
    inboundNatPools: []
  }
}

resource loadBalancers_Ib_web_public_name_pool_web_servers 'Microsoft.Network/loadBalancers/backendAddressPools@2024-07-01' = {
  name: '${loadBalancers_Ib_web_public_name}/pool-web-servers'
  properties: {
    loadBalancerBackendAddresses: [
      {
        name: 'rg-project-ha-web-weu-001_vm-web-02193ipconfig1'
        properties: {}
      }
      {
        name: 'rg-project-ha-web-weu-001_vm-web-01993ipconfig1'
        properties: {}
      }
    ]
  }
  dependsOn: [
    loadBalancers_Ib_web_public_name_resource
  ]
}

resource networkSecurityGroups_nsg_web_name_Allow_HTTP 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_nsg_web_name}/Allow-HTTP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_web_name_resource
  ]
}

resource networkSecurityGroups_nsg_web_name_Allow_LB_Probe 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_nsg_web_name}/Allow-LB-Probe'
  properties: {
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: 'AzureLoadBalancer'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 105
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_web_name_resource
  ]
}

resource networkSecurityGroups_nsg_web_name_Allow_RDP_From_Admin 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_nsg_web_name}/Allow-RDP-From-Admin'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '10.0.10.0/24'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 110
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_web_name_resource
  ]
}

resource networkSecurityGroups_vm_admin_nsg_name_RDP 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_vm_admin_nsg_name}/RDP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 300
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_admin_nsg_name_resource
  ]
}

resource virtualNetworks_vnet_contoso_weu_001_name_resource 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: virtualNetworks_vnet_contoso_weu_001_name
  location: 'westeurope'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'snet-admin'
        id: virtualNetworks_vnet_contoso_weu_001_name_snet_admin.id
        properties: {
          addressPrefixes: [
            '10.0.1.0/24'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'snet-web'
        id: virtualNetworks_vnet_contoso_weu_001_name_snet_web.id
        properties: {
          addressPrefixes: [
            '10.0.0.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_web_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'snet-westeurope-1'
        id: virtualNetworks_vnet_contoso_weu_001_name_snet_westeurope_1.id
        properties: {
          addressPrefixes: [
            '10.0.2.0/24'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_contoso_weu_001_name_snet_admin 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${virtualNetworks_vnet_contoso_weu_001_name}/snet-admin'
  properties: {
    addressPrefixes: [
      '10.0.1.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnet_contoso_weu_001_name_resource
  ]
}

resource virtualNetworks_vnet_contoso_weu_001_name_snet_westeurope_1 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${virtualNetworks_vnet_contoso_weu_001_name}/snet-westeurope-1'
  properties: {
    addressPrefixes: [
      '10.0.2.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnet_contoso_weu_001_name_resource
  ]
}

resource vaults_vault_ml80zndm_name_DailyPolicy_ml80znk9 'Microsoft.RecoveryServices/vaults/backupPolicies@2025-02-01' = {
  parent: vaults_vault_ml80zndm_name_resource
  name: 'DailyPolicy-ml80znk9'
  properties: {
    backupManagementType: 'AzureStorage'
    workLoadType: 'AzureFileShare'
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2026-02-04T19:30:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2026-02-04T19:30:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_vault_ml80zndm_name_DefaultPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2025-02-01' = {
  parent: vaults_vault_ml80zndm_name_resource
  name: 'DefaultPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    policyType: 'V1'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2026-02-04T22:30:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2026-02-04T22:30:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_vault_ml80zndm_name_EnhancedPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2025-02-01' = {
  parent: vaults_vault_ml80zndm_name_resource
  name: 'EnhancedPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    policyType: 'V2'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicyV2'
      scheduleRunFrequency: 'Hourly'
      hourlySchedule: {
        interval: 4
        scheduleWindowStartTime: '2026-02-04T08:00:00Z'
        scheduleWindowDuration: 12
      }
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2026-02-04T08:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_vault_ml80zndm_name_HourlyLogBackup 'Microsoft.RecoveryServices/vaults/backupPolicies@2025-02-01' = {
  parent: vaults_vault_ml80zndm_name_resource
  name: 'HourlyLogBackup'
  properties: {
    backupManagementType: 'AzureWorkload'
    workLoadType: 'SQLDataBase'
    settings: {
      timeZone: 'UTC'
      issqlcompression: false
      isCompression: false
    }
    subProtectionPolicy: [
      {
        policyType: 'Full'
        schedulePolicy: {
          schedulePolicyType: 'SimpleSchedulePolicy'
          scheduleRunFrequency: 'Daily'
          scheduleRunTimes: [
            '2026-02-04T22:30:00Z'
          ]
          scheduleWeeklyFrequency: 0
        }
        retentionPolicy: {
          retentionPolicyType: 'LongTermRetentionPolicy'
          dailySchedule: {
            retentionTimes: [
              '2026-02-04T22:30:00Z'
            ]
            retentionDuration: {
              count: 30
              durationType: 'Days'
            }
          }
        }
      }
      {
        policyType: 'Log'
        schedulePolicy: {
          schedulePolicyType: 'LogSchedulePolicy'
          scheduleFrequencyInMins: 60
        }
        retentionPolicy: {
          retentionPolicyType: 'SimpleRetentionPolicy'
          retentionDuration: {
            count: 30
            durationType: 'Days'
          }
        }
      }
    ]
    protectedItemsCount: 0
  }
}

resource vaults_vault_ml80zndm_name_defaultAlertSetting 'Microsoft.RecoveryServices/vaults/replicationAlertSettings@2025-02-01' = {
  parent: vaults_vault_ml80zndm_name_resource
  name: 'defaultAlertSetting'
  properties: {
    sendToOwners: 'DoNotSend'
    customEmailAddresses: []
  }
}

resource vaults_vault_ml80zndm_name_default 'Microsoft.RecoveryServices/vaults/replicationVaultSettings@2025-02-01' = {
  parent: vaults_vault_ml80zndm_name_resource
  name: 'default'
  properties: {}
}

resource storageAccounts_sthawebkk_name_default 'Microsoft.Storage/storageAccounts/blobServices@2025-01-01' = {
  parent: storageAccounts_sthawebkk_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_sthawebkk_name_default 'Microsoft.Storage/storageAccounts/fileServices@2025-01-01' = {
  parent: storageAccounts_sthawebkk_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 14
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_sthawebkk_name_default 'Microsoft.Storage/storageAccounts/queueServices@2025-01-01' = {
  parent: storageAccounts_sthawebkk_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_sthawebkk_name_default 'Microsoft.Storage/storageAccounts/tableServices@2025-01-01' = {
  parent: storageAccounts_sthawebkk_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource availabilitySets_aset_web_name_resource 'Microsoft.Compute/availabilitySets@2024-11-01' = {
  name: availabilitySets_aset_web_name
  location: 'westeurope'
  sku: {
    name: 'Aligned'
  }
  properties: {
    platformUpdateDomainCount: 5
    platformFaultDomainCount: 2
    virtualMachines: [
      {
        id: virtualMachines_vm_web_01_name_resource.id
      }
      {
        id: virtualMachines_vm_web_02_name_resource.id
      }
    ]
  }
}

resource virtualMachines_vm_web_01_name_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: virtualMachines_vm_web_01_name
  location: 'westeurope'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }
    availabilitySet: {
      id: availabilitySets_aset_web_name_resource.id
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm_web_01_name}_OsDisk_1_177795e9556f41c0ab60a3e2e5ad8f8d'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_vm_web_01_name}_OsDisk_1_177795e9556f41c0ab60a3e2e5ad8f8d'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_vm_web_01_name
      adminUsername: 'azureuser'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_web_01993_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource virtualMachines_vm_web_02_name_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: virtualMachines_vm_web_02_name
  location: 'westeurope'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }
    availabilitySet: {
      id: availabilitySets_aset_web_name_resource.id
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm_web_02_name}_OsDisk_1_dad3fce83ccb4d7fa40b415e0daa32ee'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_vm_web_02_name}_OsDisk_1_dad3fce83ccb4d7fa40b415e0daa32ee'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_vm_web_02_name
      adminUsername: 'azureuser'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_web_02193_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource virtualNetworks_vnet_contoso_weu_001_name_snet_web 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${virtualNetworks_vnet_contoso_weu_001_name}/snet-web'
  properties: {
    addressPrefixes: [
      '10.0.0.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_web_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnet_contoso_weu_001_name_resource
  ]
}

resource storageAccounts_sthawebkk_name_default_web_content 'Microsoft.Storage/storageAccounts/fileServices/shares@2025-01-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_sthawebkk_name_default
  name: 'web-content'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_sthawebkk_name_resource
  ]
}

resource networkInterfaces_vm_admin843_name_resource 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: networkInterfaces_vm_admin843_name
  location: 'westeurope'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_admin843_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.1.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_vm_admin_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: virtualNetworks_vnet_contoso_weu_001_name_snet_admin.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_vm_admin_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkInterfaces_vm_web_01993_name_resource 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: networkInterfaces_vm_web_01993_name
  location: 'westeurope'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_web_01993_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_vnet_contoso_weu_001_name_snet_web.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          loadBalancerBackendAddressPools: [
            {
              id: loadBalancers_Ib_web_public_name_pool_web_servers.id
            }
          ]
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_web_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkInterfaces_vm_web_02193_name_resource 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: networkInterfaces_vm_web_02193_name
  location: 'westeurope'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_web_02193_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.2.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_vnet_contoso_weu_001_name_snet_westeurope_1.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          loadBalancerBackendAddressPools: [
            {
              id: loadBalancers_Ib_web_public_name_pool_web_servers.id
            }
          ]
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_web_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}
