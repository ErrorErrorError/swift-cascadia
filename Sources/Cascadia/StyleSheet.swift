/// A Style Sheet
public protocol StyleSheet {
  associatedtype Body: Rule

  @CSSBuilder
  var body: Self.Body { get }
}

extension StyleSheet {
  @inlinable @inline(__always)
  public consuming func render<Renderer: CSSRendering>(
    into renderer: inout Renderer, 
    using options: consuming StyleSheetConfiguration = .init()
  ) -> Renderer.Output {
    stylesheet(into: &renderer, options: options) {
      self.body
    }
  }

  @inlinable @inline(__always)
  public consuming func render(
    using options: consuming StyleSheetConfiguration = .init()
  ) -> String {
    stylesheet(options: options) {
      self.body
    }
  }
}

/// A public interface used to render Cascading Style Sheets (CSS).
public func stylesheet<Renderer: CSSRendering, Content: Rule>(
  into renderer: inout Renderer,
  options: consuming StyleSheetConfiguration = .init(),
  @CSSBuilder content: () -> Content 
) -> Renderer.Output {
  Content._render(content(), into: &renderer)
  return renderer.finish()
}

/// A public interface used to render Cascading Style Sheets (CSS) into a String.
/// - Parameters:
///   - options: StyleSheet options
///   - content: 
/// - Returns: A StyleSheet string based on the options provided.
public func stylesheet<Content: Rule>(
  options: consuming StyleSheetConfiguration = .init(),
  @CSSBuilder content: () -> Content
) -> String {
  var renderer = _CSSTextRenderer()
  return stylesheet(into: &renderer, options: options, content: content)
}

public struct StyleSheetConfiguration: Hashable, Sendable {
  public var minify: Bool
  public var indent: UInt
  public var charset: Charset

  public init(
    minify: Bool = false,
    indent: UInt = 2,
    charset: Charset = .utf8
  ) {
    self.minify = minify
    self.indent = indent
    self.charset = charset
  }

  public enum Charset: Hashable, Sendable {
    /// UTF-8
    case utf8

    /// ISO 8559-15 (Latin-9)
    case iso8559_15
  }
}