/// A CSS that can contain statement
public protocol StyleSheet: CSS where Body: Rule {
  @CSSBuilder
  var body: Body { get }
}

public extension StyleSheet {
  consuming func render<Writer: StyleSheetWriter>(
    into writer: Writer = CSSTextWriter(), 
    using options: consuming StyleSheetConfiguration = .init()
  ) -> Writer.Output {
    stylesheet(into: writer, options: options) {
      self.body
    }
  }
}

/// A public interface used to render Cascading Style Sheets
public func stylesheet<Writer: StyleSheetWriter, Content: Rule>(
  into writer: Writer = CSSTextWriter(),
  options: consuming StyleSheetConfiguration = .init(),
  @CSSBuilder content: () -> Content 
) -> Writer.Output {
  var renderer = Renderer(writer)
  Content._render(content(), into: renderer)
  return writer.finish()
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