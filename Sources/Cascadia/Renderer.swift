/// The renderer used for rendering components
public struct Renderer: ~Copyable {
  let bytes: ByteBuffer

  /// Render a simple statement
  ///
  /// e.g.: @import "style.css"
  public consuming func statement(
    _ identifier: consuming String,
    value: consuming String,
    use atSymbol: consuming Bool = false
  ) {
    if atSymbol {
      bytes.append(0x40) // `@`
    }
    bytes.append(contentsOf: identifier.utf8)
    bytes.append(0x20) // <spacer>
    bytes.append(contentsOf: value.utf8)
    bytes.append(0x3B) // `;`
  }

  /// Render a block statement
  ///
  /// e.g.: #id {}
  public consuming func block(
    _ identifier: consuming String,
    value: consuming String? = nil,
    use atSymbol: consuming Bool = false
  ) -> BlockRenderer {
    if atSymbol {
      bytes.append(0x40) // `@`
    }

    bytes.append(contentsOf: identifier.utf8)
    bytes.append(0x20) // <spacer>
    if let value {
      bytes.append(contentsOf: value.utf8)
      bytes.append(0x20) // <spacer>
    }

    bytes.append(0x7B) // {
    bytes.pendingClosures += 1
    return BlockRenderer(bytes: bytes)
  }

  public consuming func declaration(
    _ identifier: consuming String,
    value: consuming String
  ) {
    bytes.append(contentsOf: identifier.utf8)
    bytes.append(0x3A) // :
    bytes.append(0x20) // spacer
    bytes.append(contentsOf: value.utf8)
    bytes.append(0x3B) // ;
  }

  public consuming func selector() -> SelectorRenderer {
    SelectorRenderer(bytes: bytes)
  }

  // consuming func stylesheet() -> Self {
  //   Renderer(bytes: bytes)
  // }
}

public extension Renderer {
  struct BlockRenderer: ~Copyable {
    let bytes: ByteBuffer

    public mutating func declaration(
      _ identifier: consuming String,
      value: consuming String
    ) {
      Renderer(bytes: bytes)
        .declaration(identifier, value: value)
    }

    public mutating func statement(
      _ identifier: consuming String,
      value: consuming String,
      use atSymbol: consuming Bool = false
    ) {
      return Renderer(bytes: bytes)
        .statement(identifier, value: value, use: atSymbol)
    }

    /// Render a block statement
    ///
    /// e.g.: #id {}
    public mutating func block(
      _ identifier: consuming String,
      value: consuming String? = nil,
      use atSymbol: consuming Bool = false
    ) -> BlockRenderer {
      return Renderer(bytes: bytes)
        .block(identifier, value: value, use: atSymbol)
    }

    public func nested() -> Renderer {
      Renderer(bytes: bytes)
    }
  }
}

public extension Renderer {
  struct SelectorRenderer: ~Copyable {
    let bytes: ByteBuffer

    public mutating func addSpace(canOmit _: Bool = true) {
      bytes.append(0x20)
    }

    public mutating func add(_ bytes: UInt8...) {
      self.bytes.append(contentsOf: bytes)
    }

    public mutating func add<S: Sequence<UInt8>>(_ sequence: consuming S) {
      bytes.append(contentsOf: sequence)
    }

    public mutating func add(_ string: consuming String) {
      bytes.append(contentsOf: string.utf8)
    }

    public consuming func join<S0: Selector, S1: Selector>(
      _ first: consuming S0,
      _ second: consuming S1,
      separator: UInt8? = nil
    ) {
      S0.render(first, into: Self(bytes: bytes))
      if let separator {
        if separator != 0x20 { bytes.append(0x20) }
        bytes.append(separator)
        if separator != 0x20 { bytes.append(0x20) }
      }
      S1.render(second, into: Self(bytes: bytes))
    }
  }
}

extension Renderer {
  final class ByteBuffer {
    var bytes = [UInt8]()
    var pendingClosures = 0

    func append(_ byte: consuming UInt8) {
      bytes.append(byte)
    }

    func append<S: Sequence<UInt8>>(contentsOf s: consuming S) {
      bytes.append(contentsOf: s)
    }

    consuming func collect() -> String {
      while pendingClosures > 0 {
        bytes.append(0x7D)  // }
        pendingClosures -= 1
      }
      return String(decoding: bytes, as: UTF8.self)
    }
  }
}