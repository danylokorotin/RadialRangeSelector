//
//  ContentView.swift
//  RadialRangeSelector
//
//  Created by danylo.net on 8/9/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var min = -20
    @State private var max = 20
    
    var body: some View {
        VStack {
            RadialRangeSelector(minUser: $min, maxUser: $max, minVal: -100, maxVal: 100, increment: 10, radius: 125, color: Color.red, dotted: true)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




