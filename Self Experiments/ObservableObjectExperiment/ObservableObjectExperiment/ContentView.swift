//
//  ContentView.swift
//  ObservableObjectExperiment
//
//  Created by Hoang Cap on 10/10/2023.
//

import SwiftUI

final class Clock: ObservableObject {

    init() {
        print("Clock init")
    }

    deinit {
        print("Clock deinit")
    }

    @Published var now: Date = Date()

    var timer: Timer?

    func startTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            self?.now = Date()
        })
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}


struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: { TimerView() }) {
                Text("Go to timer")
            }.navigationTitle("Some title")
        }
    }
}

struct TimerView: View {
    @ObservedObject var clock: Clock = .init()
    var body: some View {
        Text("\(clock.now)")
            .onAppear {
                clock.startTimer()
            }
            .onDisappear {
                clock.stopTimer()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
