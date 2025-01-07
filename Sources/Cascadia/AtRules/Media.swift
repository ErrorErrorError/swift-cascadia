public struct Media<Content: Selector>: AtRule {

  public init(_ query: String, @CSSBuilder content: () -> Content) {}
}