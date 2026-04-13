#!/bin/bash
# bump-version.sh
OLD=$1  # e.g. 3.0.0-SNAPSHOT
NEW=$2  # e.g. 3.0.0

MODULES=(
    sdk-parent
    sdk-bom
    sdk-build
    sdk-common
    sdk-common-systables
    sdk-protocol-core
    sdk-protocol-tcpip
    sdk-protocol-web
    jnetpcap-bindings
    jnetpcap-api
    jnetpcap-sdk
)

for module in "${MODULES[@]}"; do
    pom=~/devl/sdk-jnetpcap/$module/pom.xml
    if [ -f "$pom" ]; then
        sed -i "s|<version>$OLD</version>|<version>$NEW</version>|g" "$pom"
        echo "Updated: $module"
    fi
done
