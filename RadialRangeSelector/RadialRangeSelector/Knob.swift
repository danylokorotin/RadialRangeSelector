//
//  Knob.swift
//  RadialRangeSelector
//
//  Created by danylo.net on 8/9/22.
//
import SwiftUI

struct Knob: View {
  
    var touched: Bool = false
    var display: Int
    var color: Color
    let knobRadius: CGFloat
    let radius: CGFloat
    var angleValue: CGFloat = 0
    var smallFont: CGFloat
    var bigFont: CGFloat
    
    var smallTinted: RadialGradient {
        return RadialGradient(gradient: Gradient(colors: [color, color.lighten(amount: 0.5)]), center: .center, startRadius: 2, endRadius: smallFont * 2)
    }
   
    var bigTinted: RadialGradient {
        return RadialGradient(gradient: Gradient(colors: [color, color.lighten(amount: 0.5)]), center: .center, startRadius: 2, endRadius: bigFont * 2)
    }
    
    var body: some View {
        Circle()
            .fill(touched ? bigTinted : smallTinted)
            .frame(width: knobRadius * (touched ? 4 : 2), height: knobRadius * (touched ? 4 : 2))
            .overlay(
                Text("\(display)")
                    .fixedSize(horizontal: true, vertical: true)
                    .foregroundColor(.black)
                    .frame(width: knobRadius * 4, height: knobRadius * 4 )
                    .animation(nil, value: touched)
                    .animatableSystemFont(size: touched ? bigFont : smallFont)
                    .rotationEffect( Angle.degrees(Double(135 - angleValue)))
                    .animation(.default, value: touched)
            )
            .padding(10)
            .offset(y: -radius)
            .rotationEffect(Angle.degrees(Double(angleValue)))
            .shadow(color: color.opacity(0.9), radius: 4, x: 0.0, y: 0.0)
    }
}
