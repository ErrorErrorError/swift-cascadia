public struct ID<Content: Statement>: Selector {
  public let name: String
  public let content: Content

  public init(
    _ name: String, 
    @StatementBuilder content: () -> Content = EmptyStatement.init
  ) {
    self.name = switch  name.first {
    case .some("#"):
      String(name.dropFirst())
    default:
      name
    }
    self.content = content()
  }
}