/// A single CSS rule.
public protocol Rule: CSS where Body: Rule {}

extension Never: Rule {}
extension EmptyCSS: Rule  {}
extension CSSTuple: Rule where repeat each Child: Rule {}
extension _CSSConditional where TrueContent: Rule, FalseContent: Rule {}
extension Optional: Rule where Wrapped: Rule {}