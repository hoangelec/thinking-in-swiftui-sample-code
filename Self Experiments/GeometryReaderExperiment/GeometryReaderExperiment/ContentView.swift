//
//  ContentView.swift
//  GeometryReaderExperiment
//
//  Created by Hoang Cap on 12/10/2023.
//

import SwiftUI
struct WidthKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?,
                       nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}

struct TextWithCircle: View {
    @State private var width: CGFloat? = nil
    var body: some View {
        Text("Hello there")
            .fixedSize()
            .background(
                GeometryReader { proxy in
                    Color.clear.preference(key: WidthKey.self, value: proxy.size.width) }
            )
            .onPreferenceChange(WidthKey.self) {
                self.width = $0
            }
            .frame(width: width, height: width)
            .padding()
            .background(Circle().fill(Color.blue))
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
