//
//  ContentView.swift
//  Knob
//
//  Created by Chris Eidhof on 05.11.19.
//  Copyright © 2019 Chris Eidhof. All rights reserved.
//

import SwiftUI

struct KnobShape: Shape {
    var pointerSize: CGFloat = 0.1 // these are relative values
    var pointerWidth: CGFloat = 0.1
    func path(in rect: CGRect) -> Path {
        let pointerHeight = rect.height * pointerSize
        let pointerWidth = rect.width * self.pointerWidth
        let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
        return Path { p in
            p.addEllipse(in: circleRect)
            p.addRect(CGRect(x: rect.midX - pointerWidth/2, y: 0, width: pointerWidth, height: pointerHeight + 2))
        }
    }
}

struct Knob: View {
    @Binding var value: Double // should be between 0 and 1

    var body: some View {
        print("Knob")
        return KnobShape()
            .fill(Color.primary)
            .rotationEffect(Angle(degrees: value * 330))
            .onTapGesture {
                withAnimation(.default) {
                    self.value = self.value < 0.5 ? 1 : 0
                }
            }
    }
}

struct ContentView: View {
    @State var volume: Double = 0.5
    var body: some View {
        print("ContentView")
        return VStack {

            Knob(value: $volume)
                .frame(width: 100, height: 100)

            // This button has a visual binding with `volume`, changes of `volume` will cause ContentView to redraw
            Button("Title: \(volume)") {
                volume += 0.1
            }

            // This button doesn't have a visual binding with `volume`, thus change of `volume` won't cause ContentView to redraw
            Button("Title:") {
                volume += 0.1
            }

        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
