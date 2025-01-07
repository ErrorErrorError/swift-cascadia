public struct Element<Content: CSS>: Selector {
  public init(_ value: String, @CSSBuilder content: () -> Content = EmptyCSS.init) {}
}