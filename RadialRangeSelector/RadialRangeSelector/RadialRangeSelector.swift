//
//  RadialRangeSelector.swift
//  RadialRangeSelector
//
//  Created by danylo.net on 8/9/22.
//
import SwiftUI

struct RadialRangeSelector: View {
    @Binding var minUser: Int
    @Binding var maxUser: Int
    
    let minVal: Int
    let maxVal: Int
    let increment: Int
    
    let radius: CGFloat
    var color: Color
    let dotted: Bool
    
    
    //MARK: - Proportions based on the range selector's radius to support different radius sizes.
    var knobRadius: CGFloat {
        return radius / 7
    }
    
    var blurbFontSize: CGFloat {
        return radius / 8
    }
    
    var smallFont: CGFloat {
        return radius / 10
    }
    
    var bigFont: CGFloat {
        return radius / 5
    }
    
    var lineWidth: CGFloat {
        return radius / 25
    }
    
    //MARK: - computation and animation
    @State var minAngleValue: CGFloat = 0.0
    @State var maxAngleValue: CGFloat = 0.0
    @State private var touchedMin = false
    @State private var touchedMax = false
    
    var totalVal: CGFloat {
        return CGFloat(maxVal) - CGFloat(minVal)
    }
    
    var angleLength: CGFloat {
        270 / (totalVal / CGFloat(increment) )
    }
    
    var minCircleTrim: CGFloat {
        return  minAngleValue / 360
    }
    
    var maxCircleTrim: CGFloat {
        return  maxAngleValue / 360
    }
    
    var bottomDarkTint: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [color.lighten(amount: 0.5), color.darken(amount: 2)]), startPoint: .topLeading, endPoint: .bottom)
    }
    
    //MARK: - dotted circle settings
    let pi = Double.pi
    let dotCount = 17
    let dotLength: CGFloat = 2
    
    var circumference: CGFloat {
        return CGFloat(2.0 * pi) * radius
    }
    var spaceLength: CGFloat {
        return circumference * 0.72 / CGFloat(dotCount) - dotLength
    }
    
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .trim(from: 0.01, to: 0.74)
                    .stroke(dotted ? color : Color.gray, style: dotted ? StrokeStyle(lineWidth: lineWidth/2, lineCap: .butt, lineJoin: .miter, miterLimit: 0, dash: [dotLength, spaceLength], dashPhase: 0) : StrokeStyle(lineWidth: lineWidth, lineCap: .butt, lineJoin: .round, miterLimit: 0, dash: [0, 1], dashPhase: 0))
                    .frame(width: radius * 2, height: radius * 2)
                    .shadow(color: dotted ? color : Color.gray.opacity(0.8), radius: 4, x: 0.0, y: 0.0)
                    .rotationEffect(.degrees(-42.7))
                Circle()
                    .trim(from: minCircleTrim, to: maxCircleTrim)
                    .stroke(bottomDarkTint, lineWidth: lineWidth)
                    .frame(width: radius * 2, height: radius * 2)
                    .rotationEffect(.degrees(-90))
                    .shadow(color: color.opacity(0.9), radius: 4, x: 0.0, y: 0.0)
                    .rotationEffect(Angle.degrees(Double(45)))
                
                //MARK: - Minimum Knob
                Knob(touched: touchedMin, display: minUser, color: color, knobRadius: knobRadius, radius: radius, angleValue: minAngleValue, smallFont: smallFont, bigFont: bigFont)
                    .accessibility(label: Text("Minimum range selected \(minUser). Drag in a circular motion."))
                    .gesture(DragGesture(minimumDistance: 0.0)
                        .onChanged({ value in
                            touchedMin = true
                            changeMin(location: value.location)})
                        .onEnded({ _ in
                                touchedMin = false})
                    )
                    .rotationEffect(Angle.degrees(Double(45)))
                
                //MARK: - Maximum Knob
                Knob(touched: touchedMax, display: maxUser, color: color, knobRadius: knobRadius, radius: radius, angleValue: maxAngleValue, smallFont: smallFont, bigFont: bigFont)
                    .accessibility(label: Text("Maximum range selected \(maxUser). Drag in a circular motion."))
                    .gesture(DragGesture(minimumDistance: 0.0)
                        .onChanged({  value in
                            touchedMax = true
                            changeMax(location: value.location)})
                        .onEnded({ _ in touchedMax = false})
                    )
                    .rotationEffect(Angle.degrees(Double(45)))
            }
            .rotationEffect(Angle.degrees(-180))
            
            if touchedMax || touchedMin {
                //MARK: - Text that appears when knob is touched.
                Text("Selecting range...")
                    .foregroundColor(.gray)
                    .font(.system(size: blurbFontSize))
                    .fontWeight(.black)
                    .transition(.opacity)
            } else {
                //MARK: - A button could be placed inside the range selector here whenever range is NOT being selected.
            }
        }
        .frame(width: radius * 2.4, height: radius * 2.4)
        .onAppear(perform: {
            setup()
        })
        .animation(.default, value: touchedMax || touchedMin)
    }
}

