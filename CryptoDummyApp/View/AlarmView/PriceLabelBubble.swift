import SwiftUI

struct PriceLabelBubble: View {
    var value: Double
    
    var body: some View {
        Text(String(format: "%%%.0f", value))
            .font(.system(size: 12, weight: .bold))
            .foregroundColor(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 4)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(value >= 0 ? Color.green1 : Color.red1)
            )
            .overlay(
                Triangle()
                    .fill(value >= 0 ? Color.green1 : Color.red1)
                    .frame(width: 10, height: 5)
                    .rotationEffect(.degrees(180))
                    .offset(y: 5),
                alignment: .bottom
            )
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}
