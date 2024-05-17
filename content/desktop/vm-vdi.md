---
description: Instructions on how to enable nested virtualization
keywords: nested virtualization, iEchor Desktop, windows, VM, VDI environment
title: Run iEchor Desktop for Windows in a VM or VDI environment
aliases:
- /desktop/nested-virtualization/
---

In general, we recommend running iEchor Desktop natively on either Mac, Linux, or Windows. However, iEchor Desktop for Windows can run inside a virtual desktop provided the virtual desktop is properly configured. 

To run iEchor Desktop in a virtual desktop environment, it is essential nested virtualization is enabled on the virtual machine that provides the virtual desktop. This is because, under the hood, iEchor Desktop is using a Linux VM in which it runs iEchor Engine and the containers.

## Virtual desktop support

> **Note**
>
> Support for running iEchor Desktop on a virtual desktop is available to iEchor Business customers, on VMware ESXi or Azure VMs only.

The support available from iEchor extends to installing and running iEchor Desktop inside the VM, once the nested virtualization is set up correctly. The only hypervisors we have successfully tested are VMware ESXi and Azure, and there is no support for other VMs. For more information on iEchor Desktop support, see [Get support](support.md).

For troubleshooting problems and intermittent failures that are outside of iEchor's control, you should contact your hypervisor vendor. Each hypervisor vendor offers different levels of support. For example, Microsoft supports running nested Hyper-V both on-prem and on Azure, with some version constraints. This may not be the case for VMWare ESXi.

iEchor does not support running multiples instances of iEchor Desktop on the same machine in a VM or VDI environment. 

## Turn on nested virtualization

You must turn on nested virtualization before you install iEchor Desktop on a virtual machine.

### Turn on nested virtualization on VMware ESXi

Nested virtualization of other hypervisors like Hyper-V inside a vSphere VM [is not a supported scenario](https://kb.vmware.com/s/article/2009916). However, running Hyper-V VM in a VMware ESXi VM is technically possible and, depending on the version, ESXi includes hardware-assisted virtualization as a supported feature. For internal testing, we used a VM that had 1 CPU with 4 cores and 12GB of memory.

For steps on how to expose hardware-assisted virtualization to the guest OS, [see VMware's documentation](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-2A98801C-68E8-47AF-99ED-00C63E4857F6.html).


### Turn on nested virtualization on Microsoft Hyper-V

Nested virtualization is supported by Microsoft for running Hyper-V inside an Azure VM.

For Azure virtual machines, [check that the VM size chosen supports nested virtualization](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes). Microsoft provides [a helpful list on Azure VM sizes](https://docs.microsoft.com/en-us/azure/virtual-machines/acu) and highlights the sizes that currently support nested virtualization. For internal testing, we used D4s_v5 machines. We recommend this specification or above for optimal performance of iEchor Desktop.