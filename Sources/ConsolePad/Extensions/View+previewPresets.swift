import SwiftUI

struct PreviewPresets {
    static var dynamicTypeSizes: [DynamicTypeSize] {
        [
            .xSmall,
            .medium,
            .xxxLarge,
        ]
    }
}

extension PreviewPresets: ViewModifier {
    func body(content: Self.Content) -> some View {
        Group {
            ForEach(ColorScheme.allCases, id: \.self) { scheme in
                content
                    .preferredColorScheme(scheme)
                    .previewDisplayName("\(scheme)")
            }

            ForEach(Bundle.main.localizations, id: \.self) { id in
                content
                    .environment(\.locale, .init(identifier: id))
                    .previewDisplayName(id)
            }

            ForEach(Self.dynamicTypeSizes, id: \.self) { size in
                content
                    .environment(\.dynamicTypeSize, size)
                    .previewDisplayName("\(size)")
            }
        }
    }
}

extension View {
    func previewPresets() -> some View {
        self.modifier(PreviewPresets())
    }
}
