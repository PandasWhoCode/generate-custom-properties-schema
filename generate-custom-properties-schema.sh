#!/bin/bash

# SPDX-License-Identifier: Apache-2.0
# See LICENSE file in the project root for full license information.
#
# Generate the custom properties schema file for a github organization
#
# Basic assumptions:
# - jq and gh are installed on the system calling this script.
# - The user has access to the github organization and has the necessary permissions to view the properties.
generate_custom_props_file() {

    # Parse args
    while getopts ":ho:r:n:" opt; do
        case $opt in
            o) ORG="$OPTARG" ;;  # Github Organization/Owner name
            n) NAME="$OPTARG" ;; # Filename to save the schema
            h) echo "Usage: generate_custom_props_file [-h] -o ORG [-n FILENAME]"; return 0 ;;
            \?) echo "Invalid option: -$OPTARG" >&2; return 1 ;;
            :) echo "Option -$OPTARG requires an argument." >&2; return  2;;
        esac
    done

    # Error checking. Verify that required argument (ORG) is set.
    if [[ -z "${ORG}" ]]; then
        echo "Error: Organization must be specified." >&2
        return 3
    fi

    # If no filename is specified, use the default name
    NAME=${NAME:-"custom_props.json"}

    # Write the schema to a file
    echo "{" > "${NAME}"
    echo "  \"properties\":" >> "${NAME}"
    gh api /orgs/"${ORG}"/properties/schema | jq -r 'del(.[]|.["url","source_type"])' >> "${NAME}"
    echo "}" >> "${NAME}"

    # Pretty-format the JSON file using jq.
    cat "${NAME}" | jq . > custom_props.json.tmp
    mv custom_props.json.tmp "${NAME}"
}

generate_custom_props_file "$@"

