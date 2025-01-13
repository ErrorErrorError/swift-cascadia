/// A CSS that can contain statement
public protocol StyleSheet: CSS where Body: Rule {
  @CSSBuilder
  var body: Body { get }
}

public extension StyleSheet {
  consuming func render<Writer: StyleSheetWriter>(
    into writer: Writer = CSSTextWriter(), 
    using charset: StyleSheetCharset = .utf8
  ) -> Writer.Output {
    Body._render(body, into: Renderer(writer))
    return writer.finish()
  }
}

public enum StyleSheetCharset {
  /// UTF-8
  case utf8

  /// ISO 8559-15 (Latin-9)
  case iso8559_15
}