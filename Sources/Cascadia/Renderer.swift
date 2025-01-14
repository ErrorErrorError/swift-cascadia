public protocol CSSRendering {
  /// The output type when ``finish()`` is called.
  associatedtype Output

  /// Write a single byte.
  /// - Parameter byte: The byte to write
  mutating func write(_ byte: consuming UInt8)

  /// Write a sequence of bytes
  /// - Parameter sequence: The sequence of bytes
  mutating func write<S: Sequence<UInt8>>(contentsOf sequence: consuming S)

  /// Finish writing
  consuming func finish() -> Output
}

extension CSSRendering {
  /// Default implementation of writing a sequence of UInt8
  public mutating func write<S: Sequence<UInt8>>(contentsOf sequence: consuming S) {
    for byte in sequence {
      write(byte)
    }
  }

  /// Default implementation of finishing writing a stylesheet.
  public consuming func finish() where Output == Void {}
}

/// Renderering functions
@_spi(Renderer)
extension CSSRendering {
  public mutating func declaration(
    _ identifier: consuming String,
    value: consuming String,
    important: Bool = false
  ) {
    write(contentsOf: identifier.utf8)
    write(0x3A) // :
    write(0x20) // spacer
    write(contentsOf: value.utf8)
    if (important) {
      write(0x20) // spacer
      write(0x21) // !
      write(contentsOf: "important".utf8)
    }
    write(0x3B) // ;
  }

  public mutating func statement(
    _ identifier: consuming String,
    value: consuming String,
    use atSymbol: consuming Bool = false
  ) {
    if atSymbol{ 
      write(0x40) // `@`
    }
    write(contentsOf: identifier.utf8)
    write(0x20) // <spacer>
    write(contentsOf: value.utf8)
    write(0x3B) // `;`
  }

  /// Renders a block
  ///
  /// <at-keyword-token>?<identifier> <value>? {}
  public mutating func block(
    _ identifier: consuming String,
    value: consuming String? = nil,
    use atSymbol: consuming Bool = false,
    operation: (inout Self) -> Void
  ) {
    if atSymbol {
      write(0x40) // `@`
    }
    write(contentsOf: identifier.utf8)
    write(0x20) // <spacer>
    if let value {
      write(contentsOf: value.utf8)
      write(0x20) // <spacer>
    }
    write(0x7B) // {
    operation(&self)
    write(0x7D) // }
  }

  /// Renders a block with the given selector
  public mutating func block<S: Selector>(
    _ selector: consuming S,
    operation: (inout Self) -> Void
  ) {
    S._render(selector, into: &self)
    write(0x20) // <spacer>
    write(0x7B) // {
    operation(&self)
    write(0x7D) // }
  }

  public mutating func selector(operation: (inout _SelectorRenderer) -> Void) {
    var renderer = _SelectorRenderer()
    operation(&renderer)
    self.write(contentsOf: renderer.bytes)
  }
}

@_spi(Renderer)
public struct _SelectorRenderer: CSSRendering {
  var bytes: [UInt8] = []

  public mutating func write(_ byte: UInt8) {
    self.bytes.append(byte)
  }

  public mutating func write<S: Sequence<UInt8>>(contentsOf sequence: S) {
    self.bytes.append(contentsOf: sequence)
  }

  public mutating func join<S0: Selector, S1: Selector>(_ s0: S0, _ s1: S1, separator: UInt8? = nil) {
    S0._render(s0, into: &self)
    if let separator {
      if separator != 0x20 { write(0x20) }
      write(separator)
      if separator != 0x20 { write(0x20) } 
    }
    S1._render(s1, into: &self)
  }
}

@_spi(Renderer)
public struct _CSSTextRenderer: Sendable, CSSRendering {
  public init() {}

  private var bytes: [UInt8] = []

  public mutating func write(_ byte: consuming UInt8) {
    bytes.append(byte)
  }

  public mutating func write<S: Sequence<UInt8>>(contentsOf sequence: consuming S) {
    bytes.append(contentsOf: sequence)
  }

  public consuming func finish() -> String {
    return String(decoding: bytes, as: UTF8.self)
  }
}
