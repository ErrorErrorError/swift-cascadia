public struct AlignContent: Property {
  public static let identifier = "align-content"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }

  public static let normal = Self(#function)

  public static func baseline(_ position: BaselinePosition? = nil) -> Self {
    Self(Value([position?.rawValue, "baseline"].joined(separator: " ")))
  }

  public static func distribution(_ distribution: ContentDistribution) -> Self {
    Self(Value(distribution.rawValue))
  }

  public static func position(_ overflow: OverflowPosition? = nil, _ content: ContentPosition) -> Self {
    Self(Value([overflow?.rawValue, content.rawValue].joined(separator: " ")))
  }

  public enum BaselinePosition: String {
    case first, last
  }

  public enum ContentDistribution: String {
    case spaceBetween = "space-between"
    case spaceAround = "space-around"
    case spaceEvenly = "space-evenly"
    case stretch = "stretch"
  }

  public enum OverflowPosition: String {
    case unsafe, safe
  }

  public enum ContentPosition: String {
    case center, start, end
    case flexStart = "flex-star"
    case flexEnd = "flex-end"
  }
}