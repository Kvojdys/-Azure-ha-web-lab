# -Azure-ha-web-lab
# Azure High-Availability Web Infrastructure

Tento projekt je implementací vysoce dostupné webové infrastruktury v prostředí Microsoft Azure. Cílem bylo vytvořit bezpečné, škálovatelné a odolné prostředí pro webovou aplikaci bez použití veřejných IP adres na backendových serverech.
 Architektura

Řešení využívá N-tier architekturu s důrazem na bezpečnost (Zero Trust principy).

![Diagram architektury](./diagrams/architecture.png)

Klíčové komponenty:
- Load Balancer (Standard):** Distribuuje provoz a kontroluje zdraví serverů (Health Probes).
- Virtual Machines:** Dva webové servery běžící ve Windows Server 2022, umístěné v **Availability Setu** (Fault Domains) pro zajištění SLA 99.95%.
- Networking:**
- VNet Segmentation:** Oddělené podsítě pro web (`snet-web`) a správu (`snet-admin`).
- NSG (Network Security Groups):** Striktní pravidla. RDP přístup povolen pouze z Jumpboxu, HTTP přístup pouze skrze Load Balancer.
- Storage:** Azure Files (SMB) připojené jako sdílený disk pro zajištění bezstavovosti (stateless) webových serverů.
- Security:** Backend servery nemají veřejnou IP adresu. Správa probíhá skrze **Jumpbox (Bastion Host)**.

Použité technologie
- Azure Compute (VM, Availability Sets)
- Azure Networking (VNet, NSG, LB, Public IP)
- Azure Storage (Files)
- PowerShell (Konfigurace IIS, Firewallu)

- 🛠 Konfigurace a Troubleshooting
Během nasazení jsem řešil problém s blokováním Health Probe ze strany Windows Firewallu.
- Řešení:** Úprava pravidel NSG pro `AzureLoadBalancer` Service Tag a konfigurace Windows Firewallu přes Azure Run Command.

Struktura repozitáře
- `/infrastructure` - Exportovaná ARM a Bicep šablona zdrojů (Infrastructure as Code).
- `/scripts` - PowerShell skripty použité pro konfiguraci VM.
- `/diagrams` - Vizuální schéma topologie.
