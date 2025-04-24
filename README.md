# README for the project Generate Custom Properties Schema

**Script for generating a custom-properties schema to be used in conjunction with PandasWhoCode action:
[Configure Custom Properties](https://github.com/marketplace/actions/set-custom-properties-schema-action)**

You must be authenticated with GitHub and have permission to view the organization's properties.
This script will generate a `custom_props.json` file that can be used to set custom properties
for your GitHub organization using the existing custom properties of your organization (or another
which you have appropriate permissions to view)

---

## Getting Started

1. Clone this Github repository
2. Execute the `generate-custom-properties-schema.sh` script to create a `custom_props.json` file.
3. Move the `custom_props.json` file to the `.github` directory of your repository.

---

## Requirements

- [`gh`](https://cli.github.com/) (GitHub CLI)
- [`jq`](https://stedolan.github.io/jq/) (Command-line JSON processor)

Ensure these tools are installed and available in your `PATH`.

---

## Options

| Name | Description                    | Required               | Default              |
|------|--------------------------------|------------------------|----------------------|
| `-o` | Github Organization/Owner name | :white_check_mark: Yes | —                    |
| `-n` | Name for the output file       | :x: No                 | `custom_props.json`  |
| `-h` | Show help                      | :x: No                 | —                    |

---

## Usage

```bash
./generate-custom-properties-schema.sh -o ORG [-n FILENAME]
```

### Example Usage

```bash
git clone --depth 1 https://github.com/PandasWhoCode/generate-custom-properties-schema.git
cd generate-custom-properties-schema

gh auth login # follow the prompts, ensure you are logged into gh cli
./generate-custom-properties-schema.sh -o MyOrganization -n my-custom-props.json

cp my-custom-props.json <path_to_your_repo>/.github/my-custom-props.json
```

### Example `.github/custom_props.json`

`custom_props.json`:

```json
{
  "properties": [
    {
      "property_name": "single_select_property",
      "value_type": "single_select",
      "allowed_values": [
        "option-1",
        "option-2",
        "option-3",
        "option-4"
      ],
      "description": "Default single select property",
      "values_editable_by": "org_and_repo_actors",
      "required": false
    },
    {
      "property_name": "multi_select_property",
      "value_type": "multi_select",
      "allowed_values": [
        "option-1",
        "option-2",
        "option-3",
        "option-4"
      ],
      "description": "Default multi select property",
      "values_editable_by": "org_and_repo_actors",
      "required": false
    },
    {
      "property_name": "text_property",
      "value_type": "string",
      "description": "Default 'text' property type",
      "values_editable_by": "org_and_repo_actors",
      "required": false
    },
    {
      "property_name": "bool_test",
      "value_type": "true_false",
      "description": "Default true-false property type",
      "values_editable_by": "org_and_repo_actors",
      "required": false
    }
  ]
}
```

## 👤 Author

Roger Barker

[PandasWhoCode](https://pandaswhocode.com)

[roger@pandaswhocode.com](mailto:roger@pandaswhocode.com)

---