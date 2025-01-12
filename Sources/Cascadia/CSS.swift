public protocol CSS {
  associatedtype Body: CSS

  @CSSBuilder
  var body: Self.Body { get }

  @_spi(CascadiaCore)
  static func _render(
    _ value: consuming Self,
    into renderer: consuming Renderer
  )
}

extension CSS {
  // @_spi(CascadiaCore)
  public static func _render(
    _ value: consuming Self,
    into renderer: consuming Renderer
  ) {
    Body._render(value.body, into: renderer)
  }
}

extension Never: CSS {
  public typealias Body = Self

  public var body: Self {
    neverBody(Self.self)
  }

  @_spi(CascadiaCore)
  public static func _render(
    _ value: consuming Self,
    into renderer: consuming Renderer
  ) {
    fatalError("cannot render")
  }
}

extension CSS {
  consuming func render() -> String {
    let storage = Renderer.TokensStorage()
    Self._render(self, into: Renderer(storage))
    return storage.collect()
  }
}