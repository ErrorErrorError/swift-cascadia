public protocol StyleSheetWriter: Sendable {
  associatedtype Output

  mutating func write(_ byte: consuming UInt8)
  mutating func write<S: Sequence<UInt8>>(contentsOf sequence: consuming S)

  consuming func finish() -> Output
}

extension StyleSheetWriter where Output == Void {
  consuming func finish() -> Void { () }
}

/// Renderer used for rendering components
public struct Renderer<Writer: StyleSheetWriter>: ~Copyable {
  var writer: Writer

  init(_ writer: consuming sending Writer) {
    self.writer = writer
  }

  /// Render a simple statement
  ///
  /// e.g.: @import "style.css"
  public consuming func statement(
    _ identifier: consuming String,
    value: consuming String,
    use atSymbol: consuming Bool = false
  ) {
    var renderer = BlockRenderer(writer)
    renderer.statement(identifier, value: value, use: atSymbol)
  }

  /// Render a block component with identifier
  ///
  /// e.g.: #id {}
  public consuming func block(
    _ identifier: consuming String,
    value: consuming String? = nil,
    use atSymbol: consuming Bool = false,
    operation: (inout BlockRenderer) -> Void
  ) {
    var renderer = BlockRenderer(writer)
    renderer.block(identifier, value: value, use: atSymbol, operation: operation)
  }

  /// Render a block component with selector
  /// 
  /// e.g.: * {}
  public consuming func block<S: Selector>(
    _ selector: consuming S,
    operation: (inout BlockRenderer) -> Void
  ) {
    var renderer = BlockRenderer(writer)
    renderer.block(selector, operation: operation)
  }

  /// Render a declaration using a property identifier and value
  /// - Parameters:
  ///   - identifier: The property's identifier name
  ///   - value: The  value for the specified property
  public consuming func declaration(
    _ identifier: consuming String,
    value: consuming String
  ) {
    var renderer = BlockRenderer(writer)
    renderer.declaration(identifier, value: value)
  }

  /// Render a selector
  /// - Returns: The renderer used to build a selector
  public consuming func selector() -> SelectorRenderer {
    SelectorRenderer(writer)
  }
}

public extension Renderer {
  struct BlockRenderer: ~Copyable {
    var writer: Writer

    init(_ writer: consuming sending Writer) {
      self.writer = writer
    }

    public mutating func declaration(
      _ identifier: consuming String,
      value: consuming String
    ) {
      writer.write(contentsOf: identifier.utf8)
      writer.write(0x3A) // :
      writer.write(0x20) // spacer
      writer.write(contentsOf: value.utf8)
      writer.write(0x3B) // ;
    }

    public mutating func statement(
      _ identifier: consuming String,
      value: consuming String,
      use atSymbol: consuming Bool = false
    ) {
      if atSymbol {
        writer.write(0x40) // `@`
      }
      writer.write(contentsOf: identifier.utf8)
      writer.write(0x20) // <spacer>
      writer.write(contentsOf: value.utf8)
      writer.write(0x3B) // `;`
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
        writer.write(0x40) // `@`
      }

      writer.write(contentsOf: identifier.utf8)
      writer.write(0x20) // <spacer>
      if let value {
        writer.write(contentsOf: value.utf8)
        writer.write(0x20) // <spacer>
      }

      writer.write(0x7B) // {
      operation(&self)
      writer.write(0x7D) // }
    }

    public mutating func block<S: Selector>(
      _ selector: consuming S,
      operation: (inout BlockRenderer) -> Void
    ) {
      S._render(selector, into: Renderer(writer))
      writer.write(0x20) // <spacer>
      writer.write(0x7B) // {
      operation(&self)
      writer.write(0x7D) // }
    }
  }
}

public extension Renderer {
  struct SelectorRenderer: ~Copyable {
    var writer: Writer

    init(_ writer: consuming sending Writer) {
      self.writer = writer
    }

    public mutating func addSpace(canOmit _: Bool = true) {
      writer.write(0x20)
    }

    public mutating func add(_ bytes: UInt8...) {
      writer.write(contentsOf: bytes)
    }

    public mutating func add<S: Sequence<UInt8>>(_ sequence: consuming S) {
      writer.write(contentsOf: sequence)
    }

    public mutating func add(_ string: consuming String) {
      writer.write(contentsOf: string.utf8)
    }

    public mutating func join<S0: Selector, S1: Selector>(
      _ first: consuming S0,
      _ second: consuming S1,
      separator: UInt8? = nil
    ) {
      S0._render(first, into: Renderer(writer))
      if let separator {
        if separator != 0x20 { writer.write(0x20) }
        writer.write(separator)
        if separator != 0x20 { writer.write(0x20) }
      }
      S1._render(second, into: Renderer(writer))
    }
  }
}

public struct CSSTextWriter: Sendable, StyleSheetWriter {
  @usableFromInline
  init() {}

  final class Box: @unchecked Sendable {
    var bytes = [UInt8]()
  }

  private var _bytes = Box()

  public mutating func write(_ byte: consuming UInt8) {
    _bytes.bytes.append(byte)
  }

  public mutating func write<S: Sequence<UInt8>>(contentsOf sequence: consuming S) {
    _bytes.bytes.append(contentsOf: sequence)
  }

  public consuming func finish() -> String {
    return String(decoding: _bytes.bytes, as: UTF8.self)
  }
}
