

## [7.2.4](https://github.com/guidebooks/store/compare/7.2.3...7.2.4) (2023-03-30)


### Bug Fixes

* improve stability oƒ ray port forward ([8c9b8b6](https://github.com/guidebooks/store/commit/8c9b8b6a09d75200404c37b4601fa2f8725e339f))
* improve support for running locally on arm ([b42d718](https://github.com/guidebooks/store/commit/b42d718cce04dec0d77afdbcdec6a04d86bedeef))

## [7.2.3](https://github.com/guidebooks/store/compare/7.2.2...7.2.3) (2023-03-29)


### Bug Fixes

* ml/ray/start/kubernetes/events uses incorrect awk comment character ([b2352c4](https://github.com/guidebooks/store/commit/b2352c437fc28e23cb8b522f253307d611b995cf))

## [7.2.2](https://github.com/guidebooks/store/compare/7.2.1...7.2.2) (2023-03-29)


### Bug Fixes

* add workaround for torchx dryrun regression ([24d04dd](https://github.com/guidebooks/store/commit/24d04dde32f9b3951c3437f6df5727501f061c77))
* improvements in error handling in ml/torchx/run/stop ([2bfe483](https://github.com/guidebooks/store/commit/2bfe483b89e89e0b7a9181d37862162fa1090143))

## [7.2.1](https://github.com/guidebooks/store/compare/7.2.0...7.2.1) (2023-03-29)


### Bug Fixes

* ray port-forward may spin loop ([1eada2e](https://github.com/guidebooks/store/commit/1eada2e87fd4568641f8e158229100aaaf0e95d3))
* set TERM in head ([ccc6bf6](https://github.com/guidebooks/store/commit/ccc6bf6ec539dc6ebaed34214791be1ae0b6b6d6))

# [7.2.0](https://github.com/guidebooks/store/compare/7.1.2...7.2.0) (2023-03-28)


### Bug Fixes

* assign gpus to ray head, if we are assigning them to workers ([9fa3307](https://github.com/guidebooks/store/commit/9fa330744abd138c1c626b867dee31fcd8695f67))
* bump openshift/oc to 4.12.9 ([55d0ff1](https://github.com/guidebooks/store/commit/55d0ff14f18d6ba293c4ca0e5a3f876031ab86e7))
* kubernetes/choose/ns validator syntax fix ([3373061](https://github.com/guidebooks/store/commit/33730615a511a7b547e7413a08e2a657f5b1eeff))
* log setup ends up waiting for job to be running ([d6eaa49](https://github.com/guidebooks/store/commit/d6eaa49ebc2304f53ed314ab9773f892f8094403))
* major cleanups to job log streaming ([83771c6](https://github.com/guidebooks/store/commit/83771c61dc013dfc36a2ce789e43d111959c2ee5))
* ml/raay/start/kubernetes/wait-for-head/workers cpu spin ([0f85741](https://github.com/guidebooks/store/commit/0f85741fceeba0a93f3ad5e8510fe68fa05ce862))
* ml/ray/stop/kubernetes may wait unnecessarily ([289a749](https://github.com/guidebooks/store/commit/289a7495d3d9cce23631af302e894242ccbdd403))
* squash irrelevant errors in vmstat, etc. tracking ([9c92291](https://github.com/guidebooks/store/commit/9c9229158ed8a8b959c51840251a425ac1521df7))
* try to be more helpful on windows for kubectl and oc installation ([cb6b9ac](https://github.com/guidebooks/store/commit/cb6b9aca9f60e17dbc320d44c253ce777fa31362))

## [7.1.2](https://github.com/guidebooks/store/compare/7.1.1...7.1.2) (2023-03-21)


### Bug Fixes

* improve handling of no aws profiles/no buckets situations ([30be07b](https://github.com/guidebooks/store/commit/30be07bf6fe3a86295cfd5b7ed0ebde76a91f08e))
* ml/codeflare/training/demos/getting-started/submit should offer submit-only ([e2da046](https://github.com/guidebooks/store/commit/e2da046492f908aef516daa2257a20bf01b63d80))

## [7.1.1](https://github.com/guidebooks/store/compare/7.1.0...7.1.1) (2023-03-21)


### Bug Fixes

* if .aws/config does not define endpoint_url, bucket expansion fails ([05140f0](https://github.com/guidebooks/store/commit/05140f017c01f839b762dbe828561b9d4f67b37e))

# [7.1.0](https://github.com/guidebooks/store/compare/7.0.1...7.1.0) (2023-03-20)


### Features

* remove old roberta, bert, and glue logic ([180a1ea](https://github.com/guidebooks/store/commit/180a1ea43ee43763e395a0da1992d7c871c5713d))

## [7.0.1](https://github.com/guidebooks/store/compare/7.0.0...7.0.1) (2023-03-20)


### Bug Fixes

* ml/torchx/run always calls set -x even when not dry-running ([a0491cc](https://github.com/guidebooks/store/commit/a0491cccfdf3f82a05d021fc997584a5c069b778))

# [7.0.0](https://github.com/guidebooks/store/compare/6.2.1...7.0.0) (2023-03-19)


### Features

* support for selecting multiple s3 buckets ([9ec8528](https://github.com/guidebooks/store/commit/9ec85284758dadfcf250bf962407c1f607cf5a02))


### BREAKING CHANGES

* this updates s3/choose/bucket from single-select to multi-select, which may require re-selecting this choice

## [6.2.1](https://github.com/guidebooks/store/compare/6.2.0...6.2.1) (2023-03-18)


### Bug Fixes

* ml/torchx/run fails with fractional mem e.g. 1.5Gi ([2f03999](https://github.com/guidebooks/store/commit/2f039991cb23d5ac1e811e1ef9db55473c55a060))

# [6.2.0](https://github.com/guidebooks/store/compare/6.1.10...6.2.0) (2023-03-18)


### Features

* consolidate ml/torchx resources and ml/ray resources ([081d19e](https://github.com/guidebooks/store/commit/081d19eda724e2fdde4c85d95c27e0b04dcdbf82))

## [6.1.10](https://github.com/guidebooks/store/compare/6.1.9...6.1.10) (2023-03-17)


### Bug Fixes

* gpu utilization does not stream out when late-attaching ([be0559f](https://github.com/guidebooks/store/commit/be0559f2842dc88b6d98abf42d5c06a0896b1957))

## [6.1.9](https://github.com/guidebooks/store/compare/6.1.8...6.1.9) (2023-03-16)


### Bug Fixes

* ml/torchx/run/stop fails to delete helm ([1b68b35](https://github.com/guidebooks/store/commit/1b68b35809b91fdf1c510e6e3085cdc1e08ca87b))

## [6.1.8](https://github.com/guidebooks/store/compare/6.1.7...6.1.8) (2023-03-16)


### Bug Fixes

* ml/torchx/stop incorrectly attempted in dryrun ([26f55e6](https://github.com/guidebooks/store/commit/26f55e63403cb135e85ebe73f5e89c243e1b22cd))
* pass through job priority to torchx run ([5455f9c](https://github.com/guidebooks/store/commit/5455f9c6eb7511dc935d6ce0a6301e3989e3ec57))
* remove incorrect "Ray" in kubernetes/choose/ns title ([16c39c9](https://github.com/guidebooks/store/commit/16c39c90185eecb5e7359c722b264c359565b9a3))

## [6.1.7](https://github.com/guidebooks/store/compare/6.1.6...6.1.7) (2023-03-16)


### Bug Fixes

* simplify ray by avoiding ray workflows question for now ([ba44bea](https://github.com/guidebooks/store/commit/ba44bea170e30927fba607528890951a107644b8))

## [6.1.6](https://github.com/guidebooks/store/compare/6.1.5...6.1.6) (2023-03-16)


### Bug Fixes

* after switch from bzip2 to gzip, we need to rename workdir.tar.bz2 ([19d6ae0](https://github.com/guidebooks/store/commit/19d6ae094003d31764345220d7615dd2dfc7be53))

## [6.1.5](https://github.com/guidebooks/store/compare/6.1.4...6.1.5) (2023-03-16)


### Bug Fixes

* avoid use of bunzip2, in favor of gzip ([cf25a2b](https://github.com/guidebooks/store/commit/cf25a2ba62de1c8e82a8447a27d6f1ef0a2a0f68))

## [6.1.4](https://github.com/guidebooks/store/compare/6.1.3...6.1.4) (2023-03-14)


### Bug Fixes

* avoid use of -Winteractive on macos ([6a89cad](https://github.com/guidebooks/store/commit/6a89cad80665c0cafc314dbd7212914f64366209))
* gpu utilization may not be streamed out ([9925290](https://github.com/guidebooks/store/commit/9925290882ece9bbd7870d8e07046bcbfeb3d048))
* when looping kubectl events, use watch-only after first iter ([25a6511](https://github.com/guidebooks/store/commit/25a6511024e253bb3b955e2466fb4a9b508cb3ab))

## [6.1.3](https://github.com/guidebooks/store/compare/6.1.2...6.1.3) (2023-03-14)


### Bug Fixes

* ray self-destruct should establish security context ([d6ed018](https://github.com/guidebooks/store/commit/d6ed01833b3c8ada8bb1be27abf6d36c3a74ae0a))

## [6.1.2](https://github.com/guidebooks/store/compare/6.1.1...6.1.2) (2023-03-14)


### Bug Fixes

* helm workdir fails for relative paths ([1350e49](https://github.com/guidebooks/store/commit/1350e49674d38cc50e75522978e6bda643e768c6))
* we were looking for ERROR instead of FAILED for failed ray jobs ([8a4d332](https://github.com/guidebooks/store/commit/8a4d33268e15ec6cdd4c7cf1e6e3463facde9e3c))

## [6.1.1](https://github.com/guidebooks/store/compare/6.1.0...6.1.1) (2023-03-14)


### Bug Fixes

* if ray process errors out, ray stop is never called ([70cb403](https://github.com/guidebooks/store/commit/70cb403dec49b0d018a3752539ffe5e69b6ec7d6))
* ray self-destruct may fail due to permissions ([e0f41ab](https://github.com/guidebooks/store/commit/e0f41ab9914828908c1b6a69987c2df5ef523e5c))
* user may be prompted for run id, when it is already known ([6a290e4](https://github.com/guidebooks/store/commit/6a290e49e2225245b76f7134e3d977ebd0a05386))

# [6.1.0](https://github.com/guidebooks/store/compare/6.0.11...6.1.0) (2023-03-14)


### Bug Fixes

* also give ray head a gpu ([3a9536b](https://github.com/guidebooks/store/commit/3a9536b84a74e76f8bbdb4431742b8f2b3e5e3f3))


### Features

* aws/init to guide the creation of an aws profile ([9ab2c47](https://github.com/guidebooks/store/commit/9ab2c47dc4597b9e949d0b3a406a375a8c669603))

## [6.0.11](https://github.com/guidebooks/store/compare/6.0.10...6.0.11) (2023-03-13)


### Bug Fixes

* another fix for absent runtime-env ([7797638](https://github.com/guidebooks/store/commit/7797638e0e80eef55572de0743f3b1a63d816714))

## [6.0.10](https://github.com/guidebooks/store/compare/6.0.9...6.0.10) (2023-03-13)


### Bug Fixes

* update to new torchx use of `torchrun` ([cdf9e01](https://github.com/guidebooks/store/commit/cdf9e01661a49763f945e51d5743d7bc894b9265))

## [6.0.9](https://github.com/guidebooks/store/compare/6.0.8...6.0.9) (2023-03-13)


### Bug Fixes

* specify parallelism for ray worker Job ([6a8e89d](https://github.com/guidebooks/store/commit/6a8e89df3b6945c9f79536897a62724774ded9c0))

## [6.0.8](https://github.com/guidebooks/store/compare/6.0.7...6.0.8) (2023-03-13)


### Bug Fixes

* improve support for milli cpus in ml/torchx/run ([3469edc](https://github.com/guidebooks/store/commit/3469edc6b23382077ba87af10c3cdcf8f38eb45e))

## [6.0.7](https://github.com/guidebooks/store/compare/6.0.6...6.0.7) (2023-03-13)


### Bug Fixes

* kube event streamer should retry on 404 ([b76dbb7](https://github.com/guidebooks/store/commit/b76dbb7a07273b6076d07caa6d1350c78111b173))

## [6.0.6](https://github.com/guidebooks/store/compare/6.0.5...6.0.6) (2023-03-13)


### Bug Fixes

* add kube event stream to ml/torchx/run ([b78a035](https://github.com/guidebooks/store/commit/b78a03509216ff55a3775d35f2ef752c8a842267))

## [6.0.5](https://github.com/guidebooks/store/compare/6.0.4...6.0.5) (2023-03-13)


### Bug Fixes

* add dashdash support to ml/torchx/run ([ebf0a7e](https://github.com/guidebooks/store/commit/ebf0a7eab39d570ada91e58b2c8271d29b2464f8))
* remove extra space in helm install output ([f9133c2](https://github.com/guidebooks/store/commit/f9133c2b415cc8f458cc2acacf1d90abe1cb1c4e))
* remove set -x ([cb677f1](https://github.com/guidebooks/store/commit/cb677f14d4c56f41d7be1ec6fff77bc1eaf0f969))

## [6.0.4](https://github.com/guidebooks/store/compare/6.0.3...6.0.4) (2023-03-12)


### Bug Fixes

* don't pass through volumes and image pull secret if not provided ([9bf76d6](https://github.com/guidebooks/store/commit/9bf76d69377d803247b2b5b9ba271b6b53b60e44))

## [6.0.3](https://github.com/guidebooks/store/compare/6.0.2...6.0.3) (2023-03-12)


### Bug Fixes

* missing -E for torchx memMB; also add case-insensitivity ([9fddc45](https://github.com/guidebooks/store/commit/9fddc459c71379d68c44572505beb5de7baa1834))

## [6.0.2](https://github.com/guidebooks/store/compare/6.0.1...6.0.2) (2023-03-12)


### Bug Fixes

* allow ml/torchx/run to choose pod scheduler ([f3394d4](https://github.com/guidebooks/store/commit/f3394d4f05a3f8141fbc28c75723c988df29a847))
* ml/torchx/run misinterprets Mi memory units ([00b2c77](https://github.com/guidebooks/store/commit/00b2c77070efdf4dcf1575ef9c3901ce09a3e95c))
* remove unnecessary mention of 'ray' in helm install output ([a6925c9](https://github.com/guidebooks/store/commit/a6925c9f149bfef6de08438980ce3c3858da52a9))

## [6.0.1](https://github.com/guidebooks/store/compare/6.0.0...6.0.1) (2023-03-12)


### Bug Fixes

* use 0.5.0dev0 has the name for the torchx venv ([b1b760b](https://github.com/guidebooks/store/commit/b1b760b93bae1cc7ad7f4603f757c2b34c3a5b97))

# [6.0.0](https://github.com/guidebooks/store/compare/5.7.0...6.0.0) (2023-03-12)


### Features

* add torchx/run to ml/codeflare/run ([92470f7](https://github.com/guidebooks/store/commit/92470f79cde4cd4ab2beb44987958b66be45c85c))


### BREAKING CHANGES

* this changes the menu structure for ml/codeflare/run, which may require test updates.
* this also removes the old "codeflare model architecture" option from ml/codeflare/run

# [5.7.0](https://github.com/guidebooks/store/compare/5.6.2...5.7.0) (2023-03-11)


### Bug Fixes

* add worker index to log output ([6d8b12a](https://github.com/guidebooks/store/commit/6d8b12a383df7bf5c6a9652b2722aac5d5692f8c))
* ml/torchx/run fails with nWorkers>1 ([377d183](https://github.com/guidebooks/store/commit/377d183f0cf19392f9da98dedffd08baad073da6))
* shorten prefix of log lines ([250f486](https://github.com/guidebooks/store/commit/250f486af211d1bcf150cadd5f1e567a12b0d019))
* small wordsmithing to title of ml/torchx/run/stop ([ef16c61](https://github.com/guidebooks/store/commit/ef16c610a4b7562d86f9762fcb06ddd387f5954b))


### Features

* add cpu/gpu/mem utilization to ml/torchx/run/logs ([8a23455](https://github.com/guidebooks/store/commit/8a2345550b9e6bd7e29b2236f809851c06403a2a))
* ml/torchx/run ([9ed5a10](https://github.com/guidebooks/store/commit/9ed5a100027a391ed3131c1873ac61de45fbe3c2))
* restore torchx cli install ([53d6ba5](https://github.com/guidebooks/store/commit/53d6ba5f1ecb7cb64951467bc75be0fdac59e2f9))

## [5.6.2](https://github.com/guidebooks/store/compare/5.6.1...5.6.2) (2023-03-09)


### Bug Fixes

* ray would fail if workdir had no runtime-env.yaml nor requirements.txt ([a985e0e](https://github.com/guidebooks/store/commit/a985e0ef7b59c8f7f7d01f436116cc4a51d84a26))

## [5.6.1](https://github.com/guidebooks/store/compare/5.6.0...5.6.1) (2023-03-07)


### Bug Fixes

* ugh, restore awk -Winteractive ([3057937](https://github.com/guidebooks/store/commit/3057937412cb212a446bacdf1b32d46b7f31fd5b))

# [5.6.0](https://github.com/guidebooks/store/compare/5.5.6...5.6.0) (2023-03-07)


### Features

* move cpu and memory utilization to be first column ([ca00dc4](https://github.com/guidebooks/store/commit/ca00dc4cc25ea79940435eb253c89ded03448f63))

## [5.5.6](https://github.com/guidebooks/store/compare/5.5.5...5.5.6) (2023-03-07)


### Bug Fixes

* vmstats were using `sed -l` in a way that only made sense on BSD sed ([c30da29](https://github.com/guidebooks/store/commit/c30da2950d7b6bd181d44de98ee1e3ff436e7ade))

## [5.5.5](https://github.com/guidebooks/store/compare/5.5.4...5.5.5) (2023-03-07)


### Bug Fixes

* helm install was not passing through desired command line prefix ([75026f1](https://github.com/guidebooks/store/commit/75026f14aff475f34e34fa16b651692bdae96c60))

## [5.5.4](https://github.com/guidebooks/store/compare/5.5.3...5.5.4) (2023-03-06)


### Bug Fixes

* avoid use of env vars for workdir tarball ([6dd6c4b](https://github.com/guidebooks/store/commit/6dd6c4b863642814067e6cfe63101aa455358484))

## [5.5.3](https://github.com/guidebooks/store/compare/5.5.2...5.5.3) (2023-03-06)


### Bug Fixes

* correct base64 decoding from prior commit ([035d604](https://github.com/guidebooks/store/commit/035d6046060fd759e5f782aa924fab2082e14991))
* eliminate newlines from base64-encoded strings ([56bf44e](https://github.com/guidebooks/store/commit/56bf44e5f74f0412b876902cdd39d4cd4f4da2e5))

## [5.5.2](https://github.com/guidebooks/store/compare/5.5.1...5.5.2) (2023-03-06)


### Bug Fixes

* helm install command line may be too long ([3a03b7a](https://github.com/guidebooks/store/commit/3a03b7a2dd34686103ba4ed021a044d8dfe65e46))

## [5.5.1](https://github.com/guidebooks/store/compare/5.5.0...5.5.1) (2023-03-06)


### Bug Fixes

* further improvements to streaming output of vmstat on linux ([2a975ec](https://github.com/guidebooks/store/commit/2a975ecc59dbe44fec89a3c1b38ddd9c7855bdc5))
* improve visibility of RAY_ADDRESS port forward announcement ([ec045a4](https://github.com/guidebooks/store/commit/ec045a4813bfd4d8dc2619343179cec17fac0798))

# [5.5.0](https://github.com/guidebooks/store/compare/5.4.10...5.5.0) (2023-03-05)


### Features

* allow BYOC to specify command line prefix ([99d67d7](https://github.com/guidebooks/store/commit/99d67d761ef306dfd1bf14672408745dd935fb31))

## [5.4.10](https://github.com/guidebooks/store/compare/5.4.9...5.4.10) (2023-03-05)


### Bug Fixes

* avoid use of grep in pod-vmstat and kube events to improve streaming on linux ([9660ec1](https://github.com/guidebooks/store/commit/9660ec11717ca53f22629ea61651a63759bb9457))

## [5.4.9](https://github.com/guidebooks/store/compare/5.4.8...5.4.9) (2023-03-04)


### Bug Fixes

* kube events lines are way too wide ([8ce7175](https://github.com/guidebooks/store/commit/8ce71758353deaaa32700afef1fc37defeec4c1e))

## [5.4.8](https://github.com/guidebooks/store/compare/5.4.7...5.4.8) (2023-03-03)


### Bug Fixes

* sed invalid reference errors ([e6ae764](https://github.com/guidebooks/store/commit/e6ae764941b57ace346934685b654755df6f8978))
* simplify ray logs to focus on websocat ([e81009c](https://github.com/guidebooks/store/commit/e81009ccf32820cd74412e1996744df7f0749749))

## [5.4.7](https://github.com/guidebooks/store/compare/5.4.6...5.4.7) (2023-03-03)


### Bug Fixes

* allow workdirs to specify exclusion rules via .rayignore ([f2a7fc3](https://github.com/guidebooks/store/commit/f2a7fc3f5087a4717423f91fc30550062af3d9bf))
* decrease the frequency of nvidia-smi from 2s to 10s ([19bf7df](https://github.com/guidebooks/store/commit/19bf7df2939c665c3ace71fb9cf5077d1a8c7689))
* improve messaging after ray job submit ([58a6f76](https://github.com/guidebooks/store/commit/58a6f762ecd288fcef586e702e1f385d0c5670c3))
* ml/ray/run/*vmstat* may try to exec into Successful pod ([37e7b8e](https://github.com/guidebooks/store/commit/37e7b8ea3cc874a34de22fb7e12746c2813a50f5))

## [5.4.6](https://github.com/guidebooks/store/compare/5.4.5...5.4.6) (2023-03-03)


### Bug Fixes

* linux base64 creates newlines ([946fb9e](https://github.com/guidebooks/store/commit/946fb9e183c8923477d532929ebb7d77ab4a8cb5))

## [5.4.5](https://github.com/guidebooks/store/compare/5.4.4...5.4.5) (2023-03-03)


### Bug Fixes

* use set-file for job env in helm install ([550778e](https://github.com/guidebooks/store/commit/550778e74f75fba2cdf33173e82e750b440b299c))
* use set-file for the base64-encoded workdir ([18d5b48](https://github.com/guidebooks/store/commit/18d5b484d474eb7436fc15b521fd6a2d8b45dec1))

## [5.4.4](https://github.com/guidebooks/store/compare/5.4.3...5.4.4) (2023-03-03)


### Bug Fixes

* remove unused HELM_DEBUG in helm install script ([185a892](https://github.com/guidebooks/store/commit/185a892d160b30abc301ff6b0cb3746f196148f7))

## [5.4.3](https://github.com/guidebooks/store/compare/5.4.2...5.4.3) (2023-03-03)


### Bug Fixes

* hmm, some of the tputs cause problems in github actions ([615946a](https://github.com/guidebooks/store/commit/615946ad80ac70690ee9498c3233b58eea281c95))

## [5.4.2](https://github.com/guidebooks/store/compare/5.4.1...5.4.2) (2023-03-03)


### Bug Fixes

* improved error handling in helm install for lack of cluster name ([94e2720](https://github.com/guidebooks/store/commit/94e27203ea34de0c3965f636333dde222c67da5d))

## [5.4.1](https://github.com/guidebooks/store/compare/5.4.0...5.4.1) (2023-03-03)


### Bug Fixes

* improved error handling when custom workdir not found ([e850fce](https://github.com/guidebooks/store/commit/e850fce2543bb807a74dd2ac6c231e43594f2df3))

# [5.4.0](https://github.com/guidebooks/store/compare/5.3.4...5.4.0) (2023-03-03)


### Features

* submit ray job in helm chart ([c20de16](https://github.com/guidebooks/store/commit/c20de165280842caccece1905d4ed8f934164ac7))

## [5.3.4](https://github.com/guidebooks/store/compare/5.3.3...5.3.4) (2023-03-02)


### Bug Fixes

* add a byoc/submitonly task ([d49bcd1](https://github.com/guidebooks/store/commit/d49bcd16d48b5bd6ff3923383ca41a8eca25bbf8))

## [5.3.3](https://github.com/guidebooks/store/compare/5.3.2...5.3.3) (2023-03-01)


### Bug Fixes

* improved error handling in log streaming for pods disappearing ([5595911](https://github.com/guidebooks/store/commit/5595911fa3e37b4c3e959847a5dc943a4a7e20cf))

## [5.3.2](https://github.com/guidebooks/store/compare/5.3.1...5.3.2) (2023-03-01)


### Bug Fixes

* make sure not to set priorityClassName if not using job priorities ([3253b50](https://github.com/guidebooks/store/commit/3253b506d74f5341b50e704b9a5853ea40a2e692))

## [5.3.1](https://github.com/guidebooks/store/compare/5.3.0...5.3.1) (2023-03-01)


### Bug Fixes

* treat default scheduling priority as not enabling prioritization ([f762ae8](https://github.com/guidebooks/store/commit/f762ae84c1f6a265b4cefca14a48f5b29babd49d))

# [5.3.0](https://github.com/guidebooks/store/compare/5.2.3...5.3.0) (2023-03-01)


### Bug Fixes

* gpu-utilization.md may fail on zsh if profile specifies no gpus ([90a7ac9](https://github.com/guidebooks/store/commit/90a7ac9031dd6422264282da165aa5e88c7e6320))


### Features

* allow selection of scheduling priority for MCAD ([7a7eda9](https://github.com/guidebooks/store/commit/7a7eda9be89354db89d0c68fa9672bfe199d55d3))

## [5.2.3](https://github.com/guidebooks/store/compare/5.2.2...5.2.3) (2023-03-01)


### Bug Fixes

* remove use of GUIDEBOOK_DASHDASH ([bd120f8](https://github.com/guidebooks/store/commit/bd120f802ef45e583581a887cf1de5671dd35a7e))

## [5.2.2](https://github.com/guidebooks/store/compare/5.2.1...5.2.2) (2023-03-01)


### Bug Fixes

* increase ray head+worker wait timeout ([46e0b27](https://github.com/guidebooks/store/commit/46e0b279bff50f87d2dc4dea75d8e7fb87f27619))

## [5.2.1](https://github.com/guidebooks/store/compare/5.2.0...5.2.1) (2023-03-01)


### Bug Fixes

* ray helm chart podgroup had a 10 second scheduling timeout ([e916c1a](https://github.com/guidebooks/store/commit/e916c1a5bfde6ad71996e38a5299d87b9ba0eeb8))

# [5.2.0](https://github.com/guidebooks/store/compare/5.1.7...5.2.0) (2023-02-28)


### Features

* allow use of vmstat and gpu utilization tracking outside of ray ([2a4b7a4](https://github.com/guidebooks/store/commit/2a4b7a4a16287ee801bb2d16a4c45f64665d56e8))

## [5.1.7](https://github.com/guidebooks/store/compare/5.1.6...5.1.7) (2023-02-23)


### Bug Fixes

* utilization was flowing to both stderr and stout ([75c2cb2](https://github.com/guidebooks/store/commit/75c2cb2ee7347c359a66d6c008fad3d3c2a71a41))

## [5.1.6](https://github.com/guidebooks/store/compare/5.1.5...5.1.6) (2023-02-23)


### Bug Fixes

* ml/ray/run utilization info should flow to stderr ([bbf2c4d](https://github.com/guidebooks/store/commit/bbf2c4d474377a134168ac3e3d6354acff777b42))

## [5.1.5](https://github.com/guidebooks/store/compare/5.1.4...5.1.5) (2023-02-23)


### Bug Fixes

* ml/ray/run/logs/via-websocat fails on zsh due to assignment to `status` ([72fdec7](https://github.com/guidebooks/store/commit/72fdec71abff07ba95da4702f2a78b299d627579))

## [5.1.4](https://github.com/guidebooks/store/compare/5.1.3...5.1.4) (2023-02-22)


### Bug Fixes

* ray cleaner might stick around, and may consume lots of cpu/mem ([0f88584](https://github.com/guidebooks/store/commit/0f88584ee6c6df59cff1dbfd7f7a3db5bba68f83))

## [5.1.3](https://github.com/guidebooks/store/compare/5.1.2...5.1.3) (2023-02-22)


### Bug Fixes

* ray self-destruct should use image pull secret ([f1ebf89](https://github.com/guidebooks/store/commit/f1ebf89283db06f2235a7cf8725d857ed898c90d))

## [5.1.2](https://github.com/guidebooks/store/compare/5.1.1...5.1.2) (2023-02-22)


### Bug Fixes

* linux websocat installation does not create /usr/local/bin/websocat ([f4b8ed4](https://github.com/guidebooks/store/commit/f4b8ed41fff4b2bd558f4c57c6657c12fa2130b8))

## [5.1.1](https://github.com/guidebooks/store/compare/5.1.0...5.1.1) (2023-02-22)


### Bug Fixes

* improve ml/ray/run/job-definition error handling ([040f228](https://github.com/guidebooks/store/commit/040f228348ef0ffe1e655f6589daf43122f57876))
* ml/ray/run/logs/via-websocat may prematurely exit and should mimic ray job submit success message ([1bb3dbc](https://github.com/guidebooks/store/commit/1bb3dbc31dbd4c6162d28e12327e63da8734ae39))
* ml/ray/run/vmstat fails due to missing line continuations ([ffdfda8](https://github.com/guidebooks/store/commit/ffdfda806d5e100b8feed217fc19f10b7099ca84))
* update ml/ray/run/vmstat to use consistent timestamp format and user's timezone ([4269261](https://github.com/guidebooks/store/commit/42692618507112539bf1f1f6ba77658c91a90190))
* util/websocat may fail on linux due to permissions ([d6b2be2](https://github.com/guidebooks/store/commit/d6b2be26ce89cfae530de894642442e5f799f1b9))

# [5.1.0](https://github.com/guidebooks/store/compare/5.0.0...5.1.0) (2023-02-22)


### Features

* update ml/codeflare/training/byoc to use improved logs ([02d1f29](https://github.com/guidebooks/store/commit/02d1f29dacd6f10b266762a205756cc0deb8d4b0))

# [5.0.0](https://github.com/guidebooks/store/compare/4.0.5...5.0.0) (2023-02-21)


### Features

* remove ray autoscaler option in ml/ray/cluster/kubernetes/choose-pod-scheduler ([5db8f4c](https://github.com/guidebooks/store/commit/5db8f4cd4593c48dbaac9d6db7a74265a2cc5486))


### BREAKING CHANGES

* this removes support for using the ray operator. There is some breaking skew in ray 2 that we have not accounted for in our fork of the ray helm chart.

## [4.0.5](https://github.com/guidebooks/store/compare/4.0.4...4.0.5) (2023-02-21)


### Bug Fixes

* ray kube label selectors were not discriminating by job ([ddad4d8](https://github.com/guidebooks/store/commit/ddad4d8c0da002a392e142f3b4748da0fb3d2989))

## [4.0.4](https://github.com/guidebooks/store/compare/4.0.3...4.0.4) (2023-02-21)


### Bug Fixes

* allow tests to specifying name of ray-head service ([9f16453](https://github.com/guidebooks/store/commit/9f16453aa514ad97740d8afbc23184a9d95c3a13))

## [4.0.3](https://github.com/guidebooks/store/compare/4.0.2...4.0.3) (2023-02-20)


### Bug Fixes

* another fix for pod-vmstat colors ([7801065](https://github.com/guidebooks/store/commit/78010651a95cbcb889728a5dffab597e1bcbb23a))

## [4.0.2](https://github.com/guidebooks/store/compare/4.0.1...4.0.2) (2023-02-20)


### Bug Fixes

* restore colors in pod-vmstat ([b1d5e42](https://github.com/guidebooks/store/commit/b1d5e42f5ae0df7d76841ce86b7540efdcb11027))
* some ray kubernetes resource names may exceed 63 chars ([642c842](https://github.com/guidebooks/store/commit/642c842c3cedca7bd481e5370ff91084f3dc0fe7))

## [4.0.1](https://github.com/guidebooks/store/compare/4.0.0...4.0.1) (2023-02-20)


### Bug Fixes

* add missing free memory to pod-vmstat, and missing timestamp to pod-vmstat-memory ([041215c](https://github.com/guidebooks/store/commit/041215c197b0d2a92151ef00962bc65060d4e71f))

# [4.0.0](https://github.com/guidebooks/store/compare/3.3.12...4.0.0) (2023-02-20)


### Features

* improve console readability of ml/ray/run/pod-vmstat and memory stats ([e5fd5a6](https://github.com/guidebooks/store/commit/e5fd5a64998cac0c14bd27de4b1de611d87a75e6))


### BREAKING CHANGES

* this breaks any clients that were assuming a normal vmstat format for the cpu stats. it is now limited to the cpu columns (i.e. us sy id wa st).

## [3.3.12](https://github.com/guidebooks/store/compare/3.3.11...3.3.12) (2023-02-19)


### Bug Fixes

* extend websocat fix ([54b7d85](https://github.com/guidebooks/store/commit/54b7d85eeb99577d12325bb43f5961ca76381814))

## [3.3.11](https://github.com/guidebooks/store/compare/3.3.10...3.3.11) (2023-02-19)


### Bug Fixes

* ml/ray/run/logs/via-websocat may fail with errno 22 ([0739192](https://github.com/guidebooks/store/commit/0739192caef8616e9d5c94e0df72ff02c1c30ea8))

## [3.3.10](https://github.com/guidebooks/store/compare/3.3.9...3.3.10) (2023-02-19)


### Bug Fixes

* ml/ray/aggregator/with-jobid does not prepare ray cluster ([6d0d8c4](https://github.com/guidebooks/store/commit/6d0d8c4b75c3245799a77b82abefb33b9b9344d4))

## [3.3.9](https://github.com/guidebooks/store/compare/3.3.8...3.3.9) (2023-02-17)


### Bug Fixes

* ray-api port-forward should use a pod-running-timeout ([7ae6e13](https://github.com/guidebooks/store/commit/7ae6e1370496f87aba24cf63f5b03a29ce177838))

## [3.3.8](https://github.com/guidebooks/store/compare/3.3.7...3.3.8) (2023-02-17)


### Bug Fixes

* ray helm chart names may have invalid uppercase characters ([16c6c3c](https://github.com/guidebooks/store/commit/16c6c3c84f9f8f6ad743e5f36be0a1dad5751e82))

## [3.3.7](https://github.com/guidebooks/store/compare/3.3.6...3.3.7) (2023-02-17)


### Bug Fixes

* ray helm chart names may exceed 53 characters ([41c878b](https://github.com/guidebooks/store/commit/41c878b153abc4c7272f956d282840d689db6084))

## [3.3.6](https://github.com/guidebooks/store/compare/3.3.5...3.3.6) (2023-02-16)


### Bug Fixes

* self-destruct rbacs should be versioned ([1fa9e75](https://github.com/guidebooks/store/commit/1fa9e7549475aa3a4db770169512b83eac868005))

## [3.3.5](https://github.com/guidebooks/store/compare/3.3.4...3.3.5) (2023-02-16)


### Bug Fixes

* squash errors from helm auto-cleanup ([4f0e16a](https://github.com/guidebooks/store/commit/4f0e16adcd072fa0f3a84a3fca59e0655c466a8c))

## [3.3.4](https://github.com/guidebooks/store/compare/3.3.3...3.3.4) (2023-02-16)


### Bug Fixes

* self-destruct does not properly clean up on job termination ([ece4711](https://github.com/guidebooks/store/commit/ece4711bd6b88d2d21d2d4affd91c648c0911408))

## [3.3.3](https://github.com/guidebooks/store/compare/3.3.2...3.3.3) (2023-02-16)


### Bug Fixes

* self-destruct cleanup failure should not cause overall failure ([cb6399b](https://github.com/guidebooks/store/commit/cb6399bf77825f67337b1e8ffa30e23274850da6))

## [3.3.2](https://github.com/guidebooks/store/compare/3.3.1...3.3.2) (2023-02-16)


### Bug Fixes

* ray self-destruct fails with $USER is not defined ([0aae213](https://github.com/guidebooks/store/commit/0aae213f37581553c5101ef733d07e1691b64dca))
* ray self-destruct should clean up after itself ([0e4e625](https://github.com/guidebooks/store/commit/0e4e625356a246efe8e5056f949a5c9711573c2e))

## [3.3.1](https://github.com/guidebooks/store/compare/3.3.0...3.3.1) (2023-02-16)


### Bug Fixes

* restore finally in ml/codeflare/training/byoc ([654ead7](https://github.com/guidebooks/store/commit/654ead70d8738045671231d2a099dd6fb417e224))

# [3.3.0](https://github.com/guidebooks/store/compare/3.2.0...3.3.0) (2023-02-16)


### Features

* ray helm chart should tear itself down when job completes ([3fa402b](https://github.com/guidebooks/store/commit/3fa402b421f67683f1441bd00743b34b36acdff0))

# [3.2.0](https://github.com/guidebooks/store/compare/3.1.1...3.2.0) (2023-02-15)


### Features

* clean up ml/ray/start/kubernetes ([91a1f9e](https://github.com/guidebooks/store/commit/91a1f9e3fbec503f692bc30a602084233f43e5a1))
* discontinue import of ray cli for ml/ray/start ([1acec02](https://github.com/guidebooks/store/commit/1acec02940c6f05de07a1cc29fed5bd252dd93b8))

## [3.1.1](https://github.com/guidebooks/store/compare/3.1.0...3.1.1) (2023-02-14)


### Bug Fixes

* ml/codeflare/tuning/glue/submit lacks closing triple-backtick ([c0c6bf3](https://github.com/guidebooks/store/commit/c0c6bf3595549b3f70b2a96ed6a979d6a68a6671))

# [3.1.0](https://github.com/guidebooks/store/compare/3.0.0...3.1.0) (2023-02-14)


### Bug Fixes

* remove unnecessary import of ml/ray/cli/install ([a474adb](https://github.com/guidebooks/store/commit/a474adb43c14a3e3b4ba889190e904dee620559a))


### Features

* remove funky ml/torchx/install/cli with its odd ray cli dependence ([4693c31](https://github.com/guidebooks/store/commit/4693c317fbd9f529750766a30fa41fbcd8025178))
* remove ml/ray/stop/local ([be2039a](https://github.com/guidebooks/store/commit/be2039a596d82acdd2500cb1102c979473b60513))

# [3.0.0](https://github.com/guidebooks/store/compare/2.3.6...3.0.0) (2023-02-14)


### Bug Fixes

* further porting to byoc-style ([9082933](https://github.com/guidebooks/store/commit/9082933e9b111d1bcf32077c7f76daa42fbcae76))


### Features

* remove ancient ml/ray/run/.../examples and python/pip/... ([b12dce7](https://github.com/guidebooks/store/commit/b12dce76e4fa55e4cb6d74249d74845637dfe842))


### BREAKING CHANGES

* removal of guidebooks

## [2.3.6](https://github.com/guidebooks/store/compare/2.3.5...2.3.6) (2023-02-14)


### Bug Fixes

* port ml/codeflare/training/demos/getting-started to simpler byoc-style ([d38c9bf](https://github.com/guidebooks/store/commit/d38c9bf7c72fe35b9ef2c7e48a06a447e90ebeee))
* ray service was not selective enough ([92dd13c](https://github.com/guidebooks/store/commit/92dd13cb4c65c88646e98a71550d088cedba648a))

## [2.3.5](https://github.com/guidebooks/store/compare/2.3.4...2.3.5) (2023-02-13)


### Bug Fixes

* add app.kubernetes.io/name label to ray helm chart worker and head ([7135279](https://github.com/guidebooks/store/commit/71352794a16f5d214b70ef0a3eacdc97b7fa0b78))
* we were hard-coding ray v2 for ml/ray/run/choose ([68f30fc](https://github.com/guidebooks/store/commit/68f30fc554de1264d9d2b0d9da075f7df902e36c))

## [2.3.4](https://github.com/guidebooks/store/compare/2.3.3...2.3.4) (2023-02-10)


### Bug Fixes

* ray server-side log aggregator emits debug/verbose output on client ([81fb933](https://github.com/guidebooks/store/commit/81fb933b8094739dd180076e8951ecb06adf9148))

## [2.3.3](https://github.com/guidebooks/store/compare/2.3.2...2.3.3) (2023-02-10)


### Bug Fixes

* improve message announcing ray api port forward ([e7e7f79](https://github.com/guidebooks/store/commit/e7e7f7917143d458a81aba0f8f77e275b951a769))
* ml/ray/run/choose should wait a bit for ray job to be active ([01eba4a](https://github.com/guidebooks/store/commit/01eba4a9a0b7770e35d14875bb69fdbbe419a96c))

## [2.3.2](https://github.com/guidebooks/store/compare/2.3.1...2.3.2) (2023-02-09)


### Bug Fixes

* ray in-cluster attach had bit rotted ([f517379](https://github.com/guidebooks/store/commit/f517379ffc288876645116d8905f3e9911a2ecf3))

## [2.3.1](https://github.com/guidebooks/store/compare/2.3.0...2.3.1) (2023-02-07)


### Bug Fixes

* update default ray cluster name to user $USER ([ccc00f8](https://github.com/guidebooks/store/commit/ccc00f802e38da2224f04faa54260b204b8cfb92))

# [2.3.0](https://github.com/guidebooks/store/compare/2.2.10...2.3.0) (2023-02-02)


### Features

* allow ray jobs to specify ephemeral storage requirements ([58c456a](https://github.com/guidebooks/store/commit/58c456ac43b2ddcc4870d0a1ed5f3c28ecd1b2e2))

## [2.2.10](https://github.com/guidebooks/store/compare/2.2.9...2.2.10) (2023-02-02)


### Bug Fixes

* avoid pvc name collisions e.g. pvc-0 ([0d35514](https://github.com/guidebooks/store/commit/0d355140f737eb8575bb3799ca5c128d2f8310ae))
* ray head node should also mount s3fs data ([98f0df2](https://github.com/guidebooks/store/commit/98f0df270736b4f059a9e0b011533d13f564ab50))

## [2.2.9](https://github.com/guidebooks/store/compare/2.2.8...2.2.9) (2023-02-01)


### Bug Fixes

* ml/ray/stop/kubernetes/with-known-cluster-name should check if it has a ray cluster name ([bfc3810](https://github.com/guidebooks/store/commit/bfc38103ade448ce440f14070fca701193e4f78b))

## [2.2.8](https://github.com/guidebooks/store/compare/2.2.7...2.2.8) (2023-02-01)


### Bug Fixes

* kube events no longer stream ([c68ffdf](https://github.com/guidebooks/store/commit/c68ffdf59ad483fcb0515d16e558f9eb4e3804b5))

## [2.2.7](https://github.com/guidebooks/store/compare/2.2.6...2.2.7) (2023-02-01)


### Bug Fixes

* inconsistent use of dots and dashes in pvc claim name ([9c64c34](https://github.com/guidebooks/store/commit/9c64c34e7b0cc3fcf83e7cae0024a48bf36dd831))

## [2.2.6](https://github.com/guidebooks/store/compare/2.2.5...2.2.6) (2023-02-01)


### Bug Fixes

* use echo -n when base64-encoding secrets ([6885257](https://github.com/guidebooks/store/commit/688525797d6a6ae9814b9bdbaf5090abc0e89cef))

## [2.2.5](https://github.com/guidebooks/store/compare/2.2.4...2.2.5) (2023-02-01)


### Bug Fixes

* improved filtering of kubernetes events ([60cee25](https://github.com/guidebooks/store/commit/60cee25a2d61a9a34bf80175015bc99f6cfcfc67))
* kube volume name may exceed 63 chars ([9b807b9](https://github.com/guidebooks/store/commit/9b807b90d6a355418ac0efea5edb62738f1322ca))
* ml/ray/start/kubernetes should only track events for my job ([2beb22b](https://github.com/guidebooks/store/commit/2beb22b7bf62dd1fc68b0ee5790e634b6df1021a))
* s3fs secrets need to be base64 encoded ([51ef88f](https://github.com/guidebooks/store/commit/51ef88f4b1fcd15c63e00e98743170572a3b1607))

## [2.2.4](https://github.com/guidebooks/store/compare/2.2.3...2.2.4) (2023-02-01)


### Bug Fixes

* move s3fs pvc and secret to helm chart ([d12fc5b](https://github.com/guidebooks/store/commit/d12fc5b174db366adb9c2587189e67fddb10b7c0))
* pvc name should use jobid not cluster name ([eed5f8e](https://github.com/guidebooks/store/commit/eed5f8e2c6e32825a58d762abb6b622a4edf8b69))

## [2.2.3](https://github.com/guidebooks/store/compare/2.2.2...2.2.3) (2023-02-01)


### Bug Fixes

* pvc configuration does not handle spaces in mountPath ([da1bb9a](https://github.com/guidebooks/store/commit/da1bb9ab59c73d2fd5c84bbcf83ed4bc342e6249))
* s3/choose/s3fs/kubernetes may fail to create pvc ([c7afbba](https://github.com/guidebooks/store/commit/c7afbbad674c23cb1c9129dd43100956c0c1f803))
* s3fs secret and claim name should hash in cluster name ([8246d4f](https://github.com/guidebooks/store/commit/8246d4f325676e96261bc84e24831e77f8218564))

## [2.2.2](https://github.com/guidebooks/store/compare/2.2.1...2.2.2) (2023-01-31)


### Bug Fixes

* add missing choice description for s3/choose/s3fs/storage-class ([3a3c905](https://github.com/guidebooks/store/commit/3a3c9051553b53fe1e0ae15a5130a5caaabb60c7))

## [2.2.1](https://github.com/guidebooks/store/compare/2.2.0...2.2.1) (2023-01-31)


### Bug Fixes

* bump to madwizard ^4.5.0 to pick up :::: fix ([34b0390](https://github.com/guidebooks/store/commit/34b0390b20e6f32954c3aa0fd13b025072cfcf90))

# [2.2.0](https://github.com/guidebooks/store/compare/2.1.2...2.2.0) (2023-01-31)


### Features

* allow users to choose storage class in s3/choose/s3fs/kubernetes ([3bb90ce](https://github.com/guidebooks/store/commit/3bb90cea1e5b4e24919015e65fcdfee5ca2fb7ff))

## [2.1.2](https://github.com/guidebooks/store/compare/2.1.1...2.1.2) (2023-01-17)


### Bug Fixes

* ray helm chart syntax error for imagePullSecrets ([56f59e7](https://github.com/guidebooks/store/commit/56f59e7a2e14dc341b87e9ec81119f62e2debfe1))

## [2.1.1](https://github.com/guidebooks/store/compare/2.1.0...2.1.1) (2023-01-17)


### Bug Fixes

* helm uninstall (ray stop) issued immediately after helm install can leave dangling helm ([a0a2712](https://github.com/guidebooks/store/commit/a0a271243eaec0aa978f177eb97bdd1b67f423d5))
* work around finally ordering issue ([ac9ca4b](https://github.com/guidebooks/store/commit/ac9ca4bc7c4640ca719d84faa6f4991126ed6d4a))

# [2.1.0](https://github.com/guidebooks/store/compare/2.0.3...2.1.0) (2023-01-17)


### Bug Fixes

* minor change in import kubectl.md -> kubectl ([6c60ef7](https://github.com/guidebooks/store/commit/6c60ef752e51e27c6cdf6248e1a9d78441720cf2))


### Features

* bump madwizard@4.3.0, update ml/codeflare to use finally new support ([29d6c2c](https://github.com/guidebooks/store/commit/29d6c2cce06a563624841150967dac780b9055f0))

## [2.0.3](https://github.com/guidebooks/store/compare/2.0.2...2.0.3) (2023-01-13)


### Bug Fixes

* install-via-helm should allow user to request dry-run ([c5cbecc](https://github.com/guidebooks/store/commit/c5cbecc9275bff1213d4fccd16c19e64504402b3))

## [2.0.2](https://github.com/guidebooks/store/compare/2.0.1...2.0.2) (2023-01-12)


### Bug Fixes

* ml/codeflare/training/demos/getting-started doesn't tear down ray ([4913b1a](https://github.com/guidebooks/store/commit/4913b1a7ce989daf2613e272fdf45d4d691bf8b0))
* ml/ray/start helm chart schema violation for imagePullSecret ([87daba9](https://github.com/guidebooks/store/commit/87daba992e48e19a19405ee88a45893ad30f0f67))

## [2.0.1](https://github.com/guidebooks/store/compare/2.0.0...2.0.1) (2023-01-11)


### Bug Fixes

* kubernetes/choose/ns should also filter out calico-system and tigera-operator ([d016a2d](https://github.com/guidebooks/store/commit/d016a2d4fd95891467a137f801e73b974dbdd241))

# [2.0.0](https://github.com/guidebooks/store/compare/1.11.5...2.0.0) (2023-01-11)


### Bug Fixes

* kubernetes image-pull can hang if cluster is not reachable ([76f9ecc](https://github.com/guidebooks/store/commit/76f9ecce23c7b53119801d5f5d8d3fff74851ffc))


### BREAKING CHANGES

* rename kubernetes/secrets/image-pull to kubernetes/choose/secret/image-pull

## [1.11.5](https://github.com/guidebooks/store/compare/1.11.4...1.11.5) (2023-01-10)


### Bug Fixes

* ugh, bumper again messed up install-via-helm.sh ([e995a28](https://github.com/guidebooks/store/commit/e995a28c2e6394b02261045925e8bf2221e677a0))

## [1.11.4](https://github.com/guidebooks/store/compare/1.11.3...1.11.4) (2023-01-10)


### Bug Fixes

* add more missing description paragraphs ([11c5991](https://github.com/guidebooks/store/commit/11c5991e15ae8b1e1b68e09f438e57d44d3560d4))

## [1.11.3](https://github.com/guidebooks/store/compare/1.11.2...1.11.3) (2023-01-10)


### Bug Fixes

* improved description text for byoc and roberta ([1e6a5d9](https://github.com/guidebooks/store/commit/1e6a5d9e10e2200f1ae3b1e4a1bfa7dbecc2ac1c))

## [1.11.2](https://github.com/guidebooks/store/compare/1.11.1...1.11.2) (2023-01-10)


### Bug Fixes

* ml/ray/run/pod-vmstat-memory does not support cgroup v2 api ([78cd603](https://github.com/guidebooks/store/commit/78cd603f74cace5b7828ba065d3383334e60c33a))

## [1.11.1](https://github.com/guidebooks/store/compare/1.11.0...1.11.1) (2023-01-09)


### Bug Fixes

* ml/codeflare/training/byoc may not stop ray cluster automatically ([944676a](https://github.com/guidebooks/store/commit/944676a04384cef4c74382107a3e109eb3cb6aef))
* ray helm chart install was not passing through imagePullSecret ([3694ce4](https://github.com/guidebooks/store/commit/3694ce46e5276655839e05739da18b0bd860b75b))

# [1.11.0](https://github.com/guidebooks/store/compare/1.10.1...1.11.0) (2023-01-09)


### Bug Fixes

* improve wording of cancel in ml/ray/stop/kubernetes ([ad6ce31](https://github.com/guidebooks/store/commit/ad6ce318f2d085ec0c7864e2defcf41e4fed3e9e))


### Features

* initial support for image pull secrets ([19626e8](https://github.com/guidebooks/store/commit/19626e8b07e791e1a1ebd3a065ebb74e4035a9f3))

## [1.10.1](https://github.com/guidebooks/store/compare/1.10.0...1.10.1) (2023-01-09)


### Bug Fixes

* s3fs guidebooks may result in asking the s3/choose/instance question twice ([923b74f](https://github.com/guidebooks/store/commit/923b74f1364e1048dd2e317cb17839ee5dceb61a))

# [1.10.0](https://github.com/guidebooks/store/compare/1.9.4...1.10.0) (2023-01-06)


### Bug Fixes

* minor tweak to demo guidebooks to leverage $choice variable ([c77fe92](https://github.com/guidebooks/store/commit/c77fe9284a5fda1f99600274ba2142e9906f4c27))


### Features

* generalize s3fs support ([682388d](https://github.com/guidebooks/store/commit/682388df7cf4fc1465a7a7b70e80cdb4f2c5b228))

## [1.9.4](https://github.com/guidebooks/store/compare/1.9.3...1.9.4) (2022-12-25)


### Bug Fixes

* flesh out the demo/multi descriptions and choices ([3019689](https://github.com/guidebooks/store/commit/301968990d0332b9ca82302cbe8dab61da7c15f2))

## [1.9.3](https://github.com/guidebooks/store/compare/1.9.2...1.9.3) (2022-12-17)


### Bug Fixes

* ml/ray/install/cli assumed venv support was installed ([3c98a48](https://github.com/guidebooks/store/commit/3c98a48ee35ef3534f2557c677aae8398c73a25e))

## [1.9.2](https://github.com/guidebooks/store/compare/1.9.1...1.9.2) (2022-12-12)


### Bug Fixes

* add form and multiselect examples to demo guidebook ([ffafa82](https://github.com/guidebooks/store/commit/ffafa82a5c314985f71c7bb433e28b991f10a48b))

## [1.9.1](https://github.com/guidebooks/store/compare/1.9.0...1.9.1) (2022-12-12)


### Bug Fixes

* switch from madwizard-cli to madwizard-cli-core ([2ff8caa](https://github.com/guidebooks/store/commit/2ff8caaa37d4f5e457e20e7046bb535a8ba0b38d))

# [1.9.0](https://github.com/guidebooks/store/compare/1.8.0...1.9.0) (2022-12-08)


### Features

* switch from madwizard to madwizard-cli for madwizard cli ([f747168](https://github.com/guidebooks/store/commit/f7471688755e6b05af93c248710a2ff545e2477a))

# [1.8.0](https://github.com/guidebooks/store/compare/1.7.1...1.8.0) (2022-12-08)


### Bug Fixes

* bump to >=madwizard@1.10.3 to pick up description and relpath fixes ([a441250](https://github.com/guidebooks/store/commit/a441250ce0aec366c3942a0019f5de2ebe90184c))
* remove debugging output from ray helm install ([1d6c8e4](https://github.com/guidebooks/store/commit/1d6c8e4aca74e0bab63355fa3ae449e11bfff0b0))
* update util/hello to echo hello world ([116a3b2](https://github.com/guidebooks/store/commit/116a3b29763c9903e198d939951a579e085c62c1))


### Features

* add s3/minio to facilitate standing up minio in kubernetes ([2baa4d2](https://github.com/guidebooks/store/commit/2baa4d26d19eba4abeab5be8049923018bffb3e5))

## [1.7.1](https://github.com/guidebooks/store/compare/1.7.0...1.7.1) (2022-12-02)


### Bug Fixes

* add missing title to ml/ray/storage/s3/maybe ([9109e1d](https://github.com/guidebooks/store/commit/9109e1d7ff0272ead9a4bf0ee279ad4737df0aa7))

# [1.7.0](https://github.com/guidebooks/store/compare/1.6.1...1.7.0) (2022-12-02)


### Bug Fixes

* handle 0-worker case for ray ([9b94f4e](https://github.com/guidebooks/store/commit/9b94f4e6b37f86adf90b41234c3473f21236cd35))


### Features

* add s3 secrets to ray head deployment so that --storage=s3:// works ([355d230](https://github.com/guidebooks/store/commit/355d23003fb4c4033c30120d74f1d82129fd81f2))

## [1.6.1](https://github.com/guidebooks/store/compare/1.6.0...1.6.1) (2022-12-02)


### Bug Fixes

* leftover reference to using /tmp for ray storage ([7aea102](https://github.com/guidebooks/store/commit/7aea102495c9bcdf4e32558d824323fb942ba507))
* ml/ray/start should not need torchx ([4f24298](https://github.com/guidebooks/store/commit/4f242989ac9157a0628dcc9d07e26abdc12df397))

# [1.6.0](https://github.com/guidebooks/store/compare/1.5.0...1.6.0) (2022-12-01)


### Features

* update ml/ray/cluster/choose to use madwizard env-keyed choice ([cc87842](https://github.com/guidebooks/store/commit/cc87842238875c2be8250d59a11ad8c2b2d7638a))

# [1.5.0](https://github.com/guidebooks/store/compare/1.4.3...1.5.0) (2022-12-01)


### Features

* install ray as a venv that is managed by us ([7eba971](https://github.com/guidebooks/store/commit/7eba97112ef01e7e4c3d23335a2a09b94b48c8a4))

## [1.4.3](https://github.com/guidebooks/store/compare/1.4.2...1.4.3) (2022-12-01)


### Bug Fixes

* ml/ray/cluster/choose does not work against ray's helm chart ([4ad60e4](https://github.com/guidebooks/store/commit/4ad60e42a08336786ebefddfbded95100ce18f1c))
* ray charts use fixed name for rbac resources ([7dc8834](https://github.com/guidebooks/store/commit/7dc88343c46e3616f2f09ed2822534b8c4912c6e))
* use /dev/shm for ray --storage to allow sharing for workflows ([eae870f](https://github.com/guidebooks/store/commit/eae870f6ad1ac3e849870d5669182a818a12150b))

## [1.4.2](https://github.com/guidebooks/store/compare/1.4.1...1.4.2) (2022-12-01)


### Bug Fixes

* ml/ray/stop may not list ray clusters ([9934933](https://github.com/guidebooks/store/commit/9934933fac9a2f64ac959d8afd873573442ce12f))

## [1.4.1](https://github.com/guidebooks/store/compare/1.4.0...1.4.1) (2022-11-30)


### Bug Fixes

* my/ray/cluster/choose was hard-wiring kube context and ns ([ee28d56](https://github.com/guidebooks/store/commit/ee28d5682b998b416a72f88d9444db33155a5ddb))

# [1.4.0](https://github.com/guidebooks/store/compare/1.3.0...1.4.0) (2022-11-30)


### Features

* ray cluster name should vary by job ([b2ac6cf](https://github.com/guidebooks/store/commit/b2ac6cf2df3dbef5ae129dbdc6a864bc7d630f18))

# [1.3.0](https://github.com/guidebooks/store/compare/1.2.3...1.3.0) (2022-11-30)


### Features

* allow use of ibmcloud codeengine for kubernetes context selection ([235d006](https://github.com/guidebooks/store/commit/235d0069f40341559c4b97cd1376fed80198e9d3))

## [1.2.3](https://github.com/guidebooks/store/compare/1.2.2...1.2.3) (2022-11-29)


### Bug Fixes

* improve description for kubernetes/choose/ns ([6ff5c2c](https://github.com/guidebooks/store/commit/6ff5c2c57a35342a7b568e6c49af7adbcbca1537))
* improve description for roberta choose-data ([47fdb9c](https://github.com/guidebooks/store/commit/47fdb9c5ad934f72a4f8ac95c56658dc93356887))
* some optimizations for ibmcloud expansions ([43a9d05](https://github.com/guidebooks/store/commit/43a9d0550c0a4a9befaff32a1c71cefbe352d3d2))

## [1.2.2](https://github.com/guidebooks/store/compare/1.2.1...1.2.2) (2022-11-29)


### Bug Fixes

* ml/ray/codeflare/training/roberta used base image lacking torch ([f07c9a9](https://github.com/guidebooks/store/commit/f07c9a97099b94f22244add8699ab257c169806f))

## [1.2.1](https://github.com/guidebooks/store/compare/1.2.0...1.2.1) (2022-11-28)


### Bug Fixes

* ml/codeflare/training/roberta was using non-gpu ray base image ([312ad1f](https://github.com/guidebooks/store/commit/312ad1fb77a4663a12fd1a61b9706376226bb101))

# [1.2.0](https://github.com/guidebooks/store/compare/1.1.1...1.2.0) (2022-11-28)


### Bug Fixes

* sigh, release-it/bumper replaced '/1000' with '.1.0' ([277cef1](https://github.com/guidebooks/store/commit/277cef1568ec72bbc3f3855e17e92d38e43afbfd))

## [1.1.1](https://github.com/guidebooks/store/compare/1.1.0...1.1.1) (2022-11-27)


### Bug Fixes

* force ml/codeflare/training/roberta to use ray v1 ([17041e2](https://github.com/guidebooks/store/commit/17041e211e09ea43e31bc28bf26dbed2b73cf104))

# [1.1.0](https://github.com/guidebooks/store/compare/1.0.0...1.1.0) (2022-11-23)


### Bug Fixes

* make ray operator base image consistent with main base image ([0e67a5a](https://github.com/guidebooks/store/commit/0e67a5a6726e1ba2ed1df86e3880862998ed2e16))


### Features

* add ml/ray/v1 to allow use cases to insist on using ray v1 ([236d493](https://github.com/guidebooks/store/commit/236d4935c30eb95022f7913b69f312732ef0dcdd))

# [1.0.0](https://github.com/guidebooks/store/compare/0.18.2...1.0.0) (2022-11-23)


### Bug Fixes

* set storage path in ray head start ([43a7544](https://github.com/guidebooks/store/commit/43a75442f964958ee71ebd072cadb0375baecc99))


### Features

* bump default ray image to 2.1 (from 1.13.0) ([b2f8e11](https://github.com/guidebooks/store/commit/b2f8e118b03d2193145b973738da5cd3bf743ef4))


### BREAKING CHANGES

* this is a major update to the ray api

## [0.18.2](https://github.com/guidebooks/store/compare/0.18.1...0.18.2) (2022-11-23)


### Bug Fixes

* back out adding RAY_ADDRESS to head pod ([65dfb61](https://github.com/guidebooks/store/commit/65dfb611f61a120d9872158b363c1380f62fcc3a))

## [0.18.1](https://github.com/guidebooks/store/compare/0.18.0...0.18.1) (2022-11-22)


### Bug Fixes

* ml/ray/start/kubernetes/port-forward/ray causes cpu spinloop ([59593af](https://github.com/guidebooks/store/commit/59593affe1a3f9b280b23eed05720b680c4f4c00))

# [0.18.0](https://github.com/guidebooks/store/compare/0.17.7...0.18.0) (2022-11-22)


### Features

* add mcad `completionstatus` field to ray worker and head jobs ([7dc2874](https://github.com/guidebooks/store/commit/7dc2874134fbf52bc3e9e45a297b45bafab90f03))
* automatically shut down ray upon completion, for roberta and byoc ([19c5ed9](https://github.com/guidebooks/store/commit/19c5ed9dcb1f7bbbd5e9e59a39cc18ecd1316f66))
* bump mcad to pick up `completionstatus` support ([0d511b6](https://github.com/guidebooks/store/commit/0d511b677537a55c147fa28b52adb17e02038245))
* switch from Deployment to Job for ray ([425e5f2](https://github.com/guidebooks/store/commit/425e5f222fa6d07c0fc51d8a07949578ca338f26))

## [0.17.7](https://github.com/guidebooks/store/compare/0.17.6...0.17.7) (2022-11-18)


### Bug Fixes

* refinements to title and description of ml/codeflare/training/byoc ([9ef0ad6](https://github.com/guidebooks/store/commit/9ef0ad69573389e5dadc06b421eecdf0db93acf7))

## [0.17.6](https://github.com/guidebooks/store/compare/0.17.5...0.17.6) (2022-11-18)


### Bug Fixes

* bump to madwizard 1.8.x to pick up description fixes ([d82538e](https://github.com/guidebooks/store/commit/d82538ec1d71fda661c30554b49280c76e75b213))

## [0.17.5](https://github.com/guidebooks/store/compare/0.17.4...0.17.5) (2022-11-18)


### Bug Fixes

* improved descriptions for ml/codeflare and ml/codeflare/run ([c84e290](https://github.com/guidebooks/store/commit/c84e290cbe5bdcc8034506243d4bb1e4768538ce))

## [0.17.4](https://github.com/guidebooks/store/compare/0.17.3...0.17.4) (2022-11-11)


### Bug Fixes

* kubernetes/mcad/choose/scheduler should allow tests to set default scheduler ([30edda8](https://github.com/guidebooks/store/commit/30edda833f4a0fa05c63c1dac1adb9d1afa29f55))

## [0.17.3](https://github.com/guidebooks/store/compare/0.17.2...0.17.3) (2022-11-10)


### Bug Fixes

* ml/tensorboard/start/kubernetes/install.sh has typos w.r.t. branch checkout ([0f68602](https://github.com/guidebooks/store/commit/0f6860261a0aa8882be7274aff200274c29b51cd))

## [0.17.2](https://github.com/guidebooks/store/compare/0.17.1...0.17.2) (2022-11-10)


### Bug Fixes

* workaround for madwizard bug in ml/codeflare/training/roberta/choose-data-public ([72a406f](https://github.com/guidebooks/store/commit/72a406feb28f099087513fbcb3f4779a465e0c63))

# [0.17.0](https://github.com/guidebooks/store/compare/0.16.0...0.17.0) (2022-11-09)


### Features

* split out ray advanced topics from ml/codeflare ([8c21d30](https://github.com/guidebooks/store/commit/8c21d3044cbde1c87b1dda291ee07f54fed943fc))

# [0.16.0](https://github.com/guidebooks/store/compare/0.15.2...0.16.0) (2022-11-09)


### Bug Fixes

* print out port or port forward ([bbd218c](https://github.com/guidebooks/store/commit/bbd218c91e2b51bf25dc3493b7595a1425f9521b))
* remove question marks from ml/codeflare and ml/codeflare/run titles ([ada0e0f](https://github.com/guidebooks/store/commit/ada0e0fa92fc34b453e831dacb722e1d72805283))
* update the terminology around choosing s3 credentials ([d6abd74](https://github.com/guidebooks/store/commit/d6abd748dde6ea3e083e5242ebd857cb63bc9dbd))
* use coscheduler for preinstalled mcad option ([2604681](https://github.com/guidebooks/store/commit/2604681dfc342d717f2f7147bce097879f228ad5))


### Features

* add ml/torchx/install/cli ([1e96ccd](https://github.com/guidebooks/store/commit/1e96ccdc412aea866a8b007c869a499541e52cef))
* add RAY_ADDRESS env var to ray head ([d6b0a6a](https://github.com/guidebooks/store/commit/d6b0a6a57d5a11cb84e4d648efdead82594bbc33))
* add support for torchx run ([e523eac](https://github.com/guidebooks/store/commit/e523eac8a9b994027bbc2febb5fad283dc25c2b6))

## [0.15.2](https://github.com/guidebooks/store/compare/0.15.1...0.15.2) (2022-10-26)


### Bug Fixes

* roberta s3fs did delete+create; replace with validator ([4039e4a](https://github.com/guidebooks/store/commit/4039e4a6f4adf5c3a96c4c75912e17722bc27fa4))

## [0.15.1](https://github.com/guidebooks/store/compare/0.15.0...0.15.1) (2022-10-25)


### Bug Fixes

* due to madwizard bug, aws/auth does not work ([c68be15](https://github.com/guidebooks/store/commit/c68be153378796539d37916cb1b3ed469ab56a43))

# [0.15.0](https://github.com/guidebooks/store/compare/0.14.3...0.15.0) (2022-10-25)


### Bug Fixes

* add validators to aws/install/cli ([53114c0](https://github.com/guidebooks/store/commit/53114c05e8de7b41a8cee95e606d51be9b37c2fe))
* s3fs pvc used deprecated storageclass ([f77bd0c](https://github.com/guidebooks/store/commit/f77bd0c89a8b37496464e5774baeffb5efca0545))
* util/spinner does not properly update and erase spinner ([9482107](https://github.com/guidebooks/store/commit/948210782e7d5b06fc03045c57cc9a3b9f5c8731))
* util/spinner may not hide cursor in non-pty stdouts ([c77fa4d](https://github.com/guidebooks/store/commit/c77fa4d70d9a14a8e22f0d67b8c1be9b5ad5f52e))


### Features

* add aws/install/cli ([851f426](https://github.com/guidebooks/store/commit/851f426b09d6615deaa7c0b0b7a921d1c8aa4b31))
* add util/spinner ([ae2a43b](https://github.com/guidebooks/store/commit/ae2a43bbe96117041245892308cdbc9a7f96251b))

## [0.14.3](https://github.com/guidebooks/store/compare/0.14.2...0.14.3) (2022-09-28)


### Bug Fixes

* improved error messages for docker/install ([197ba62](https://github.com/guidebooks/store/commit/197ba623d6cbe71fb6becacf69c4945edfceda84))
* update kubernetes/kind to install kind if needed ([6d296ee](https://github.com/guidebooks/store/commit/6d296ee7ebe4af07acd29b9f2b45aabd3825cd40))

## [0.14.2](https://github.com/guidebooks/store/compare/0.14.1...0.14.2) (2022-09-27)


### Bug Fixes

* missing title for ml/codeflare/training/demos ([30cedd3](https://github.com/guidebooks/store/commit/30cedd3855c1e0d0a30f7e5322e76e9aee217bdc))

## [0.14.1](https://github.com/guidebooks/store/compare/0.14.0...0.14.1) (2022-09-27)


### Bug Fixes

* kubernetes/choose/ns shows up in profile as kubernetes/choose/ns-with-context ([d910ced](https://github.com/guidebooks/store/commit/d910cedceb2db76c755c47079ea6c10ae1e31bb1))

# [0.14.0](https://github.com/guidebooks/store/compare/0.13.1...0.14.0) (2022-09-26)


### Bug Fixes

* ml/ray/cluster/kubernetes/choose-pod-scheduler was not properly importing mcad choice ([3eb1192](https://github.com/guidebooks/store/commit/3eb1192a60bedf3bf1b0d2f693d284808f2bb768))


### Features

* remove untested ray local remnants ([b1bf712](https://github.com/guidebooks/store/commit/b1bf712a2377090d1802c70e21e9e766455d7aae))

## [0.13.1](https://github.com/guidebooks/store/compare/0.13.0...0.13.1) (2022-09-25)


### Bug Fixes

* bump to madwizard 1.0.2 to pick up aprioris fixes ([080737a](https://github.com/guidebooks/store/commit/080737a58bc34b5c09067635245356c5094a8b73))

# [0.13.0](https://github.com/guidebooks/store/compare/0.12.6...0.13.0) (2022-09-24)


### Bug Fixes

* ml/ray/start/kubernetes expresses import dependencies that aren't needed ([968dd9f](https://github.com/guidebooks/store/commit/968dd9f83f61374413092a428d82cff8ea5330bc))
* ml/ray/start/kubernetes may leave "kubernetes.txt" in CWD ([de3c273](https://github.com/guidebooks/store/commit/de3c273461ac9a28213f6562eb89f5c4ed1a2702))
* roberta with sample input should use /tmp for logdir ([8523223](https://github.com/guidebooks/store/commit/8523223fd51973b03999ba394f708ee19bdeaf9e))


### Features

* add kubernetes/choose/ns-with-context to allow choice of ns with an a priori context choice ([f20a69e](https://github.com/guidebooks/store/commit/f20a69e0b888ec3c4b89d761108f5b99ff30f2b2))
* add util/envsubst and util/envsubst2 ([7aed3f0](https://github.com/guidebooks/store/commit/7aed3f0a0c9ef289b9afaf5c47bf8903bdf69f0d))
* bump to madwizard 1.0.0 which mandates use of imports versus inlining ([1e1b943](https://github.com/guidebooks/store/commit/1e1b943d2c24308e120e01dca161093efe584183))

## [0.12.6](https://github.com/guidebooks/store/compare/0.12.5...0.12.6) (2022-09-19)


### Bug Fixes

* pin openshift `oc` version to 4.10.33 ([3a2a08d](https://github.com/guidebooks/store/commit/3a2a08dd78d31bf1eabebbd1244b987903f66eb2))

## [0.12.5](https://github.com/guidebooks/store/compare/0.12.4...0.12.5) (2022-09-19)


### Bug Fixes

* ml/codeflare/training/roberta fails to fetch sample data in non-ibm clouds ([d48bd70](https://github.com/guidebooks/store/commit/d48bd7078be6eb3c56d6757d726af79b3afaf8a2))
* ml/codeflare/training/roberta sparse clone fails to checkout ([88ae463](https://github.com/guidebooks/store/commit/88ae4635b54a6f0fc2e6e4d976abdaf15e48e706))

## [0.12.4](https://github.com/guidebooks/store/compare/0.12.3...0.12.4) (2022-09-16)


### Bug Fixes

* use pip3 rather than pip to install deps ([3ca3fc6](https://github.com/guidebooks/store/commit/3ca3fc6d42a40ffa42d796d3190c284ca898a066))

## [0.12.3](https://github.com/guidebooks/store/compare/0.12.2...0.12.3) (2022-09-16)


### Bug Fixes

* sparse checkout branches need not be main/master ([f1ef3d4](https://github.com/guidebooks/store/commit/f1ef3d4407d41d407d858980396d9b4074097810))

## [0.12.2](https://github.com/guidebooks/store/compare/0.12.1...0.12.2) (2022-09-16)


### Bug Fixes

* sparse checkout update uses wrong branch for mcad and coschedulerE ([63b89b2](https://github.com/guidebooks/store/commit/63b89b21d250f1348ceb4f00239f5bfa71204393))

## [0.12.1](https://github.com/guidebooks/store/compare/0.12.0...0.12.1) (2022-09-16)


### Bug Fixes

* improve git compatibility with sparse checkout ([7c6cbdf](https://github.com/guidebooks/store/commit/7c6cbdfb9388ecc1fd2f4e5edf9ce6133266aa31))

# [0.12.0](https://github.com/guidebooks/store/compare/0.11.3...0.12.0) (2022-09-16)


### Features

* discontinue support for ray local (ray kube only) ([431dc11](https://github.com/guidebooks/store/commit/431dc1142d2eb228d8ad437ccef05241bd6b5aa6))

## [0.11.3](https://github.com/guidebooks/store/compare/0.11.2...0.11.3) (2022-09-15)


### Bug Fixes

* enforce more restrictive securityContext for ray pods ([c89073a](https://github.com/guidebooks/store/commit/c89073a38374452e7f4797d2b2e9ed69cb357134))

## [0.11.2](https://github.com/guidebooks/store/compare/0.11.1...0.11.2) (2022-09-15)


### Bug Fixes

* add more PATH discovery options to ml/ray/install/cli ([a32299a](https://github.com/guidebooks/store/commit/a32299a4c8c64ade96fd5d865543dd17ba6cb8eb))

## [0.11.1](https://github.com/guidebooks/store/compare/0.11.0...0.11.1) (2022-09-15)


### Bug Fixes

* adjust default ray cluster resources to be less demanding ([423b107](https://github.com/guidebooks/store/commit/423b107c5e1b65c1876c936c4c67711f529f8407))
* another fix for re-installing the ray cli ([66b52df](https://github.com/guidebooks/store/commit/66b52dfdb53adafe0eee45c78be6a0b62010da51))
* if user selects "create namespace", then profile can get stuck ([87f9048](https://github.com/guidebooks/store/commit/87f90480ea752bf568e1de764ee7894500fea426))
* kubernetes/choose/ns does not set KUBE_NS_ARG for "create namespace" option ([bb41e24](https://github.com/guidebooks/store/commit/bb41e244a60ef28093da8b01b5a2c3c57760c2e2))
* on macOS, ray may still not be on PATH even after installation of the ray CLI ([0fc24c2](https://github.com/guidebooks/store/commit/0fc24c2ede0f6ad4503b2e03325e640b8e8c8c07))

# [0.11.0](https://github.com/guidebooks/store/compare/0.10.3...0.11.0) (2022-09-14)


### Features

* add ml/codeflare/training/demos/getting-started/s3 ([199f402](https://github.com/guidebooks/store/commit/199f40240c796344a7375671c4492a972d8d328f))

## [0.10.3](https://github.com/guidebooks/store/compare/0.10.2...0.10.3) (2022-09-14)


### Bug Fixes

* kubectl context and namespace args have to be after verb ([4deefc5](https://github.com/guidebooks/store/commit/4deefc573bac8729ee5b835678f05721736a0a6a))

## [0.10.2](https://github.com/guidebooks/store/compare/0.10.1...0.10.2) (2022-09-02)


### Bug Fixes

* /ml/codeflare/training/roberta/choose-data-public sets wrong variable ([1021cd4](https://github.com/guidebooks/store/commit/1021cd47e6974ab00017c47e68ec8b49954ba592))
* avoid detached HEAD warnings from ray helm git clone ([9fc9b0f](https://github.com/guidebooks/store/commit/9fc9b0f46cbb997cd52e1acdeb3ea5f619bcfe6b))

## [0.10.1](https://github.com/guidebooks/store/compare/0.10.0...0.10.1) (2022-09-02)


### Bug Fixes

* pvc delete command missing $ in `$ML_CODEFLARE_ROBERTA_S3FS_CLAIM` ([d9efd2b](https://github.com/guidebooks/store/commit/d9efd2be68d0d1e6c43c33f29d3ec8a7e3b351b4))

# [0.10.0](https://github.com/guidebooks/store/compare/0.9.0...0.10.0) (2022-09-02)


### Bug Fixes

* allow ray workers to use as much cpu as they need, if available ([6b96256](https://github.com/guidebooks/store/commit/6b962563273fd7954479d7160c7aa71906697894))
* back out prior removal of cpu limit ([983bb5c](https://github.com/guidebooks/store/commit/983bb5c6f9d40eaf87938171a95b372669b64611))
* ml/ray/start/kubernetes/install-via-helm.sh needs to pin a version for git clone ([7cd557f](https://github.com/guidebooks/store/commit/7cd557f5e74ee5a8bd38f311620f2ede27bd5f07))
* ml/ray/start/kubernetes/port-forward/ray should retry ([1744483](https://github.com/guidebooks/store/commit/174448389e9e3e6c5e85adc1eb01e7fd0048801d))
* ml/ray/stop should not require the ray cli ([df28bfc](https://github.com/guidebooks/store/commit/df28bfc9c7afa11c32d60c9b36765b2c2d26ed5e))


### Features

* allow guidebooks/ml/codeflare/training/roberta/demo s3 defaults to be overridden ([cfdd201](https://github.com/guidebooks/store/commit/cfdd201891aadc4c70b67b2afd153a08bd4a8c0a))
* support for s3fs in ml/codeflare/training/roberta ([0fd23a0](https://github.com/guidebooks/store/commit/0fd23a0759f239b1aaf9f02d7d9ced68fd62729a))

# [0.9.0](https://github.com/guidebooks/store/compare/0.8.3...0.9.0) (2022-08-31)


### Features

* update ml/codeflare/training/roberta/clone.sh to support ssh keys from secrets ([ae21a5b](https://github.com/guidebooks/store/commit/ae21a5bbf1b631efb0f18ccbab079de532da1d9b))

## [0.8.3](https://github.com/guidebooks/store/compare/0.8.2...0.8.3) (2022-08-31)


### Bug Fixes

* ibmcloud detector was not detecting anything ([72a172b](https://github.com/guidebooks/store/commit/72a172b2c0bb3e7e9ca81b6f665f9577ab36cf9f))

## [0.8.2](https://github.com/guidebooks/store/compare/0.8.1...0.8.2) (2022-08-31)


### Bug Fixes

* increase connection timeout in ibmcloud detector ([a13afad](https://github.com/guidebooks/store/commit/a13afad1566ea06701606b1a48412c37b7615ac5))

## [0.8.1](https://github.com/guidebooks/store/compare/0.8.0...0.8.1) (2022-08-31)


### Bug Fixes

* in ml/codeflare/training/roberta, lower b_size for sample input ([4e2e6b2](https://github.com/guidebooks/store/commit/4e2e6b2a575d2d2eec003fed737ce7a07882d9d0))

# [0.8.0](https://github.com/guidebooks/store/compare/0.7.3...0.8.0) (2022-08-31)


### Bug Fixes

* add get verb to ray head node role ([0094ee8](https://github.com/guidebooks/store/commit/0094ee898a0e47904a5bd99c18d753c43e023963))


### Features

* associate ray head pod with a serviceaccount ([9872455](https://github.com/guidebooks/store/commit/987245595f9ea2f201bfb2a9feca1ce6ecf23cb3))

## [0.7.3](https://github.com/guidebooks/store/compare/0.7.2...0.7.3) (2022-08-31)


### Bug Fixes

* update ml/codeflare/training/roberta to work outside of ibmcloud ([73e2ccf](https://github.com/guidebooks/store/commit/73e2ccfeb7d29a410ee25df4827cf53abc8d723b))

## [0.7.2](https://github.com/guidebooks/store/compare/0.7.1...0.7.2) (2022-08-31)


### Bug Fixes

* ml/codeflare/training/roberta regression in job submission ([d6ae0f6](https://github.com/guidebooks/store/commit/d6ae0f646942765545efc5c61fcdb0d3cecf9e80))

## [0.7.1](https://github.com/guidebooks/store/compare/0.7.0...0.7.1) (2022-08-31)


### Bug Fixes

* add a marker to the end of the getting-started guidebook ([1dbd721](https://github.com/guidebooks/store/commit/1dbd72188235d61af81de68e909710e4a7a3dce6))

# [0.7.0](https://github.com/guidebooks/store/compare/0.6.7...0.7.0) (2022-08-30)


### Features

* add ml/codeflare/training/demos/getting-started ([857964f](https://github.com/guidebooks/store/commit/857964f54b9badf9ea2b45d541828a11c6dfa104))

## [0.6.7](https://github.com/guidebooks/store/compare/0.6.6...0.6.7) (2022-08-30)


### Bug Fixes

* improve intro paragraph to the roberta guidebook ([5421213](https://github.com/guidebooks/store/commit/5421213a140bc8d8cbaafcc03c5d4750c06749e5))

## [0.6.6](https://github.com/guidebooks/store/compare/0.6.5...0.6.6) (2022-08-30)

## [0.6.5](https://github.com/guidebooks/store/compare/0.6.4...0.6.5) (2022-08-30)


### Bug Fixes

* allow roberta github location defaults to be overridden ([2b167c8](https://github.com/guidebooks/store/commit/2b167c85baca64e5d9681ae8f5e377428186c1d1))

## [0.6.4](https://github.com/guidebooks/store/compare/0.6.3...0.6.4) (2022-08-29)


### Bug Fixes

* switch to a stability branch of the ml/codeflare/training/roberta code ([9f4d0bb](https://github.com/guidebooks/store/commit/9f4d0bba841d27fb2fe2474436aa7e5d04822770))

## [0.6.3](https://github.com/guidebooks/store/compare/0.6.2...0.6.3) (2022-08-29)


### Bug Fixes

* ml/ray/cluster/kubernetes/is-ready can emit "workers 1/0" ([6ebccce](https://github.com/guidebooks/store/commit/6ebccce7f887e74484c1f76d8f42a7b498fe6dd0))

## [0.6.2](https://github.com/guidebooks/store/compare/0.6.1...0.6.2) (2022-08-28)


### Bug Fixes

* update ml/codeflare/training/roberta to specify --no-input to ray-submit intrinsic ([b955284](https://github.com/guidebooks/store/commit/b9552842cb6e295fd8296428890419910d67088f))

## [0.6.1](https://github.com/guidebooks/store/compare/0.6.0...0.6.1) (2022-08-27)


### Bug Fixes

* restore ray cli-based log streaming ([0b89f4d](https://github.com/guidebooks/store/commit/0b89f4da704a87bb01e0faefce2688b820d2770e))

# [0.6.0](https://github.com/guidebooks/store/compare/0.5.8...0.6.0) (2022-08-26)


### Bug Fixes

* ray helm chart incorrectly always uses 1 worker replica ([569c4ad](https://github.com/guidebooks/store/commit/569c4ad80e744b545dd568a01d41b1a92356c958))


### Features

* add ml/codeflare/training/roberta ([f2e6a6b](https://github.com/guidebooks/store/commit/f2e6a6bc10d3cb1e4e7d0b94da77c0b0d39a1463))

## [0.5.8](https://github.com/guidebooks/store/compare/0.5.7...0.5.8) (2022-08-25)


### Bug Fixes

* change ^ to >= for peer dependence on madwizard ([43ab1f6](https://github.com/guidebooks/store/commit/43ab1f6aed0bc30dbff751673f663b170d266aa8))

## [0.5.7](https://github.com/guidebooks/store/compare/0.5.6...0.5.7) (2022-08-23)


### Bug Fixes

* a few minor refinements to log/debug output ([40447b0](https://github.com/guidebooks/store/commit/40447b0ba6c8648ac56b4280b585080cb6b55366))
* ml/ray/cluster/head lacks KUBE_CONTEXT/NS in kubectl command ([b6adff1](https://github.com/guidebooks/store/commit/b6adff1dc061506a53b099da6cb72d40f6328041))
* remove old non-websocat way of fetching ray job logs ([be6c829](https://github.com/guidebooks/store/commit/be6c829a82fd644167e235e8ed25639340247fa9))

## [0.5.6](https://github.com/guidebooks/store/compare/0.5.5...0.5.6) (2022-08-23)


### Bug Fixes

* server-side aggregator needs to wait for job to be actually running ([0048c68](https://github.com/guidebooks/store/commit/0048c68717237340398d0c2eab875b0a0c94fc52))

## [0.5.5](https://github.com/guidebooks/store/compare/0.5.4...0.5.5) (2022-08-23)


### Bug Fixes

* pin ray (to 1.13) ([18ffab3](https://github.com/guidebooks/store/commit/18ffab373adcdb4c3cf2983afafec324247c88df))

## [0.5.4](https://github.com/guidebooks/store/compare/0.5.3...0.5.4) (2022-08-23)


### Bug Fixes

* two more fixes for log aggregator not waiting long enough ([0853310](https://github.com/guidebooks/store/commit/0853310b4e1a86c70cd28d280d3c58e72617a290))

## [0.5.3](https://github.com/guidebooks/store/compare/0.5.2...0.5.3) (2022-08-23)


### Bug Fixes

* client-side log aggregator may fail to collect job logs ([83be1f0](https://github.com/guidebooks/store/commit/83be1f0a84b7f4ad9596b6b429e930688d135a2e))

## [0.5.2](https://github.com/guidebooks/store/compare/0.5.1...0.5.2) (2022-08-23)


### Bug Fixes

* another fix for log aggregator server side ray head wait ([a3ada23](https://github.com/guidebooks/store/commit/a3ada239e8560cf40fa0affda79279248320362e))

## [0.5.1](https://github.com/guidebooks/store/compare/0.5.0...0.5.1) (2022-08-22)


### Bug Fixes

* improved logic for server-side ray head wait ([4cc34ca](https://github.com/guidebooks/store/commit/4cc34caac3df6d0ca436bae3e2b79d7432801481))

# [0.5.0](https://github.com/guidebooks/store/compare/0.4.8...0.5.0) (2022-08-22)


### Bug Fixes

* server-side log aggregator may try to query ray head before ready ([6cda2ae](https://github.com/guidebooks/store/commit/6cda2ae5ac660d21ddcc84d071bd02323bf52848))


### Features

* allow log aggregator image to be specified by env var ([2ca584d](https://github.com/guidebooks/store/commit/2ca584d8d4cc549012268d8cf853f8a69abd3cea))

## [0.4.8](https://github.com/guidebooks/store/compare/0.4.7...0.4.8) (2022-08-22)


### Bug Fixes

* log aggregator deploy wait failure ([c6c5305](https://github.com/guidebooks/store/commit/c6c5305a75d58cf071bfd6108547a5857aba7f22))

## [0.4.7](https://github.com/guidebooks/store/compare/0.4.6...0.4.7) (2022-08-22)


### Bug Fixes

* log aggregator deploy should wait for it to be ready ([bdc7a5c](https://github.com/guidebooks/store/commit/bdc7a5c2720e98d2211830b490a0bf0e149bff77))

## [0.4.6](https://github.com/guidebooks/store/compare/0.4.5...0.4.6) (2022-08-22)


### Bug Fixes

* disable node-stats.sh collection in log aggregator ([8162626](https://github.com/guidebooks/store/commit/81626264629b62b00909411f023455e26d1f5364))

## [0.4.5](https://github.com/guidebooks/store/compare/0.4.4...0.4.5) (2022-08-22)


### Bug Fixes

* ugh, ~/ -> /root for server-side log aggregator ([7907824](https://github.com/guidebooks/store/commit/79078241df7221fa63c729188a0b9e4733e97250))

## [0.4.4](https://github.com/guidebooks/store/compare/0.4.3...0.4.4) (2022-08-22)


### Bug Fixes

* parse error in ml/ray/run/logs/via-websocat ([728b285](https://github.com/guidebooks/store/commit/728b285fc876b7991e85ba28ea01ad3f8e731c45))

## [0.4.3](https://github.com/guidebooks/store/compare/0.4.2...0.4.3) (2022-08-22)


### Bug Fixes

* use ~/ instead of /home/node in log aggregator ([efd950d](https://github.com/guidebooks/store/commit/efd950d2b959f23a2ee468fade6f0b153366e463))

## [0.4.2](https://github.com/guidebooks/store/compare/0.4.1...0.4.2) (2022-08-22)


### Bug Fixes

* update log aggregator to use /home/node rather than /home/codeflare ([a025f21](https://github.com/guidebooks/store/commit/a025f218bc88723b883f4fa36b0c02cd2c03f32b))

## [0.4.1](https://github.com/guidebooks/store/compare/0.4.0...0.4.1) (2022-08-22)


### Bug Fixes

* add nodes to the log aggregator Role ([23c231d](https://github.com/guidebooks/store/commit/23c231d48f1432345d1fe2ae2b4ffa546b3ecf36))
* util/jobid should inherit JOB_ID from env ([a45f054](https://github.com/guidebooks/store/commit/a45f054207c77e525a11724f527aa6a82c056e70))

# [0.4.0](https://github.com/guidebooks/store/compare/0.3.3...0.4.0) (2022-08-21)


### Bug Fixes

* increase cpu limit for ray head ([303ee6d](https://github.com/guidebooks/store/commit/303ee6d1c3e4b287c3e8bf8e5283c30abb8051b2))


### Features

* remove untested knative guidebooks ([71f0809](https://github.com/guidebooks/store/commit/71f08095c32687806fbbaa4d3e3571f0be1a1aa9))

## [0.3.3](https://github.com/guidebooks/store/compare/0.3.2...0.3.3) (2022-08-19)


### Bug Fixes

* allow splicing in of namespace in ray helm chart ([a22d837](https://github.com/guidebooks/store/commit/a22d837491641b36c361a8222568cf2fe19742df))

## [0.3.2](https://github.com/guidebooks/store/compare/0.3.1...0.3.2) (2022-08-19)


### Bug Fixes

* allow in-cluster operation to specify a default context and namespace name ([2de8f2e](https://github.com/guidebooks/store/commit/2de8f2e70a71262f6d0c240f5240cba5aabb1808))

## [0.3.1](https://github.com/guidebooks/store/compare/0.3.0...0.3.1) (2022-08-19)


### Bug Fixes

* kubernetes/context does not work when running in-cluster ([6d78ad4](https://github.com/guidebooks/store/commit/6d78ad4c4a0b35a3efa4467c4a2c962e09f6fd17))

# [0.3.0](https://github.com/guidebooks/store/compare/0.2.4...0.3.0) (2022-08-19)


### Features

* support for in-kube-cluster start of ray cluster ([8c32df5](https://github.com/guidebooks/store/commit/8c32df55150035e8cb5fe15ad691ee57ae2b4997))

## [0.2.4](https://github.com/guidebooks/store/compare/0.2.3...0.2.4) (2022-08-18)


### Bug Fixes

* add missing kubernetes/mcad/uninstall ([7dc3858](https://github.com/guidebooks/store/commit/7dc385882e53eebf2b437747bb723291ceed3242))
* kubernetes/mcad/install is missing helm3 prereq ([3cff3e3](https://github.com/guidebooks/store/commit/3cff3e33d3b1880f3fe9f72f91151901e541eddd))
* ml/ray/cluster/kubernetes/choose-pod-scheduler incorrectly sets up mcad preinstalled ([4d8d88d](https://github.com/guidebooks/store/commit/4d8d88d05b45195dbbff3791398a1f0e7580f1dd))

## [0.2.3](https://github.com/guidebooks/store/compare/0.2.2...0.2.3) (2022-08-17)


### Bug Fixes

* increase pod readiness wait timeout in ml/ray/start/kubernetes ([c7ea666](https://github.com/guidebooks/store/commit/c7ea6663370215626fd57010f466c0674d10e7f9))

## [0.2.2](https://github.com/guidebooks/store/compare/0.2.1...0.2.2) (2022-08-17)


### Bug Fixes

* ml/ray/start/kubernetes does not wait for ray head to be fully ready ([ec10241](https://github.com/guidebooks/store/commit/ec102419d4b32047325dd9f8335a7f3514414e10))

## [0.2.1](https://github.com/guidebooks/store/compare/0.2.0...0.2.1) (2022-08-17)


### Bug Fixes

* a few missing ${KUBE_CONTEXT_ARG} in mcad and the coscheduler validators ([083d88c](https://github.com/guidebooks/store/commit/083d88c0176d1ac8c1f916264327854ef1eba87a))
* MCAD without coscheduler still installs the coscheduler ([ad5cfa7](https://github.com/guidebooks/store/commit/ad5cfa717b37f94bbfa9cddd0ffb4937d92cd84d))

# [0.2.0](https://github.com/guidebooks/store/compare/0.1.1...0.2.0) (2022-08-17)


### Features

* allow mcad resource requirements to be dialed down when running CI ([ceb0dd1](https://github.com/guidebooks/store/commit/ceb0dd1d9a096578a4f1467a87d3b2584a842e6a))

## [0.1.1](https://github.com/guidebooks/store/compare/0.1.0...0.1.1) (2022-08-17)


### Bug Fixes

* regression, ray operator is no longer namespaced ([7bf4de4](https://github.com/guidebooks/store/commit/7bf4de4886979e39a8c3f3f39e40ff57c251fd7c))

# [0.1.0](https://github.com/guidebooks/store/compare/0.0.5...0.1.0) (2022-08-17)


### Bug Fixes

* another regression fix for helm chart ([685864b](https://github.com/guidebooks/store/commit/685864ba595780ce33f0f650235195f282c7a590))


### Features

* pin a branch for the default ray helm chart ([7a4900d](https://github.com/guidebooks/store/commit/7a4900dd4bf43c4fe45d903dc650266ab419b2d1))

## [0.0.5](https://github.com/guidebooks/store/compare/0.0.4...0.0.5) (2022-08-17)


### Bug Fixes

* typo from prior commit in helm chart ([8b175e7](https://github.com/guidebooks/store/commit/8b175e75f13ce9ab5ddc0fe11cd3c2cbc3bcc701))

## [0.0.4](https://github.com/guidebooks/store/compare/0.0.3...0.0.4) (2022-08-17)


### Bug Fixes

* back out conditional installation of ray in chart ([280d8fb](https://github.com/guidebooks/store/commit/280d8fbda64b75370e1888809dc3d740b2ce82ee))

## [0.0.3](https://github.com/guidebooks/store/compare/0.0.2...0.0.3) (2022-08-17)


### Bug Fixes

* ml/ray/start/kubernetes helm chart does not set head cpu based on profile ([c2a1507](https://github.com/guidebooks/store/commit/c2a1507910ab05d079327d31d09c5b9fab80d701))

## [0.0.2](https://github.com/guidebooks/store/compare/0.0.1...0.0.2) (2022-08-16)


### Bug Fixes

* regression, fractional cpus were ignored in ml/lray/start/kubernetes ([612cc5b](https://github.com/guidebooks/store/commit/612cc5bf08182ff3f47b338b1eaec2b4fefca520))