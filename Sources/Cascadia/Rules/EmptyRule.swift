public struct EmptyRule: RuleChild {
  public typealias Content = Never

  @inlinable
  public init() {}

  public static func render(
    _ rule: consuming Self, 
    into renderer: consuming Renderer
  ) {
  }
}