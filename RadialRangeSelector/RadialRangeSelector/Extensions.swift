//
//  Extensions.swift
//  RadialRangeSelector
//
//  Created by danylo.net on 8/9/22.
//

import SwiftUI

//MARK: - animatableSystemFont animates the growth in font size when knob is pressed
struct AnimatableSystemFontModifier: AnimatableModifier {
    var size: CGFloat
    var weight: Font.Weight
    var design: Font.Design
    
    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
    }
}

extension View {
    func animatableSystemFont(size: CGFloat, weight: Font.Weight = .black, design: Font.Design = .default) -> some View {
        self.modifier(AnimatableSystemFontModifier(size: size, weight: weight, design: design))
    }
}

//MARK: - helps automatically generate gradients
extension Color {
    func lighten(amount dm: CGFloat) -> Color {
        let color = self
        var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        
        let color1 = UIColor(color)
        
        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        
        return Color(red: Double(min(r1 + dm, 1)), green: Double(min(g1 + dm, 1)), blue: Double(min(b1 + dm, 1)))
    }
    
    
    func darken(amount dm: CGFloat) -> Color {
        let color = self
        
        var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        
        let color1 = UIColor(color)
        
        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
       
        return Color(red: Double(r1/dm), green: Double(g1/dm), blue: Double(b1/dm))
    }

}
