import SwiftUI

public struct EmptyStateMolecule: View {
    let message: String
    
    public init(message: String) {
        self.message = message
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "house.slash")
                .font(.system(size: 40))
                .foregroundColor(AppColors.textSecondary)
            Text(message)
                .font(AppTypography.body)
                .foregroundColor(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}
