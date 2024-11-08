# v1.3.4

## Other Changes
* chore(GROW-2952): add codeowners (#35) (Matt Cadorette)([22c20c7](https://github.com/lacework/terraform-aws-s3-data-export/commit/22c20c76ec3c26e3d1c53b48a398d32e142a9b5c))
* ci: migrate from codefresh to github actions (#34) (Timothy MacDonald)([5cd6ab7](https://github.com/lacework/terraform-aws-s3-data-export/commit/5cd6ab765103bb38c8dc5309f031f0198846c12d))
* ci: version bump to v1.3.4-dev (Lacework)([4c0ac57](https://github.com/lacework/terraform-aws-s3-data-export/commit/4c0ac573d639ab4b60781215821759adcdc24336))
---
# v1.3.3

## Other Changes
* chore: set local var module name (#32) (Darren)([1231135](https://github.com/lacework/terraform-aws-s3-data-export/commit/12311359ed8c2605a3b657c8a64731a70ea72e8a))
* ci: version bump to v1.3.3-dev (Lacework)([3801d29](https://github.com/lacework/terraform-aws-s3-data-export/commit/3801d29cccf7947d35c6e32990c99e19aaed8370))
---
# v1.3.2

## Other Changes
* chore: add lacework_metric_module datasource (#30) (Darren)([de7ed09](https://github.com/lacework/terraform-aws-s3-data-export/commit/de7ed096510faae7154903785648a7eaf4a8e1a2))
* ci: version bump to v1.3.2-dev (Lacework)([be8b9a2](https://github.com/lacework/terraform-aws-s3-data-export/commit/be8b9a2c360b770f8d44ef0622f421c75155117d))
---
# v1.3.1

## Refactor
* refactor(role): update to use Lacework external IAM role (#28) (Timothy MacDonald)([50941a6](https://github.com/lacework/terraform-aws-s3-data-export/commit/50941a618b8513441a9b243aa183de2e4b5e3a85))
## Documentation Updates
* docs(readme): add terraform docs automation (#27) (Timothy MacDonald)([928db1e](https://github.com/lacework/terraform-aws-s3-data-export/commit/928db1ebfe101211c6dfee9b4053a94c1d1fb73e))
## Other Changes
* ci: version bump to v1.3.1-dev (Lacework)([fb52a9b](https://github.com/lacework/terraform-aws-s3-data-export/commit/fb52a9be5081144b1b5b08d09eba3f4778d077e0))
---
# v1.3.0

## Features
* feat: enforce External ID v2 format via iam-role module (#25) (djmctavish)([4b604ae](https://github.com/lacework/terraform-aws-s3-data-export/commit/4b604ae195b281638f90868099fd43b4d2ff632e))
## Other Changes
* ci: version bump to v1.2.2-dev (Lacework)([a8bce95](https://github.com/lacework/terraform-aws-s3-data-export/commit/a8bce95307cb23bbe63b8f89e8935c1488dca0cc))
---
# v1.2.1

## Other Changes
* chore: enable bucket_force_destroy by default (#23) (Salim Afiune)([e6cded3](https://github.com/lacework/terraform-aws-s3-data-export/commit/e6cded3a3e2bb46e9d317b1c8c5c6d6ae4c41ab2))
* ci: version bump to v1.2.1-dev (Lacework)([77877b8](https://github.com/lacework/terraform-aws-s3-data-export/commit/77877b8ce31e0074404b06e05c7cf7cdfff184cc))
---
# v1.2.0

## Features
* feat: Add support for AWS provider 5.0 (Darren)([e444cae](https://github.com/lacework/terraform-aws-s3-data-export/commit/e444caecfb1283b574cf5a8cdb80d02696b53cc2))
## Other Changes
* ci: version bump to v1.1.4-dev (Lacework)([4fb2517](https://github.com/lacework/terraform-aws-s3-data-export/commit/4fb2517f9d839a1312063fefbd0d1b06ab8080fa))
---
# v1.1.3

## Bug Fixes
* fix: kms:GenerateDataKey permission (bdandoy)([c8a6ab8](https://github.com/lacework/terraform-aws-s3-data-export/commit/c8a6ab855e2a12ee6457b4f8acad2b15c26ee50d))
---
# v1.1.2

## Bug Fixes
* fix: s3 bucket ownership controls (jon-stewart)([92a4d14](https://github.com/lacework/terraform-aws-s3-data-export/commit/92a4d14b9781c33e84726fc1c6df96e07ce43769))
## Other Changes
* ci: version bump to v1.1.2-dev (Lacework)([3363a0a](https://github.com/lacework/terraform-aws-s3-data-export/commit/3363a0ad192d4d0e62f4287f92bd3f77ae5899a3))
---
# v1.1.1

## Bug Fixes
* fix: tfsec violations (jon-stewart)([c8ec3a9](https://github.com/lacework/terraform-aws-s3-data-export/commit/c8ec3a93bca4cbb6bf65d5fa6a6c6606fa8284a1))
## Other Changes
* ci: version bump to v1.1.1-dev (Lacework)([f80d0a7](https://github.com/lacework/terraform-aws-s3-data-export/commit/f80d0a76fc0f0a45dc9345a219b666ac0b753714))
---
# v1.1.0

## Features
* feat: use lacework_data_export_rule resource (Darren Murray)([1ef8295](https://github.com/lacework/terraform-aws-s3-data-export/commit/1ef829591062ae44fc23bc28630d590733151da7))
* feat: deprecate support for Terraform 0.12 and 0.13 (Darren Murray)([3fba467](https://github.com/lacework/terraform-aws-s3-data-export/commit/3fba4678a488b2d2df99bd9c396a1e0321eee2c7))
## Documentation Updates
* docs: add example (Darren Murray)([c76aed6](https://github.com/lacework/terraform-aws-s3-data-export/commit/c76aed60f9282f6d8a5622649a8a48bcef8dd327))
* docs: update Lacework provider version in readme (Sourcegraph)([320cac2](https://github.com/lacework/terraform-aws-s3-data-export/commit/320cac266ee32d4924377b9fca52ed4728612842))
## Other Changes
* chore: update Lacework provider version to v1 (Sourcegraph)([67d4f47](https://github.com/lacework/terraform-aws-s3-data-export/commit/67d4f47479f0b9b29bea0724de1dd11b46d08057))
* ci: version bump to v1.0.1-dev (Lacework)([e1dc4ee](https://github.com/lacework/terraform-aws-s3-data-export/commit/e1dc4eec859bd807ecb5039f01023df954d099e1))
---
# v1.0.0

## Features
* feat: update required version to v4 for aws provider (Darren Murray)([a66b76c](https://github.com/lacework/terraform-aws-s3-data-export/commit/a66b76c31177c1236a60d19c7d262f43bba89847))
## Refactor
* refactor: major version bump to 1.0.0 (Salim Afiune Maya)([c9d722d](https://github.com/lacework/terraform-aws-s3-data-export/commit/c9d722dd9bd3a79c781bac781c8961fe15d815f8))
## Documentation Updates
* docs: Add contributing documentation (#5) (Darren)([e98ec59](https://github.com/lacework/terraform-aws-s3-data-export/commit/e98ec59d0015a940d4d414235858eff2a5e56db5))
* docs: update module name in default example (#4) (Salim Afiune)([9bab518](https://github.com/lacework/terraform-aws-s3-data-export/commit/9bab5187d2e2e7d5c1b9194273d2c00b50e02492))
## Other Changes
* chore: update PR template (#6) (Darren)([9eafdb6](https://github.com/lacework/terraform-aws-s3-data-export/commit/9eafdb695ffae046e273e8b06038fa5ce52b9a71))
* chore: version bump to v0.2.1-dev (Lacework)([5a4c4b8](https://github.com/lacework/terraform-aws-s3-data-export/commit/5a4c4b81b8028a0245c842006bd8cbf34bf2b6f8))
* ci: sign lacework-releng commits (#3) (Salim Afiune)([5b399d7](https://github.com/lacework/terraform-aws-s3-data-export/commit/5b399d7725818d3cc99df4d2dc6781b7be83317c))
---
# v0.2.0

## Features
* feat: initial implementation of S3 Data Export module (Alan Nix)([68ae1f8](https://github.com/lacework/terraform-aws-s3-data-export/commit/68ae1f87f5bcc591d2f3a0a89c6645d28b563758))
## Other Changes
* chore: bump required version of TF to 0.12.31 (#3) (Scott Ford)([bf6cdf6](https://github.com/lacework/terraform-aws-s3-data-export/commit/bf6cdf68a271cc49560dd66bb60fd590b0b1328c))
* ci: fix finding major versions during release (#2) (Salim Afiune)([72197f2](https://github.com/lacework/terraform-aws-s3-data-export/commit/72197f2f20bf5d67710a2bc2d38d4844427e6d77))
---
