//
//  ContentView.swift
//  Simon
//
//  Created by Jack W on 9/12/22.

import SwiftUI
struct ContentView: View {
    @State private var ColorDisplay = [ColorDisplay(color: .green), ColorDisplay(color: .red), ColorDisplay(color: .yellow), ColorDisplay(color: .blue)]
    @State private var flash = [false, false, false, false]
    
    var body: some View {
        
        Text("Simon")
            .font(.system(size: 72))
            .padding()
            .preferredColorScheme(.dark)
    }
    struct ColorDisplay: View {
        let color: Color
        var body: some View {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(color)
                .frame(width: 100, height: 100, alignment: .center)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
