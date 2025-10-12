# Changelog

## [2.3.0](https://github.com/stephansama/fzf-nerdfont.nvim/compare/v2.2.1...v2.3.0) (2025-10-12)


### Features

* added delete glyphname function to plugin ([#18](https://github.com/stephansama/fzf-nerdfont.nvim/issues/18)) ([07d6581](https://github.com/stephansama/fzf-nerdfont.nvim/commit/07d658161c1a4031e6babe898a28c9f4e6471011))

## [2.2.1](https://github.com/stephansama/fzf-nerdfont.nvim/compare/v2.2.0...v2.2.1) (2025-10-10)


### Bug Fixes

* improved `Makefile` ([#14](https://github.com/stephansama/fzf-nerdfont.nvim/issues/14)) ([6cadbfa](https://github.com/stephansama/fzf-nerdfont.nvim/commit/6cadbfa4b3e24b5d2df3f234481c2181998c829e))

## [2.2.0](https://github.com/stephansama/fzf-nerdfont.nvim/compare/v2.1.0...v2.2.0) (2025-10-10)


### Features

* **ci:** add optional `pre-commit` for contributors ([#10](https://github.com/stephansama/fzf-nerdfont.nvim/issues/10)) ([80f5c27](https://github.com/stephansama/fzf-nerdfont.nvim/commit/80f5c27a3cf5992daa6cd2717666703bf2440407))

## [2.1.0](https://github.com/stephansama/fzf-nerdfont.nvim/compare/v2.0.0...v2.1.0) (2025-10-10)


### Features

* use selene for linting ([cb641d5](https://github.com/stephansama/fzf-nerdfont.nvim/commit/cb641d56400536c7bdb832569aaff8078fc3f23a))

## [2.0.0](https://github.com/stephansama/fzf-nerdfont.nvim/compare/v1.0.1...v2.0.0) (2025-10-10)


### ⚠ BREAKING CHANGES

* **glyphnames:** install glyphnames to `stdpath('data')` instead

### Features

* added join_path function ([aa4fadf](https://github.com/stephansama/fzf-nerdfont.nvim/commit/aa4fadfda8bc5a2853516a1e56604bf90d0f7856))
* removed error in favor of just setting up config for users ([6cc3266](https://github.com/stephansama/fzf-nerdfont.nvim/commit/6cc32661e1c89ed04ff4867f4a685083c238f5e7))


### Bug Fixes

* **glyphnames:** install glyphnames to `stdpath('data')` instead ([f43138f](https://github.com/stephansama/fzf-nerdfont.nvim/commit/f43138f3603c01c068e25196899a1518c51d7c05))
* sanitized `minimal_init.lua` and added extra instructions ([02edc83](https://github.com/stephansama/fzf-nerdfont.nvim/commit/02edc8374a89e3638f4b5ff2e3c489b52821ef59))
* **scripts:** restored `tr` usage ([b0fa34b](https://github.com/stephansama/fzf-nerdfont.nvim/commit/b0fa34b11dd08f06e62e3317b6be4a0e910c4fe0))
* **setup:** improved quality of `setup.sh` script ([1a03337](https://github.com/stephansama/fzf-nerdfont.nvim/commit/1a03337fcd7fa7411444f06a4f7753be70d1e929))
* use `error()` when appropriate, more annotations ([97bc209](https://github.com/stephansama/fzf-nerdfont.nvim/commit/97bc209c74c0b47e05d2b136e2738ac5e646d528))

## [1.0.1](https://github.com/stephansama/fzf-nerdfont.nvim/compare/v1.0.0...v1.0.1) (2025-10-09)


### Bug Fixes

* use correct annotation in `util/log.lua` ([cc6b834](https://github.com/stephansama/fzf-nerdfont.nvim/commit/cc6b834c0a7976aeaa865d92e267548e8181a584))

## 1.0.0 (2025-10-09)

### ⚠ BREAKING CHANGES

* use target buffer for inserting text, state fix
* complete code restructuring

### Features

* added FAQ section ([10f6c36](https://github.com/stephansama/fzf-nerdfont.nvim/commit/10f6c36890f936be646a14b1fae4f0be2671a0cc))
* added type to global ([c632d24](https://github.com/stephansama/fzf-nerdfont.nvim/commit/c632d249b7377e97a0aa06b28312c0996155dcbe))
* removed state check ([6131ec6](https://github.com/stephansama/fzf-nerdfont.nvim/commit/6131ec627e861f302db7bc5c068f7073cdef17fa))
* restored `init.lua`, cleaned useless functions ([544d4d0](https://github.com/stephansama/fzf-nerdfont.nvim/commit/544d4d059abc0950a6edd780f853ff2a587ce36c))
* updated documentation. readded _G for the sake of the unit tests ([9be0e9b](https://github.com/stephansama/fzf-nerdfont.nvim/commit/9be0e9b75fad5939c518d512489eb070296a8cbb))

### Bug Fixes

* **main:** target window/buffer was the picker itself ([577e40a](https://github.com/stephansama/fzf-nerdfont.nvim/commit/577e40a424caae6a96eaf2ff252c51e8e6e5fa13))
* oversights repaired ([f9491a4](https://github.com/stephansama/fzf-nerdfont.nvim/commit/f9491a4ec462592d40a962511434fc2054d95956))
* use target buffer for inserting text, state fix ([a8a1481](https://github.com/stephansama/fzf-nerdfont.nvim/commit/a8a1481bad6d1bf7dc6d5d59d8439843ff1f75a8))

### Code Refactoring

* complete code restructuring ([c5a5318](https://github.com/stephansama/fzf-nerdfont.nvim/commit/c5a5318012cfd5c248cf0e80179200d7b3ddaf7d))
