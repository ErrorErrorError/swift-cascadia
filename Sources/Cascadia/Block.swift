/// A type that allows nesting other rules and declarations
public protocol Block: CSS where Body: Block {}

extension Never: Block {}
extension EmptyCSS: Block {}
extension CSSTuple: Block where repeat each Child: Block {}
extension _CSSConditional: Block where TrueContent: Block, FalseContent: Block {}
extension Optional: Block where Wrapped: Block {}