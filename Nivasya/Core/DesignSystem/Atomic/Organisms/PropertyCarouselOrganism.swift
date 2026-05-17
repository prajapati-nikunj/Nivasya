import SwiftUI

public struct PropertyCarouselOrganism: View {
    let properties: [Property]
    let onPropertyTap: (Property) -> Void
    
    public init(properties: [Property], onPropertyTap: @escaping (Property) -> Void) {
        self.properties = properties
        self.onPropertyTap = onPropertyTap
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Nearby You")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(AppColors.textPrimary)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(properties) { property in
                        NearbyPropertyCard(property: property)
                            .onTapGesture {
                                onPropertyTap(property)
                            }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }
        }
    }
}
