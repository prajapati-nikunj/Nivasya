import SwiftUI

public struct SearchFilterTrayOrganism: View {
    @Binding var searchText: String
    @Binding var selectedCategory: PropertyCategory?
    let onFilterTap: () -> Void
    
    @Environment(\.colorScheme) private var colorScheme
    
    public init(searchText: Binding<String>, selectedCategory: Binding<PropertyCategory?>, onFilterTap: @escaping () -> Void) {
        self._searchText = searchText
        self._selectedCategory = selectedCategory
        self.onFilterTap = onFilterTap
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            searchSection
            CategoryChipsView(selectedCategory: $selectedCategory)
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.ultraThinMaterial)
                
                RoundedRectangle(cornerRadius: 24)
                    .fill(colorScheme == .dark ? Color.black.opacity(0.1) : Color.white.opacity(0.2))
            }
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(colorScheme == .dark ? Color.white.opacity(0.05) : Color.white.opacity(0.3), lineWidth: 0.5)
        )
        .shadow(color: .black.opacity(0.05), radius: 15, x: 0, y: 10)
    }
    
    private var searchSection: some View {
        HStack(spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(AppColors.textPrimary.opacity(0.6))
                
                TextField("Search properties...", text: $searchText)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColors.textPrimary)
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white.opacity(0.4))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.05),
                        lineWidth: 0.5
                    )
            )
            
            Button(action: onFilterTap) {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(14)
                    .background(
                        Circle()
                            .fill(AppColors.luxuryGradient(colorScheme: colorScheme))
                    )
                    .shadow(
                        color: AppColors.primary.opacity(colorScheme == .dark ? 0.5 : 0.3),
                        radius: 12, x: 0, y: 6
                    )
            }
        }
    }
}
