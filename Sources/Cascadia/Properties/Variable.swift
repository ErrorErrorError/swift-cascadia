public struct Variable: Property {
  public let identifier: String
  public var value: String

  public init(_ identifier: String, value: String) {
    self.identifier = identifier.hasPrefix("--") ? identifier : "--\(identifier)"
    self.value = value
  }
}
