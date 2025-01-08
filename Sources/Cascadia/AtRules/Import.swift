public struct Import: AtRule {
  public var url: String

  public init(_ url: String) {
    self.url = url
  }
}