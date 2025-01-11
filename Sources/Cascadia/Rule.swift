/// A single CSS rule.
public protocol Rule {
  static func render(
    _ rule: consuming Self, 
    into renderer: consuming Renderer
  )
}

/// A rule that contains other rules.
public protocol GroupingRule: Rule {
  associatedtype Content: Rule

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
  public consuming func render() -> String {
    let storage = Renderer.ByteBuffer()
    Self.render(self, into: Renderer(bytes: storage))
    return storage.collect()
  }
}

public struct EmptyRule: GroupingRule {
  public typealias Content = Never

  @inlinable
  public init() {}

  public static func render(
    _ rule: consuming Self, 
    into renderer: consuming Renderer
  ) {
  }
}