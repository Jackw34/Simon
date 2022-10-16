//
//  ContentView.swift
//  Simon
//
//  Created by Jack W on 9/12/22.

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var colorDisplay = [ColorDisplay(color: .green), ColorDisplay(color: .red), ColorDisplay(color: .yellow), ColorDisplay(color: .blue)]
    @State private var flash = [false, false, false, false]
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State private var index = 0
    @State private var sequence = [Int]()
    @State private var rounds = 1...1000
    @State private var tapGet = -1
    @State private var userPlaying = false
    @State private var hasLost = false
    @State private var sequenceLocation = 0
    @State private var titleText = "Simon"
    @State private var player: AVAudioPlayer!
    
    
    var body: some View {
        ZStack {
            VStack {
                Text(titleText)
                    .font(Font.custom("impact", size: 40))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .preferredColorScheme(.dark)
                    .onReceive(timer) { _ in
                        if(sequence.count == 0) {
                            playSounds(sound: "Start")
                            index = 0
                            sequence.append(Int.random(in: 0...3))
                        }
                        if index < sequence.count {
                            flashColorDisplay(index: sequence[index])
                            index += 1
                        }
                        else {
                            Task {
                                
                                userPlaying = true
                                timer.upstream.connect().cancel()
                                await userInput()
                                if(!hasLost) {
                                    index = 0
                                    sequence.append(Int.random(in: 0...3))
                                }
                                
                                
                            }
                        }
                    }
                if(sequenceLocation >= 0) {
                    Text("High Score: \(sequence.count - 1)").font(Font.custom("impact", size: 14))
                }
                else {
                    Text("  ")
                    Text("  ")
                }
                Spacer()
                
                HStack {
                    colorDisplay[0]
                        .opacity(flash[0] ? 1 : 0.4)
                        .onTapGesture {
                            flashColorDisplay(index: 0)
                            tapGet = 0
                            buttonGo()
                        }
                    
                    
                    colorDisplay[1]
                        .opacity(flash[1] ? 1 : 0.4)
                        .onTapGesture {
                            flashColorDisplay(index: 1)
                            tapGet = 1
                            buttonGo()
                        }
                }
                HStack {
                    colorDisplay[2]
                        .opacity(flash[2] ? 1 : 0.4)
                        .onTapGesture {
                            flashColorDisplay(index: 2)
                            tapGet = 2
                            buttonGo()
                        }
                    
                    colorDisplay[3]
                        .opacity(flash[3] ? 1 : 0.4)
                        .onTapGesture {
                            flashColorDisplay(index: 3)
                            tapGet = 3
                            buttonGo()
                        }
                }
                Spacer()
                
                
                
                
                Button("Restart") {
                    timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
                    index = 0
                    sequence = [Int]()
                    rounds = 1...1000
                    tapGet = -1
                    userPlaying = false
                    hasLost = false
                    sequenceLocation = -1
                    titleText = "Simon"
                }.font(Font.custom("impact", size: 30))
                    .foregroundColor(.black)
                    .padding(5)
                    .background(.gray)
                    .cornerRadius(5.0)
                
                
                Spacer()
                
                
                
                
                
            }
        }
    }
    func buttonGo() {
        if(userPlaying) {
            if (sequenceLocation < sequence.count) {
                sequenceLocation += 1
            }
            
            if(sequenceLocation < sequence.count) {
                if(sequence[sequenceLocation] != tapGet) {
                    hasLost = true
                    userPlaying = false
                }
            }
        }
    }
    func playSounds(sound: String) {
        if let asset = NSDataAsset(name: sound){
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    func userInput() async {
        let playerTime = 1000000000
        try? await Task.sleep(nanoseconds: UInt64(playerTime))
        titleText = "Start Playing"
        if(sequence.count > 0) {
            let loopCount = 1...sequence.count
            
            for _ in loopCount {
                if(hasLost) {
                    titleText = "You Lost!"
                    playSounds(sound: "Lose")
                    try? await Task.sleep(nanoseconds: UInt64(playerTime))
                } else {
                    timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
                    tapGet = -1
                    sequenceLocation = -1
                    
                    titleText = "Simon"
                    
                }
                
                
                
                
            }
            func flashColorDisplay(index: Int) {
                playSounds(sound: String((index + 1) % 4))
                flash[index].toggle()
                withAnimation(.easeInOut(duration: 0.5)) {
                    flash[index].toggle()
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
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
    func flashColorDisplay(index: Int) {
        flash[index].toggle()
        withAnimation(.easeInOut(duration: 0.5)) {
            flash[index].toggle()
        }
    }
}

