@_documentation(visibility: internal)
public struct RuleSet<each P: Property>: NestedStatement {
  public let properties: (repeat (each P).Value)
  
  public init(_ properties: repeat (each P).Value) {
    self.properties = (repeat each properties)
  }
}