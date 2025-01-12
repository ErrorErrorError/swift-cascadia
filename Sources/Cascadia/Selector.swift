/// A CSS selector
public protocol Selector: CSS where Body: Selector {}

extension Never: Selector {}
extension EmptyCSS: Selector {}
extension CSSTuple: Selector where repeat each Child: Selector {}
extension _CSSConditional where TrueContent: Selector, FalseContent: Selector {}
extension Optional: Selector where Wrapped: Selector {}