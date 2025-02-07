/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/******************************************
  Mandatory firewall rules
 *****************************************/

resource "google_compute_firewall" "deny_all_egress" {
  name      = "fw-${var.environment_code}-shared-base-65535-e-d-all-all-all"
  network   = var.network
  project   = var.project_id[var.envt]
  direction = "EGRESS"
  priority  = 65535

  dynamic "log_config" {
    for_each = var.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  deny {
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]
}


resource "google_compute_firewall" "allow_private_api_egress" {
  name      = "fw-${var.environment_code}-shared-base-65534-e-a-allow-google-apis-all-tcp-443"
  network   = var.network
  project   = var.project_id[var.envt]
  direction = "EGRESS"
  priority  = 65534

  dynamic "log_config" {
    for_each = var.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  destination_ranges = [local.private_googleapis_cidr]

  target_tags = ["allow-google-apis"]
}

/******************************************
  Optional firewall rules
 *****************************************/

// Allow SSH via IAP when using the allow-iap-ssh tag for Linux workloads.
resource "google_compute_firewall" "allow_iap_ssh" {
  count   = var.optional_fw_rules_enabled ? 1 : 0
  name    = "fw-${var.environment_code}-shared-base-1000-i-a-all-allow-iap-ssh-tcp-22"
  network = var.network
  project = var.project_id[var.envt]

  dynamic "log_config" {
    for_each = var.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  // Cloud IAP's TCP forwarding netblock
  source_ranges = concat(data.google_netblock_ip_ranges.iap_forwarders.cidr_blocks_ipv4)

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["allow-iap-ssh"]
}

// Allow RDP via IAP when using the allow-iap-rdp tag for Windows workloads.
resource "google_compute_firewall" "allow_iap_rdp" {
  count   = var.optional_fw_rules_enabled ? 1 : 0
  name    = "fw-${var.environment_code}-shared-base-1000-i-a-all-allow-iap-rdp-tcp-3389"
  network = var.network
  project = var.project_id[var.envt]

  dynamic "log_config" {
    for_each = var.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  // Cloud IAP's TCP forwarding netblock
  source_ranges = concat(data.google_netblock_ip_ranges.iap_forwarders.cidr_blocks_ipv4)

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  target_tags = ["allow-iap-rdp"]
}

// Allow access to kms.windows.googlecloud.com for Windows license activation
resource "google_compute_firewall" "allow_windows_activation" {
  count     = var.windows_activation_enabled ? 1 : 0
  name      = "fw-${var.environment_code}-shared-base-0-e-a-allow-win-activation-all-tcp-1688"
  network   = var.network
  project   = var.project_id[var.envt]
  direction = "EGRESS"
  priority  = 0

  dynamic "log_config" {
    for_each = var.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  allow {
    protocol = "tcp"
    ports    = ["1688"]
  }

  destination_ranges = ["35.190.247.13/32"]

  target_tags = ["allow-win-activation"]
}

// Allow traffic for Internal & Global load balancing health check and load balancing IP ranges.
resource "google_compute_firewall" "allow_lb" {
  count   = var.optional_fw_rules_enabled ? 1 : 0
  name    = "fw-${var.environment_code}-shared-base-1000-i-a-all-allow-lb-tcp-80-8080-443"
  network = var.network
  project = var.project_id[var.envt]

  dynamic "log_config" {
    for_each = var.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  source_ranges = concat(data.google_netblock_ip_ranges.health_checkers.cidr_blocks_ipv4, data.google_netblock_ip_ranges.legacy_health_checkers.cidr_blocks_ipv4)

  // Allow common app ports by default.
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443"]
  }

  target_tags = ["allow-lb"]
}

resource "google_compute_firewall" "allow_all_egress" {
  count     = var.allow_all_egress_ranges != null ? 1 : 0
  name      = "fw-${var.environment_code}-shared-base-1000-e-a-all"
  network   = var.network
  project   = var.project_id[var.envt]
  direction = "EGRESS"
  priority  = 1000

  dynamic "log_config" {
    for_each = var.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  allow {
    protocol = "all"
  }

  destination_ranges = var.allow_all_egress_ranges
}

resource "google_compute_firewall" "allow_all_ingress" {
  count     = var.allow_all_ingress_ranges != null ? 1 : 0
  name      = "fw-${var.environment_code}-shared-base-1000-i-a-all"
  network   = var.network
  project   = var.project_id[var.envt]
  direction = "INGRESS"
  priority  = 1000

  dynamic "log_config" {
    for_each = var.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  allow {
    protocol = "all"
  }

  source_ranges = var.allow_all_ingress_ranges
}
