public struct Import: AtRule {
  public static let identifier = "import"

  public var url: String

  public init(_ url: String) {
    self.url = url
  }
}
