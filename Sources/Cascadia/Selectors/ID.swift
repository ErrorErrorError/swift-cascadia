public struct ID<Content: CSS>: Selector {
  public init(
    _ name: String, 
    @CSSBuilder content: () -> Content = EmptyCSS.init
  ) {}
}