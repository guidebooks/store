

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