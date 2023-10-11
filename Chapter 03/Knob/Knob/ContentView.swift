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

class A {
    var int: Int
    var bool: Bool

    init(int: Int, bool: Bool) {
        self.int = int
        self.bool = bool
    }
}

enum AKey: EnvironmentKey {
    static let defaultValue: A = .init(int: 0, bool: false)
}

extension EnvironmentValues {
    var aEnvironment: A {
        get { self[AKey.self] }
        set { self[AKey.self] = newValue }
    }
}


fileprivate enum PointerSizeKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0.3
}

fileprivate enum KnobHueKey: EnvironmentKey {
    static let defaultValue: CGFloat? = nil
}

extension EnvironmentValues {
    var knobPointerSize: CGFloat {
        get { self[PointerSizeKey.self] }
        set { self[PointerSizeKey.self] = newValue }
    }

    var knobHue: CGFloat? {
        get { self[KnobHueKey.self] }
        set { self[KnobHueKey.self] = newValue }
    }
}

extension View {
    func knobPointerSize(_ size: CGFloat) -> some View {
        self.environment(\.knobPointerSize, size)
    }

    func knobHue(_ hue: CGFloat) -> some View {
        self.environment(\.knobHue, hue)
    }
}

struct Knob: View {
    @Binding var value: Double // should be between 0 and 1
    var pointerSize: CGFloat? = nil
    @Environment(\.knobPointerSize) var envPointerSize
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.aEnvironment) var a
    @Environment(\.knobHue) var envKnobHue

    private var knobFillColor: Color {
        if let envKnobHue {
            return Color(hue: envKnobHue, saturation: 1, brightness: 1)
        } else {
            let schemeColor = colorScheme == .dark ? Color.white : .black
            return schemeColor
        }
    }

    var body: some View {
        ZStack {
            KnobShape(pointerSize: pointerSize ?? envPointerSize)
               .fill(knobFillColor)
               .rotationEffect(Angle(degrees: value * 330))
               .onTapGesture {
                   withAnimation(.default) {
                       self.value = self.value < 0.5 ? 1 : 0
                   }
               }
            Text("\(a.int)")
                .foregroundColor(colorScheme == .dark ? Color.black : .white)
        }

    }
}

struct ContentView: View {
    @State var value: Double = 0.5
    @State var knobSize: CGFloat = 0.2
    @State var knobHue: CGFloat = 0
    @Environment(\.aEnvironment) var a

    var body: some View {
        VStack {
            Knob(value: $value)
                .frame(width: 100, height: 100)
                .knobPointerSize(knobSize)
                .knobHue(knobHue)

            HStack {
                Text("Value: \(a.int)")
                Slider(value: $value, in: 0...1)
            }
            HStack {
                Text("Knob Size")
                Slider(value: $knobSize, in: 0...0.4)
            }

            HStack {
                Text("Knob hue")
                Slider(value: $knobHue, in: 0...0.8)
            }

            Button("Toggle", action: {
                withAnimation(.default) {
                    value = value == 0 ? 1 : 0
                    a.int += 1
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
