/// A CSS selector
public protocol Selector {
  static func render<Renderer: _SelectorRendering>(
    _ selector: consuming Self,
    into renderer: inout Renderer
  )
}

public enum SelectorToken: ExpressibleByStringLiteral, ExpressibleByArrayLiteral, ExpressibleByIntegerLiteral {
  case whitespace(canOmit: Bool = true)
  case newline
  case bytes([UInt8])

  @inlinable @inline(__always)
  public init(_ value: String) {
    self = .bytes(Array(value.utf8))
  }

  @inlinable @inline(__always)
  public init<S: Sequence<UInt8>>(_ sequence: S) {
    self = .bytes(Array(sequence))
  }

  @inlinable @inline(__always)
  public init(_ bytes: UInt8...) {
    self.init(bytes)
  }

  @inlinable @inline(__always)
  public init(stringLiteral value: String) {
    self.init(value)
  }

  @inlinable @inline(__always)
  public init(arrayLiteral elements: UInt8...) {
    self.init(elements)
  }

  public init(integerLiteral value: UInt8) {
    self.init(value)
  }
}

public protocol _SelectorRendering {
  mutating func appendTokens(_ token:  SelectorToken...)
}

extension Selector {
  /// Renders the selector into a single string synchronously
  /// - Returns: The rendered selector
  public consuming func render() -> String {
    var renderer = SelectorRenderer()
    Self.render(self, into: &renderer)
    return renderer.collect()
  }

  // /// Renders the selector into a byte-array
  // public consuming func render(chunkSize: Int = 1024) -> AsyncStream<UInt8> {
  //   AsyncStream { continuation in
  //     continuation.finish()
  //   }
  // }

  // @_disfavoredOverload
  // public consuming func render() async throws -> String {
  //   // var renderer = SelectorRenderer()
  //   // Self.render(self, into: &renderer)
  //   // return renderer.collect()
  // }
}
