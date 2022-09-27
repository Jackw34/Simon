//
//  ContentView.swift
//  Simon
//
//  Created by Jack W on 9/12/22.
//

import SwiftUI
struct ContentView: View {
    var body: some View {
        //(.preferredColorScheme(.black))
        Text("Simon")
            .font(.system(size: 72))
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
