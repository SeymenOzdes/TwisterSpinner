//
//  ContentView.swift
//  Twister
//
//  Created by Seymen Özdeş on 26.04.2025.
//

import SwiftUI

enum TwisterColor: CaseIterable {
    case yellow
    case red
    case blue
    case green
    
    var color: Color {
        switch self {
        case .yellow:
            return Color.yellow
        case .red:
            return Color.red
        case .blue:
            return Color.blue
        case .green:
            return Color.green
            
        }
    }
    var name: String {
        switch self {
        case .yellow:
            return "Sarı"
        case .red:
            return "Kırmızı"
        case .blue:
            return "Mavi"
        case .green:
            return "Yeşil"
        }
    }
}

struct HomeView: View {
    @State private var rotationRatio: Double = 0
    @State private var angle: Double = 0
    @State private var showAlert = false
    @State private var selectedColorName = ""
    @State private var selectedLimb = ""
    
    var body: some View {
        ZStack {
            VStack {
                Text("Sol El")
                    .offset(x: -280, y: -280)
                    .fontWeight(.bold)
                    .font(.title)
                Image("leftHand")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .offset(x: -280, y: -280)
            }

            VStack {
                Text("Sol Ayak")
                    .offset(x: 280, y: -280)
                    .fontWeight(.bold)
                    .font(.title)
                
                Image("leftFoot")
                    .resizable()
                    .frame(width: 170, height: 150)
                    .offset(x: 280, y: -280)
            }
            
            VStack {
                Text("Sağ Ayak")
                    .offset(x: -280, y: 280)
                    .fontWeight(.bold)
                    .font(.title)
                
                Image("rightFoot")
                    .resizable()
                    .frame(width: 170, height: 150)
                    .offset(x: -280, y: 280)
            }
            
            VStack {
                Text("Sağ El")
                    .offset(x: 280, y: 280)
                    .fontWeight(.bold)
                    .font(.title)
                
                Image("rightHand")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .offset(x: 280, y: 280)
            }
            
            VStack {
                GeometryReader { geometry in
                    let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    let radius = min(geometry.size.width, geometry.size.height) / 2 - 180 
                    let cursor = makeCursor(from: center)
                    
                    ZStack {
                        ForEach(0..<16) { index in
                            CircleView(index: index, radius: radius, center: center)
                        }
                    }
                    
                    cursor
                        .stroke(Color.black, lineWidth: 8)
                        .rotationEffect(.degrees(rotationRatio))
                }
                
                Button("Döndür") {
                    withAnimation {
                        angle = generateRandomAngle()
                        rotationRatio = angle
                        
                        let index = Int(angle / 22.5) % 16
                        let color = TwisterColor.allCases[index % 4]
                        let limb = getLimb(for: index)
                        selectedLimb = limb
                        selectedColorName = color.name
                        showAlert = true
                        
                        print(index)
                        print(color)
                        print(limb)
                    }
                    
                }
                .buttonStyle(.bordered)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 60, trailing: 0))
            }
        }
        .sheet(isPresented: $showAlert) {
            VStack(spacing: 20) {
                Text("Sonuç")
                    .font(.largeTitle)
                    .bold()
                
                Text("\(selectedLimb) - \(selectedColorName)")
                    .font(.title)
                    .foregroundColor(.primary)
                
                Button("Kapat") {
                    showAlert = false
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .presentationDetents([.fraction(0.3), .medium, .large])
        }
    }
    
}
// MARK: FUNCTİONS
extension HomeView {
     func makeCursor(from center: CGPoint) -> Path {
        var path = Path()
        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x, y: center.y - 170))
        return path
    }
    func generateRandomAngle() -> Double {
        var randomNum = Int.random(in: 0..<16)
        let doubleTypeNum = Double(randomNum)
        let angle = doubleTypeNum * 22.5
        randomNum = 0
        return angle
    }
    func getLimb(for Index: Int) -> String {
        switch Index / 4 {
        case 0: return "Sol Ayak"
        case 1: return "Sağ El"
        case 2: return "Sağ Ayak"
        case 3: return "Sol El"
        default: return "Bilinmeyen"
        }
    }
}

#Preview {
    HomeView()
}
