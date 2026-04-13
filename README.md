# Sly Technologies SDK Build

Reactor aggregator for the Sly Technologies SDK OSS modules. Running Maven from this directory builds all open-source SDK modules in the correct dependency order.

## Overview

`sdk-build` contains no code. It is a Maven reactor POM that lists all OSS SDK modules as `<modules>`, allowing Maven to resolve the full dependency graph and build everything in one command.

## Requirements

| Tool  | Version |
| ----- | ------- |
| Java  | 22+     |
| Maven | 3.9+    |

All modules must be checked out as siblings of `sdk-build` in a flat directory layout:

```
~/devl/sdks/
├── sdk-build/          ← run Maven from here
├── sdk-parent/
├── sdk-bom/
├── sdk-common/
├── sdk-common-systables/
├── sdk-protocol-core/
├── sdk-protocol-tcpip/
├── sdk-protocol-web/
├── sdk-protocol-infra/
├── jnetpcap-api/       ← activated via -P jnetpcap
├── jnetpcap-bindings/
├── jnetpcap-sdk/
├── jnetpcap-examples/
├── jnetworks-api/      ← activated via -P jnetworks
├── jnetworks-pcap/
├── jnetworks-file-pcap/
├── jnetworks-sdk/
└── jnetworks-examples/
```

## Build Commands

All commands are run from the `sdk-build/` directory.

**Core modules only (sdk-common + protocols):**

```bash
mvn clean install
```

**Include jNetPcap modules:**

```bash
mvn clean install -P jnetpcap
```

**Include jNetWorks modules:**

```bash
mvn clean install -P jnetworks
```

**Full OSS build:**

```bash
mvn clean install -P jnetpcap,jnetworks
```

**Deploy snapshots to Maven Central:**

```bash
mvn clean deploy -P jnetpcap,jnetworks
```

**Skip tests:**

```bash
mvn clean install -DskipTests
```

## Build Profiles

Profiles allow building subsets of the SDK without requiring all module directories to be present on disk. Maven only validates modules that are active for the current invocation.

| Profile     | Modules Added                                                |
| ----------- | ------------------------------------------------------------ |
| *(default)* | sdk-parent, sdk-bom, sdk-common, sdk-common-systables, sdk-protocol-* |
| `jnetpcap`  | jnetpcap-api, jnetpcap-bindings, jnetpcap-sdk, jnetpcap-examples |
| `jnetworks` | jnetworks-api, jnetworks-pcap, jnetworks-file-pcap, jnetworks-sdk, jnetworks-examples |

## Module Dependency Order

Maven resolves build order automatically from the dependency graph. The logical order is:

```
sdk-parent
└── sdk-bom
    └── sdk-common
        ├── sdk-common-systables
        └── sdk-protocol-core
            ├── sdk-protocol-tcpip
            │   ├── sdk-protocol-web
            │   └── sdk-protocol-infra
            └── jnetpcap-bindings
                ├── jnetpcap-api
                │   └── jnetpcap-sdk
                │       └── jnetpcap-examples
                └── jnetworks-api
                    ├── jnetworks-pcap
                    │   └── jnetworks-sdk
                    └── jnetworks-file-pcap
                        └── jnetworks-examples
```

## Related Modules

| Module                                                     | Description                                       |
| ---------------------------------------------------------- | ------------------------------------------------- |
| [sdk-parent](https://github.com/slytechs-repos/sdk-parent) | Parent POM — shared build configuration           |
| [sdk-bom](https://github.com/slytechs-repos/sdk-bom)       | Bill of Materials — dependency version management |

## License

Licensed under the [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0).