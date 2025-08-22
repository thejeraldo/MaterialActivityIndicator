//
//  SwiftUIView.swift
//  MaterialActivityIndicator
//
//  Created by Jerald Abille on 22/08/2025.
//

import SwiftUI

public struct SpinnerShape: Shape {
    var start: CGFloat
    var end: CGFloat
    public var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(start, end)}
        set {
            start = newValue.first
            end = newValue.second
        }
    }

    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: .degrees(Double(start) * 360),
                    endAngle: .degrees(Double(end) * 360),
                    clockwise: true)
        return path
    }
}

public struct MaterialActivityIndicator: View {
    @State private var start: CGFloat = 0.05
    @State private var end: CGFloat = 0.0
    @State private var rotation: Double = 0.0
    var lineWidth: CGFloat
    var tintColor: UIColor = .green
    var isLoading: Bool = true
    
    public var body: some View {
        SpinnerShape(start: start, end: end)
            .stroke(LinearGradient(
                gradient: Gradient(colors: [
                    Color(uiColor: tintColor),
                    Color.white
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .rotationEffect(.degrees(rotation))
            .onAppear {
                animateRotation()
                animateHeadTail()
            }
    }
    
    private func animateRotation() {
        withAnimation(.linear(duration: 1.4).repeatForever(autoreverses: false)) {
            rotation = 360
        }
    }
    
    private func animateHeadTail() {
        Task {
            while isLoading {
                await animate { start += 0.75 }
                await animate { end += 0.75 }
            }
        }
    }
    
    private func animate(_ action: @escaping () -> Void) async {
        withAnimation(.easeOut(duration: 0.65)) {
            action()
        }
        try? await Task.sleep(nanoseconds: 650_000_000)
    }
}

#Preview {
    VStack(spacing: 10) {
        MaterialActivityIndicator(lineWidth: 4, tintColor: .systemTeal)
            .frame(width: 30, height: 30)
    }
    .padding()
    .background(Color(uiColor: .systemGray5))
    .clipShape(RoundedRectangle(cornerRadius: 10))
}
