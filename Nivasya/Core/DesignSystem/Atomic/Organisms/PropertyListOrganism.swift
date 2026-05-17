import SwiftUI

public struct PropertyListOrganism: View {
    let properties: [Property]
    let onPropertyTap: (Property) -> Void
    let onViewAllTap: () -> Void
    
    public init(properties: [Property], onPropertyTap: @escaping (Property) -> Void, onViewAllTap: @escaping () -> Void) {
        self.properties = properties
        self.onPropertyTap = onPropertyTap
        self.onViewAllTap = onViewAllTap
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Featured Properties")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(AppColors.textPrimary)
                
                Spacer()
                
                Button(action: onViewAllTap) {
                    Text("View All")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppColors.primary)
                }
            }
            .padding(.horizontal, 16)
            
            VStack(spacing: 20) {
                ForEach(properties) { property in
                    PropertyCard(property: property)
                        .onTapGesture {
                            onPropertyTap(property)
                        }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
