public struct AlignContent {
  public static let identifier = "align-content"

  public init(_ value: Value) {
    
  }
}

extension AlignContent {
  public struct Value: Sendable, RawValue, ExpressibleByStringInterpolation {
    public var rawValue: String

    public init(_ value: String) {
      self.rawValue = value
    }

    public enum BaselinePosition: String {
      case first, last
    }

    public enum OverflowPosition: String {
      case unsafe, safe
    }

    public enum ContentPosition: String {
      case center, start, end
      case flexStart = "flex-star"
      case flexEnd = "flex-end"
    }

    public static let normal: Self = #function
    public static let baseline: Self = #function
    public static func baseline(_ position: BaselinePosition) -> Self { "\(position.rawValue) baseline" }
    public static let spaceBetween: Self = "space-between"
    public static let spaceAround: Self = "space-around"
    public static let spaceEvenly: Self = "space-evenly"
    public static let stretch: Self = #function
    public static func content(_ overflow: OverflowPosition? = nil, _ content: ContentPosition) -> Self {
      Self([overflow?.rawValue, content.rawValue].joined(separator: " "))
    }
  }
}