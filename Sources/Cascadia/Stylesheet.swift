public struct Stylesheet<Content: Statement> {
  public init(@CSSBuilder content: () -> Content) {}
}