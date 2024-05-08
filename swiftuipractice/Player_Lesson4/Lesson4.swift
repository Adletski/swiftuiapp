//
//  Lesson4.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 01.05.2024.
//

import AVFoundation
import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published public var maxDuration = 0.0
    private var player: AVAudioPlayer?
    private var songs = ["waydown", "deephouse", "skripka"]
    
    public func play() {
        playSong(name: songs[0])
        player?.play()
    }
    
    public func stop() {
        player?.stop()
    }
    
    public func nextSong() {
        
    }
    
    public func setTime(value: Float) {
        guard let time = TimeInterval(exactly: value) else { return }
        player?.currentTime = time
        player?.play()
    }
    
    private func playSong(name: String) {
        guard let audioPath = Bundle.main.path(forResource: name, ofType: "mp3") else { return }
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            maxDuration = player?.duration ?? 0.0
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Lesson4: View {
    
    @ObservedObject var viewModel = PlayerViewModel()
    
    @State private var progress: Float = 0
    @State private var onDownloadPressed = false
    @State private var onSharePressed = false
    private var trackName = "Неизвестный исполнитель"
    
    var body: some View {
        VStack {
            Image("forest")
                .padding(.top, 60)
            firstView
            secondView
            thirdView
            Spacer()
        }
        .background(.gray)
    }
    
    private var firstView: some View {
        HStack(spacing: 20) {
            Image("profile")
            VStack(alignment: .leading) {
                Text(trackName)
                Text("Звуки природы")
            }
            HStack(alignment: .top) {
                Button(action: {
                    onDownloadPressed = true
                }, label: {
                    Image("download")
                }).actionSheet(isPresented: $onDownloadPressed, content: {
                    ActionSheet(title: Text("\(trackName) - сохранен в папку загрузки."))
                })
                Button(action: {
                    onSharePressed = true
                }, label: {
                    Image("next")
                }).alert(isPresented: $onSharePressed, content: {
                    Alert(
                        title: Text("Поделиться?"),
                        primaryButton: .destructive(Text("Cancel")),
                        secondaryButton: .default(Text("OK")))
                })
            }.offset(y: -10)
        }
        .padding(.top, 48)
    }
    
    private var secondView: some View {
        HStack {
            Slider(value: Binding(get: {
                self.progress
            }, set: { newValue in
                print(newValue)
                self.progress = newValue
                self.viewModel.setTime(value: newValue)
            }), in: 0...100)
            
            Text(String(format: "%.1f", viewModel.maxDuration))
                .foregroundColor(.white)
        }.padding()
    }
    
    @State var isPlaying = false
    
    private var thirdView: some View {
        HStack(spacing: 50) {
            Button {
                print("back")
            } label: {
                Image("back")
            }
            Button {
                if isPlaying {
                    viewModel.stop()
                    isPlaying = false
                } else {
                    viewModel.play()
                    isPlaying = true
                }
            } label: {
                if isPlaying {
                    Image("pause")
                } else {
                    Image("play")
                }
            }
            Button {
                print("go")
            } label: {
                Image("go")
            }
        }
    }
}



#Preview {
    Lesson4()
}
