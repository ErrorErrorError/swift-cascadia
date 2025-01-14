public protocol CSS {
  associatedtype Body: CSS

  @CSSBuilder
  var body: Self.Body { get }

  @_spi(Renderer)
  static func _render<Renderer: CSSRendering>(
    _ value: consuming Self,
    into renderer: inout Renderer
  )
}

extension CSS {
  // TODO: Hide `CSS/_render` static function from autocompletion.
  // @_spi(Renderer)
  @_documentation(visibility: internal)
  public static func _render<Renderer: CSSRendering>(
    _ value: consuming Self,
    into renderer: inout Renderer
  ) {
    Body._render(value.body, into: &renderer)
  }
}

extension Never: CSS {
  public typealias Body = Self

  public var body: Body {
    neverBody(Self.self)
  }
}

extension CSS {
  consuming func render<Renderer: CSSRendering>(
    into renderer: inout Renderer,
    using charset: StyleSheetConfiguration = .init()
  ) -> Renderer.Output {
    Self._render(self, into: &renderer)
    return renderer.finish()
  }

  consuming func render(
    using charset: StyleSheetConfiguration = .init()
  ) -> _CSSTextRenderer.Output {
    var renderer = _CSSTextRenderer()
    Self._render(self, into: &renderer)
    return renderer.finish()
  }
}