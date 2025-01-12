/// Renderer used for rendering components
public struct Renderer: ~Copyable {
  var tokens: TokensStorage

  init(_ tokens: consuming sending TokensStorage) {
    self.tokens = tokens
  }

  /// Render a simple statement
  ///
  /// e.g.: @import "style.css"
  public consuming func statement(
    _ identifier: consuming String,
    value: consuming String,
    use atSymbol: consuming Bool = false
  ) {
    var renderer = BlockRenderer(tokens)
    renderer.statement(identifier, value: value, use: atSymbol)
  }

  /// Render a block statement
  ///
  /// e.g.: #id {}
  public consuming func block(
    _ identifier: consuming String,
    value: consuming String? = nil,
    use atSymbol: consuming Bool = false,
    operation: (inout BlockRenderer) -> Void
  ) {
    var renderer = BlockRenderer(tokens)
    renderer.block(identifier, value: value, use: atSymbol, operation: operation)
  }

  public consuming func block<S: Selector>(
    _ selector: consuming S,
    operation: (inout BlockRenderer) -> Void
  ) {
    var renderer = BlockRenderer(tokens)
    renderer.block(selector, operation: operation)
  }

  public consuming func declaration(
    _ identifier: consuming String,
    value: consuming String
  ) {
    var renderer = BlockRenderer(tokens)
    renderer.declaration(identifier, value: value)
  }

  public consuming func selector() -> SelectorRenderer {
    SelectorRenderer(tokens)
  }
}

public extension Renderer {
  struct BlockRenderer: ~Copyable {
    var tokens: TokensStorage

    init(_ tokens: consuming sending TokensStorage) {
      self.tokens = tokens
    }

    public mutating func declaration(
      _ identifier: consuming String,
      value: consuming String
    ) {
      tokens.append(contentsOf: identifier.utf8)
      tokens.append(0x3A) // :
      tokens.append(0x20) // spacer
      tokens.append(contentsOf: value.utf8)
      tokens.append(0x3B) // ;
    }

    public mutating func statement(
      _ identifier: consuming String,
      value: consuming String,
      use atSymbol: consuming Bool = false
    ) {
      if atSymbol {
        tokens.append(0x40) // `@`
      }
      tokens.append(contentsOf: identifier.utf8)
      tokens.append(0x20) // <spacer>
      tokens.append(contentsOf: value.utf8)
      tokens.append(0x3B) // `;`
    }

    /// Render a block statement
    ///
    /// e.g.: #id {}
    public mutating func block(
      _ identifier: consuming String,
      value: consuming String? = nil,
      use atSymbol: consuming Bool = false,
      operation: (inout BlockRenderer) -> Void
    ) {
      if atSymbol {
        tokens.append(0x40) // `@`
      }

      tokens.append(contentsOf: identifier.utf8)
      tokens.append(0x20) // <spacer>
      if let value {
        tokens.append(contentsOf: value.utf8)
        tokens.append(0x20) // <spacer>
      }

      tokens.append(0x7B) // {
      operation(&self)
      tokens.append(0x7D) // }
    }

    public mutating func block<S: Selector>(
      _ selector: consuming S,
      operation: (inout BlockRenderer) -> Void
    ) {
      S._render(selector, into: Renderer(tokens))
      tokens.append(0x20) // <spacer>
      tokens.append(0x7B) // {
      operation(&self)
      tokens.append(0x7D) // }
    }
  }
}

public extension Renderer {
  struct SelectorRenderer: ~Copyable {
    var tokens: TokensStorage

    init(_ tokens: consuming sending TokensStorage) {
      self.tokens = tokens
    }

    public mutating func addSpace(canOmit _: Bool = true) {
      tokens.append(0x20)
    }

    public mutating func add(_ bytes: UInt8...) {
      tokens.append(contentsOf: bytes)
    }

    public mutating func add<S: Sequence<UInt8>>(_ sequence: consuming S) {
      tokens.append(contentsOf: sequence)
    }

    public mutating func add(_ string: consuming String) {
      tokens.append(contentsOf: string.utf8)
    }

    public mutating func join<S0: Selector, S1: Selector>(
      _ first: consuming S0,
      _ second: consuming S1,
      separator: UInt8? = nil
    ) {
      S0._render(first, into: Renderer(tokens))
      if let separator {
        if separator != 0x20 { tokens.append(0x20) }
        tokens.append(separator)
        if separator != 0x20 { tokens.append(0x20) }
      }
      S1._render(second, into: Renderer(tokens))
    }
  }
}

// public protocol BackingRenderer {
//   mutating func append(_ byte: consuming UInt8)
//   mutating func append<S: Sequence<UInt8>>(contentsOf s: consuming S)
// }

extension Renderer {
  struct TokensStorage: Sendable {
    final class Box: @unchecked Sendable {
      var bytes = [UInt8]()
    }

    private var _bytes = Box()

    mutating func append(_ byte: consuming UInt8) {
      _bytes.bytes.append(byte)
    }

    mutating func append<S: Sequence<UInt8>>(contentsOf sequence: consuming S) {
      _bytes.bytes.append(contentsOf: sequence)
    }

    consuming func collect() -> String {
      return String(decoding: _bytes.bytes, as: UTF8.self)
    }
  }
}