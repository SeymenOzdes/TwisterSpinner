//
//  CircleView.swift
//  Twister
//
//  Created by Seymen Özdeş on 29.04.2025.
//
import SwiftUI

struct CircleView: View {
    let index: Int
    let radius: CGFloat
    let center: CGPoint
    
    var body: some View {
        let angle = 2 * .pi * Double(index) / 16
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)
        let colors = TwisterColor.allCases[index % 4]
        
        Circle()
            .fill(colors.color)
            .frame(width: 80, height: 80)
            .position(x: x, y: y)
    }
}
