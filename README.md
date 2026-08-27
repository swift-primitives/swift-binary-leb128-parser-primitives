# Binary LEB128 Parser

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

`Parser.`Protocol`` adapters for LEB128 (Little-Endian Base 128) variable-length integers — `Binary.LEB128.Unsigned<T>` and `Binary.LEB128.Signed<T>`.

This is an **integration package** (recipient-then-provider): it confers `Parser.`Protocol`` (from [`swift-parser`](https://github.com/swift-molecules/swift-parser)) onto the `Binary.LEB128` types (from [`swift-binary-leb128`](https://github.com/swift-molecules/swift-binary-leb128)). The parser structs are thin adapters; the actual decode arithmetic is the shared `Binary.LEB128.Decode` core in `swift-binary-leb128`.

```swift
import Binary_LEB128_Parser

let parser = Binary.LEB128.Unsigned<UInt64>()
var input: ArraySlice<Byte> = [0xE5, 0x8E, 0x26][...]
let value = try parser.parse(&input)   // 624485
```

## Architecture

- **Owner-independent leaf.** Depends only on `swift-parser` + `swift-binary-leb128` (+ `swift-byte`) — NOT on `swift-binary-parser`. So there is no package cycle: the generic binary parser and this integration both compose downward onto the LEB128 mechanism.
- **One decode source of truth.** `parse(_:)` delegates to `Binary.LEB128.Decode`, the single shared decode core that the binary `Machine`/`Borrowed` interpreters also use. Strict over-long contract (rejects non-minimal encodings, per WebAssembly).

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
