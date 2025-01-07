public struct All<Content: CSS>: Selector {
  public init(@CSSBuilder content: () -> Content = EmptyCSS.init) {}
}