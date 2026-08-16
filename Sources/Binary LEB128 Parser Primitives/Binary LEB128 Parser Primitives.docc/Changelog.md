# Changelog

All notable changes to `swift-binary-leb128-parser-primitives` are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial extraction from `swift-binary-parser-primitives`'s `Binary LEB128 Parser Primitives` target (2026-05-30, LEB128 decomposition Phase 4).
- `Binary.LEB128.Unsigned<T>` / `Binary.LEB128.Signed<T>` conforming to `Parser.`Protocol`` — thin adapters that delegate to the shared `Binary.LEB128.Decode` core in `swift-binary-leb128-primitives`.

### Notes

- `[MOD-014]` integration package: owner-independent leaf depending on `swift-parser-primitives` + `swift-binary-leb128-primitives` (+ `swift-byte-primitives`), with no dependency back on `swift-binary-parser-primitives` (so no `[MOD-032]` package cycle).
- The strict over-long overflow contract is inherited from the shared decode core.
