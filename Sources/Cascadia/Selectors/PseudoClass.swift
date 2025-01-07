public struct PseudoClass: Selector, ExpressibleByStringLiteral, RawRepresentable {
  public let rawValue: String
  
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  public init(stringLiteral value: String) {
    self.init(rawValue: value)
  }

  private init(_ rawValue: String = #function) {
    self.init(rawValue: rawValue)
  }

  public var body: Never {
    fatalError()
  }
}

extension PseudoClass {
  public static var active: Self { .init() }
  public static var checked: Self { .init() }
  public static var `default`: Self { .init() }
  public static var disabled: Self { .init() }
  public static var empty: Self { .init() }
  public static var firstChild: Self { "first-child" }
}
