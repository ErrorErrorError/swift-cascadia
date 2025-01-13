public protocol CSS {
  associatedtype Body: CSS

  @CSSBuilder
  var body: Self.Body { get }

  @_spi(CascadiaCore)
  static func _render<Writer: StyleSheetWriter>(
    _ value: consuming Self,
    into renderer: consuming Renderer<Writer>
  )
}

extension CSS {
  // TODO: Hide `CSS/_render` static function from autocompletion.
  // @_spi(CascadiaCore)
  @_documentation(visibility: internal)
  public static func _render<Writer: StyleSheetWriter>(
    _ value: consuming Self,
    into renderer: consuming Renderer<Writer>
  ) {
    Body._render(value.body, into: renderer)
  }
}

extension Never: CSS {
  public typealias Body = Self

  public var body: Body {
    neverBody(Self.self)
  }
}

extension CSS {
  consuming func render<Writer: StyleSheetWriter>(
    into writer: Writer = CSSTextWriter(),
    using charset: StyleSheetConfiguration = .init()
  ) -> Writer.Output {
    Self._render(self, into: Renderer(writer))
    return writer.finish()
  }
}