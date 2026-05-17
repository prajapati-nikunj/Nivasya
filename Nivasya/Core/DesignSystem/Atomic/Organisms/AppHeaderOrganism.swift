import SwiftUI

public struct AppHeaderOrganism: View {
    @Environment(\.colorScheme) private var colorScheme
    let onNotificationTap: () -> Void
    
    public init(onNotificationTap: @escaping () -> Void) {
        self.onNotificationTap = onNotificationTap
    }
    
    public var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Nivasya")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                
                Text("Find your perfect dream home")
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.textSecondary)
            }
            
            Spacer()
            
            Button(action: onNotificationTap) {
                Image(systemName: "bell.badge.fill")
                    .font(.system(size: 20))
                    .foregroundColor(AppColors.primary)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                            .overlay(Circle().fill(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white.opacity(0.3)))
                    )
                    .overlay(Circle().stroke(colorScheme == .dark ? Color.white.opacity(0.1) : Color.white.opacity(0.5), lineWidth: 0.5))
            }
        }
    }
}
