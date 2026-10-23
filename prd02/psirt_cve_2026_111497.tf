# PSIRT: CVE-2026-111497 ("Node2Shell") - Node.js Brotli decoder memory corruption / RCE
# Jira: SEC-11585 | Slack: #psirt-cve-2026-111497
#
# Interim edge mitigation while Node.js services are upgraded: reject any request whose
# Content-Encoding header declares Brotli ("br"), including inside lists like "gzip, br".
# Matching is case-insensitive and covers repeated Content-Encoding headers.
# Browsers and API clients essentially never send Brotli-compressed request bodies.
#
# Rollout: ships as "log" so we can confirm there is no legitimate traffic in Security Events,
# then flip cve_2026_111497_action to "block". Remove once remediation is complete.
#
# This rule is prepended to every additional_waf_rules list in this workspace so that no
# existing "skip" rule can bypass it.
locals {
  cve_2026_111497_action = "log"

  cve_2026_111497_waf_rules = [
    {
      action      = local.cve_2026_111497_action
      description = "SEC-11585 / CVE-2026-111497 - Brotli-compressed request bodies (Content-Encoding: br)"
      expression  = "any(lower(http.request.headers[\"content-encoding\"][*])[*] contains \"br\")"
    },
  ]
}
