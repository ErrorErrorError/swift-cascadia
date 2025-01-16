public protocol CSSStreamWriter {
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

public extension CSSStreamWriter {
  /// Default implementation of writing a sequence of UInt8
  mutating func write<S: Sequence<UInt8>>(contentsOf sequence: consuming S) {
    for byte in sequence {
      write(byte)
    }
  }

  /// Default implementation of finishing writing a stylesheet.
  consuming func finish() where Output == Void {}
}

public struct Renderer<Writer: CSSStreamWriter> {
  let writer: UnsafeMutablePointer<Writer>
  let config: StyleSheetConfiguration

  var context = Context()

  init(
    _ writer: UnsafeMutablePointer<Writer>, 
    config: StyleSheetConfiguration
  ) {
    self.writer = writer
    self.config = config
  }
}

/// Render functions
@_spi(Renderer)
extension Renderer {
  public mutating func declaration(
    _ identifier: consuming String,
    value: consuming String,
    important: Bool = false
  ) {
    write(withIndent: true)
    write(contentsOf: identifier.utf8)
    write(0x3A) // :
    write(0x20) // spacer (optional)
    write(contentsOf: value.utf8)
    if important {
      write(0x20) // spacer (optional)
      write(0x21) // !
      write(contentsOf: "important".utf8)
    }
    write(0x3B) // ;
  }

  public mutating func statement(
    atSymbol: Bool = false,
    _ identifier: consuming String,
    value: consuming String
  ) {
    write(withIndent: true)
    if atSymbol {
      writer.pointee.write(0x40) // `@`
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
    atSymbol: Bool = false,
    _ identifier: consuming String,
    value: consuming String? = nil,
    operation: (inout Self) -> Void
  ) {
    write(withIndent: true)
    if atSymbol {
      self.writer.pointee.write(0x40) // `@`
    }
    write(contentsOf: identifier.utf8)
    if let value {
      write(0x20) // <spacer>
      write(contentsOf: value.utf8)
    }
    write(0x20) // <spacer> (remove if minify)
    write(0x7B) // {
    let hasChanges = nested(operation)
    write(0x7D, withIndent: hasChanges) // }
  }

  /// Renders a block with the given selector
  public mutating func block<S: Selector>(
    _ selector: consuming S,
    operation: (inout Self) -> Void
  ) {
    write(withIndent: true)
    S._render(selector, into: &self)
    write(0x20) // <spacer> (remove if minify)
    write(0x7B) // {
    let hasChanges = nested(operation)
    write(0x7D, withIndent: hasChanges) // }
  }

  public mutating func selector(operation: (inout _SelectorRenderer<Writer>) -> Void) {
    withUnsafeMutablePointer(to: &self) { renderer in
      var renderer = _SelectorRenderer(renderer: renderer)
      operation(&renderer)
    }
  }

  private mutating func nested(_ operation: (inout Self) -> Void) -> Bool {
    context.depth += 1
    context.blockHasContent = false
    // when the block returns, revert back to parent block having contents
    defer { context.depth -= 1 }
    defer { context.blockHasContent = true }
    operation(&self)
    return context.blockHasContent
  }

  private mutating func write(
    _ bytes: UInt8..., 
    withIndent includeIndent: Bool = false
  ) {
    self.write(contentsOf: bytes, withIndent: includeIndent)
  }

  private mutating func write<S: Sequence<UInt8>>(
    contentsOf bytes: S,
    withIndent includeIndent: Bool = false
  ) {
    if includeIndent {
      if config.indent != .minify, context.blockHasContent || context.depth > 0 {
        writer.pointee.write(0x0A) // line-feed
      }

      switch config.indent {
      case let .tabs(count):
        writer.pointee.write(contentsOf: repeatElement(0x09, count: Int(count) * Int(context.depth))) // `  `
      case let .spaces(count):
        writer.pointee.write(contentsOf: repeatElement(0x20, count: Int(count) * Int(context.depth))) // ` `
      case .minify: break
      }
    }

    writer.pointee.write(contentsOf: bytes)
    context.blockHasContent = true
  }

  private mutating func optionalWhitespace() {
    switch config.indent {
    case .minify: break
    default: writer.pointee.write(0x20)
    }
  }

  public struct Context: Sendable {
    var depth = 0
    var blockHasContent = false
  }
}

/// A renderer for selector.
public struct _SelectorRenderer<Writer: CSSStreamWriter>: CSSStreamWriter {
  let renderer: UnsafeMutablePointer<Renderer<Writer>>
}

@_spi(Renderer)
extension _SelectorRenderer {
  public mutating func write(_ byte: UInt8) {
    renderer.pointee.writer.pointee.write(byte)
  }

  public mutating func write<S: Sequence<UInt8>>(contentsOf sequence: S) {
    renderer.pointee.writer.pointee.write(contentsOf: sequence)
  }

  public mutating func join<S0: Selector, S1: Selector>(_ s0: S0, _ s1: S1, separator: UInt8? = nil) {
    S0._render(s0, into: &renderer.pointee)
    if let separator: UInt8 {
      if separator != 0x20 { write(0x20) }
      write(separator)
      if separator != 0x20 { write(0x20) }
    }
    S1._render(s1, into: &renderer.pointee)
  }
}

/// A text writer that outputs a string
struct _TextBufferWriter: Sendable, CSSStreamWriter {
  init() {}

  private var result: [UInt8] = []

  mutating func write(_ byte: consuming UInt8) {
    result.append(byte)
  }

  public mutating func write<S: Sequence<UInt8>>(contentsOf sequence: consuming S) {
    result.append(contentsOf: sequence)
  }

  public consuming func finish() -> String {
    return String(decoding: result, as: UTF8.self)
  }
}