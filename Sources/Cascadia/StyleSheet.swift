/// A Style Sheet
public protocol StyleSheet {
  associatedtype Body: Rule

  @CSSBuilder
  var body: Self.Body { get }
}

extension StyleSheet {
  @inlinable @inline(__always)
  public consuming func render<Writer: CSSStreamWriter>(
    into writer: inout Writer, 
    using config: consuming StyleSheetConfiguration = .init()
  ) -> Writer.Output {
    stylesheet(into: &writer, using: config) {
      self.body
    }
  }

  @inlinable @inline(__always)
  public consuming func render(using config: consuming StyleSheetConfiguration = .init()) -> String {
    stylesheet(using: config) {
      self.body
    }
  }
}

/// A public interface used to render Cascading Style Sheets (CSS) into a String.
/// - Parameters:
///   - options: StyleSheet options
///   - content: 
/// - Returns: A StyleSheet string based on the options provided.
public func stylesheet<Content: Rule>(
  using config: consuming StyleSheetConfiguration = .init(),
  @CSSBuilder content: () -> Content
) -> String {
  var renderer = _TextBufferWriter()
  return stylesheet(into: &renderer, using: config, content: content)
}

/// A public interface used to render Cascading Style Sheets (CSS).
public func stylesheet<Writer: CSSStreamWriter, Content: Rule>(
  into writer: inout Writer,
  using config: consuming StyleSheetConfiguration = .init(),
  @CSSBuilder content: () -> Content 
) -> Writer.Output {
  var renderer = Renderer(&writer, config: config)
  Content._render(content(), into: &renderer)
  return writer.finish()
}

public struct StyleSheetConfiguration: Hashable, Sendable {
  public var indent: Indent

  public enum Indent: Hashable, Sendable {
    case minify
    case tabs(UInt = 1)
    case spaces(UInt = 2)
  }

  public init(indent: Indent = .spaces(2)) {
    self.indent = indent
  }
}