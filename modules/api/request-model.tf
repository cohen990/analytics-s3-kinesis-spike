resource "aws_api_gateway_model" "stats" {
  rest_api_id  = aws_api_gateway_rest_api.stats.id
  name         = "hit"
  content_type = "application/json"

  schema = <<EOF
{
    "type": "object",
    "additionalProperties": false,
    "properties": {
        "u": {
            "type": "string",
            "maxLength": 1024
        },
        "r": {
            "type": "string",
            "maxLength": 1024
        },
        "t": {
            "type": "integer"
        },
        "a": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
                "s": {
                    "type": "string",
                    "maxLength": 1024
                },
                "v": {
                    "type": "number"
                }
            }
        },
        "p": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
                "ttfb": {
                    "type": "integer"
                },
                "fcp": {
                    "type": "integer"
                },
                "lcp": {
                    "type": "integer"
                }
            }
        }
    },
    "required": [
        "u",
        "t"
    ],
    "title": "Codefiend Hit"
}
EOF
}
