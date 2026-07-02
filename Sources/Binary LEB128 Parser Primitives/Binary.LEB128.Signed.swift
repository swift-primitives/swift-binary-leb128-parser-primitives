// Binary.LEB128.Signed.swift
// swift-binary-primitives
//
// Parser for signed LEB128 encoded integers.

extension Binary.LEB128 {
    /// Parser for signed LEB128 encoded integers.
    ///
    /// Decodes a variable-length signed integer where:
    /// - Each byte contributes 7 bits of value
    /// - MSB=1 means more bytes follow
    /// - MSB=0 marks the final byte
    /// - Bit 6 of the final byte is sign-extended
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Parse negative Int64 from LEB128
    /// let parser = Binary.LEB128.Signed<Int64>()
    /// var input: ArraySlice<Byte> = [0x7F][...]  // -1
    /// let value = try parser.parse(&input)
    /// // value == -1
    /// ```
    ///
    /// ## Sign Extension
    ///
    /// The sign bit (bit 6) of the final byte determines the sign:
    /// - If set (1), the remaining high bits are filled with 1s
    /// - If clear (0), the remaining high bits are filled with 0s
    public struct Signed<T: SignedInteger & FixedWidthInteger>: Sendable {
        /// Creates a signed LEB128 parser.
        @inlinable
        public init() {}
    }
}

// MARK: - Parser.Parser

extension Binary.LEB128.Signed: Parser.`Protocol` {
    /// Parsing consumes from a byte slice.
    public typealias Input = ArraySlice<Byte>
    /// Parsing produces the target signed integer type.
    public typealias Output = T
    /// Parsing throws ``Binary/LEB128/Error``.
    public typealias Failure = Binary.LEB128.Error
    /// The composed-parser body; this parser is a leaf with no sub-parsers, so it is `Never`.
    public typealias Body = Never

    /// Parses a signed LEB128 integer from the front of the input, sign-extending the final byte.
    ///
    /// - Parameter input: The byte slice to consume from; parsed bytes are removed.
    /// - Returns: The decoded signed integer.
    /// - Throws: `Binary.LEB128.Error.unterminated` if the input ends before the
    ///   final byte, or `.overflow` if the value exceeds `T`'s bit width.
    @inlinable
    public func parse(_ input: inout Input) throws(Failure) -> T {
        var result: T = 0
        var shift: Int = 0
        while true {
            guard let byte = input.first else {
                throw .unterminated
            }
            input.removeFirst()
            // Delegate to the shared decode core (Binary LEB128 Decode Primitives);
            // the signed step self-contains two's-complement sign extension.
            if try Binary.LEB128.Decode.signed(byte: byte.underlying, into: &result, shift: &shift) {
                return result
            }
        }
    }
}
