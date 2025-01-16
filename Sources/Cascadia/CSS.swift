public protocol CSS {
  associatedtype Body: CSS

  @CSSBuilder
  var body: Self.Body { get }

  @_spi(Renderer)
  static func _render<Writer: CSSStreamWriter>(
    _ value: consuming Self,
    into renderer: inout Renderer<Writer>
  )
}

extension CSS {
  // TODO: Hide `CSS/_render` static function from autocompletion.
  // @_spi(Renderer)
  public static func _render<Writer: CSSStreamWriter>(
    _ value: consuming Self,
    into renderer: inout Renderer<Writer>
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

/// Used for testing
extension CSS {
  func render<Writer: CSSStreamWriter>(
    into writer: inout Writer,
    using config: consuming StyleSheetConfiguration = .init()
  ) -> Writer.Output {
    var renderer = Renderer(&writer, config: config)
    Self._render(self, into: &renderer)
    return writer.finish()
  }

  func render(using config: consuming StyleSheetConfiguration = .init()) -> String {
    var writer = _TextBufferWriter()
    return self.render(into: &writer, using: config)
  }
}