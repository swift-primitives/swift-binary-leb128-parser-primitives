# Binary LEB128 Parser Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

`Parser.`Protocol`` adapters for LEB128 (Little-Endian Base 128) variable-length integers — `Binary.LEB128.Unsigned<T>` and `Binary.LEB128.Signed<T>`.

This is an **integration package** ([MOD-014], recipient-then-provider [PKG-NAME-016]): it confers `Parser.`Protocol`` (from [`swift-parser-primitives`](https://github.com/swift-primitives/swift-parser-primitives)) onto the `Binary.LEB128` types (from [`swift-binary-leb128-primitives`](https://github.com/swift-primitives/swift-binary-leb128-primitives)). The parser structs are thin adapters; the actual decode arithmetic is the shared `Binary.LEB128.Decode` core in `swift-binary-leb128-primitives`.

```swift
import Binary_LEB128_Parser_Primitives

let parser = Binary.LEB128.Unsigned<UInt64>()
var input: ArraySlice<Byte> = [0xE5, 0x8E, 0x26][...]
let value = try parser.parse(&input)   // 624485
```

## Architecture

- **Owner-independent leaf.** Depends only on `swift-parser-primitives` + `swift-binary-leb128-primitives` (+ `swift-byte-primitives`) — NOT on `swift-binary-parser-primitives`. So there is no package cycle ([MOD-032]): the generic binary parser and this integration both compose downward onto the LEB128 mechanism.
- **One decode source of truth.** `parse(_:)` delegates to `Binary.LEB128.Decode`, the single shared decode core that the binary `Machine`/`Borrowed` interpreters also use. Strict over-long contract (rejects non-minimal encodings, per WebAssembly).

## Provenance

Extracted from `swift-binary-parser-primitives` on 2026-05-30 (LEB128 decomposition, Phase 4) per [`swift-institute/Research/binary-primitives-package-decomposition.md`](https://github.com/swift-institute) and the `[MOD-014]` extract-integration-by-default discipline.
