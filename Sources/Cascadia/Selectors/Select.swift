public struct Select<Content: CSS>: Selector {
  public init(
    _ selector: String, 
    @CSSBuilder content: () -> Content = EmptyCSS.init
  ) {}
}