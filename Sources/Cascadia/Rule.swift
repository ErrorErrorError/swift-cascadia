/// A single CSS rule.
public protocol Rule {
  static func render(
    _ rule: consuming Self, 
    into renderer: consuming Renderer
  )
}

public protocol RuleChild: Rule {
  // associatedtype Content: Rule
  // var content: Content { get }
}

extension Never: Rule {
  public static func render(
    _ rule: consuming Self, 
    into renderer: consuming Renderer
  ) {
    fatalError("Rendering 'Never' on \(Self.self) is not valid")
  }
}

extension Rule {
  consuming func render() -> String {
    let storage = Renderer.TokensStorage()
    Self.render(self, into: Renderer(storage))
    return storage.collect()
  }
}