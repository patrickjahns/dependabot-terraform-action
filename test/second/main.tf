module "public" {
  source = "git@github.com:patrickjahns/terraform-module-public.git?ref=0.1.0"
}

module "private" {
  source = "git@github.com:patrickjahns/terraform-module-private.git?ref=0.0.0"
}

module "registry_module" {
  source  = "vancluever/module/null"
  version = "1.0.0"
}
