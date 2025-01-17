public struct ColorInterpolationFilters: Declaration {
  public static let identifier = "color-interpolation-filter"
  public var value: Value
  
  public init(_ value: Value) {
    self.value = value
  }
}