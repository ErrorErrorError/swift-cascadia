@_documentation(visibility: internal)
public struct StyleDeclaration<each P: Property>: GroupingRule {
  public typealias Content = Never

  public let properties: (repeat (each P).Value)
  
  public init(_ properties: repeat (each P).Value) {
    self.properties = (repeat each properties)
  }

  @inlinable @inline(__always)
  public static func render(
    _ declaration: consuming Self, 
    into renderer: consuming Renderer
  ) {
    // for property in repeat each declaration.properties {
    //   renderer.declaration(property.identifier, value: property.rawValue)
    // }
  }
}