public extension CSSProperty {
  enum Background: Property, ColorRepresentable {
    public static let identifier = "background"
  }
}

public typealias Background = CSSProperty.Background.Value

public extension Declaration<Background.ID> {
  static func url(_ string: String) -> Self {
    self.init(function: "url", value: string)
  }
}
