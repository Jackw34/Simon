//
//  ContentView.swift
//  Simon
//
//  Created by Jack W on 9/12/22.
//

import SwiftUI
struct ContentView: View {
    @State private var DisplayColor = [DisplayColor(color: .green), DisplayColor(color: .red), DisplayColor(color: .yellow), DisplayColor(color: .blue)]
    var body: some View {
        //(.preferredColorScheme(.black))
        Text("Simon")
            .font(.system(size: 72))
            .padding()
    }
    struct DisplayColor: View {
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
