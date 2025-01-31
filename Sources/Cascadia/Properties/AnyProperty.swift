public struct AnyProperty: Property {
  public var identifier: String
  public var value: String

  public init(_ identifier: String, _ value: String) {
    self.identifier = identifier
    self.value = value
  }
}