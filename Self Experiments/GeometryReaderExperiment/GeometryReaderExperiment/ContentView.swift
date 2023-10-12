//
//  ContentView.swift
//  GeometryReaderExperiment
//
//  Created by Hoang Cap on 12/10/2023.
//

import SwiftUI
struct WidthKey: PreferenceKey {
    static let defaultValue: CGSize? = nil
    static func reduce(value: inout CGSize?,
                       nextValue: () -> CGSize?) {
        value = value ?? nextValue()
    }
}

struct TextWithCircle: View {
    @State private var size: CGSize? = nil
    var body: some View {
        Text("Hello there")
            .fixedSize()
            .background(
                GeometryReader { proxy in
                    Color.clear.preference(key: WidthKey.self, value: proxy.size) }
            )
            .onPreferenceChange(WidthKey.self) {
                self.size = $0
            }
            .frame(width: size?.width, height: size?.height)
            .padding()
            .background(Capsule().fill(Color.blue))
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            TextWithCircle()
        }
        .padding()
    }
}

struct View_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
