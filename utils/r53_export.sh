#!/bin/bash

# The `prod-read` AWS profile is required to have the list-resource-record-sets permission
HOSTED_ZONE_ID=$1
aws route53 list-resource-record-sets --hosted-zone-id "$HOSTED_ZONE_ID" | jq -jr '.ResourceRecordSets[] | "
{
  name = \"\(.Name)\"
  ttl = \"\(.TTL)\"
  type = \"\(.Type)\"
  value = \"\(.ResourceRecords[]?.Value)\"
},"' > export.json
