/// A property-value pair
/// Also defines which feature is considered for a given property
public protocol Property: Block where Body == Never {
  associatedtype Value: RawValue

  static var identifier: String { get }

  var value: Value { get }

  init(_ value: Value)
}

extension Property {
  public consuming func important() -> Important<Self> {
    Important(self)
  }

  @_spi(Core)
  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(Renderer)
  public static func _render<Writer: CSSStreamWriter>(
    _ property: consuming Self, 
    into renderer: inout Renderer<Writer>
  ) {
    renderer.declaration(
      Self.identifier,
      value: property.value.rawValue, 
      important: false
    )
  }
}

public struct Important<D: Property>: Block {
  let property: D

  init(_ property: D) {
    self.property = property
  }

  @_spi(Core)
  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(Renderer)
  public static func _render<Writer: CSSStreamWriter>(
    _ `self`: consuming Important<D>, 
    into renderer: inout Renderer<Writer>
  ) {
    renderer.declaration(
      D.identifier, 
      value: self.property.value.rawValue, 
      important: true
    )
  }
}