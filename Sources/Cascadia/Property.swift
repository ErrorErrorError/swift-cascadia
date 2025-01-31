/// A property-value pair
/// Also defines which feature is considered for a given property
public protocol Property: Block where Body == Never {
  associatedtype Value: RawValue

  var identifier: String { get }
  var value: Value { get }
}

public protocol PrimitiveProperty: Property {
  static var identifier: String { get }

  init(_ value: Value)
}

extension PrimitiveProperty {
  public var identifier: String { Self.identifier }
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
      property.identifier,
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
      self.property.identifier, 
      value: self.property.value.rawValue, 
      important: true
    )
  }
}