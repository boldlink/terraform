variable "name" {
    description = "(Required) Name to use for Char"
    type = string
}
  
variable "add_namespace" {
    description = "(Optional) Enable the namespace resource creation"
    type = bool
    default = false
}

variable "namespace" {
    description = "(Required) The name of the namespace to create or use on the hem chart"
    type = string
}

variable "annotations" {
    description = "(Optional) Namespace annotations"
    type = map
    default = {}
}

variable "labels" {
    description = "(Optional) Namespace labels"
    type = map
    default = {}
}
  
variable "chart" {
    description = "(Required) Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if repository is specified"
    type = string
}
  
variable "repository" {
    description = "(Optional) Repository URL where to locate the requested chart."
    type = string
    default = ""
}
  
variable "repository_key_file" {
    description = " (Optional) The repositories cert key file"
    type = string
    default = ""
}
  
variable "repository_cert_file" {
    description = " (Optional) The repositories cert file"
    type = string
    default = ""
}
  
variable "repository_ca_file" {
    description = "(Optional) The Repositories CA File."
    type = string
    default = ""
}
  
variable "repository_username" {
    description = "(Optional) Username for HTTP basic authentication against the repository."
    type = string
    default = ""
}
  
variable "repository_password" {
    description = "(Optional) Password for HTTP basic authentication against the repository."
    type = string
    default = ""
}
  
variable "dev" {
    description = "(Optional) Use chart development versions, too. Equivalent to version '>0.0.0-0'. If version is set, this is ignored."
    type = string
    default = ""
}
  
variable "version" {
    description = "(Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed."
    type = string 
    default = ""
}
  
variable "verify" {
    description = " (Optional) Verify the package before installing it. Helm uses a provenance file to verify the integrity of the chart; this must be hosted alongside the chart."
    type = bool
    default = false
}
  
variable "keyring" {
    description = "(Optional) Location of public keys used for verification. Used only if verify is true."
    type = string
    default = ""
}
  
variable "timeout" {
    description = " (Optional) Time in seconds to wait for any individual kubernetes operation (like Jobs for hooks)."
    type = number
    default = 300
}
  
variable "disable_webhooks" {
    description = "(Optional) Prevent hooks from running."
    type = bool
    default = false
}
  
variable "reuse_values" {
    description = "(Optional) When upgrading, reset the values to the ones built into the chart."
    type = bool
    default = false
}
  
variable "reset_values" {
    description = "(Optional) When upgrading, reset the values to the ones built into the chart."
    type = bool
    default = false
}
  
variable "force_update" {
    description = "(Optional) Force resource update through delete/recreate if needed."
    type = bool
    default = false
}
  
variable "recreate_pods" {
    description = "(Optional) Perform pods restart during upgrade/rollback."
    type = bool
    default = false
}
  
variable "cleanup_on_fail" {
    description = "(Optional) Allow deletion of new resources created in this upgrade when upgrade fails."
    type = bool
    default = false
}
  
variable "max_history" {
    description = "(Optional) Maximum number of release versions stored per release."
    type = number
    default = 0
}
  
variable "atomic" {
    description = "(Optional) If set, installation process purges chart on fail. The wait flag will be set automatically if atomic is used."
    type = bool
    default = false
}
  
variable "skip_crds" {
    description = "(Optional) If set, no CRDs will be installed. By default, CRDs are installed if not already present."
    type = bool
    default = false
}
  
variable "render_subchart_notes" {
    description = "(Optional) If set, render subchart notes along with the parent."
    type = bool
    default = true
}
  
variable "disable_openapi_validation" {
    description = "(Optional) If set, the installation process will not validate rendered templates against the Kubernetes OpenAPI Schema."
    type = bool
    default = false
}
  
variable "wait" {
    description = "(Optional) Will wait until all resources are in a ready state before marking the release as successful. It will wait for as long as timeout."
    type = bool
    default = true
}
  
variable "wait_for_jobs" {
    description = "(Optional) If wait is enabled, will wait until all Jobs have been completed before marking the release as successful. It will wait for as long as timeout."
    type = bool
    default = false
}
  
variable "values" {
    description = " (Optional) List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
    type = list(string)
    default = []
}
  
variable "dependency_update" {
    description = "(Optional) Runs helm dependency update before installing the chart."
    type = bool
    default = false
}
  
variable "replace" {
    description = "(Optional) Re-use the given name, even if that name is already used. This is unsafe in production."
    type = bool
    default = false
}
  
variable "description" {
    description = "(Optional) Set release description attribute (visible in the history)."
    type = string
    default = ""
}
  
variable "postrender" {
    description = "(Required) relative or full path to command binary."
    type = string
    default = ""
}

variable "lint" {
    description = "(Optional) Run the helm chart linter during the plan. Defaults to false."
    type = bool
    default = false
}

variable "" {
    description = ""
    type = 
    default = 
}

variable "" {
    description = ""
    type = 
    default = 
}

variable "" {
    description = ""
    type = 
    default = 
}

variable "" {
    description = ""
    type = 
    default = 
}

variable "" {
    description = ""
    type = 
    default = 
}

variable "" {
    description = ""
    type = 
    default = 
}



