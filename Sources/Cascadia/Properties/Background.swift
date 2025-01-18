public struct Background: Property, ColorValue {
  public static let identifier = "background"
  public var value: Value

  public init(_ rawValue: Value) {
    self.value = rawValue
  }

  public init(url: String) {
    self.init("url(\"\(url)\")")
  }

  public init(src: String) {
    self.init("src(\"\(src)\")")
  }
}