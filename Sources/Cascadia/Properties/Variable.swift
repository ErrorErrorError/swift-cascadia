// public struct Variable: Property {
//   public static var identifier: String { "--" }
//   public let identifier: String
//   public var value: Value

//   public init(_ identifier: String, value: Value) {
//     self.identifier = identifier
//     self.value = value
//   }

//   @_spi(Renderer)
//   public static func _render<Writer: CSSStreamWriter>(
//     _ variable: consuming Self,
//     into renderer: inout Renderer<Writer>
//   ) {
//     renderer.declaration(
//       variable.identifier,
//       value: variable.value.rawValue,
//       important: false
//     )
//   }
// }
