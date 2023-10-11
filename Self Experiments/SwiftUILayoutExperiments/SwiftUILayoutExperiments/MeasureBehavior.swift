//
//  MeasureBehavior.swift
//  SwiftUILayoutExperiments
//
//  Created by Hoang Cap on 11/10/2023.
//

import SwiftUI

struct MeasureBehavior<Content: View>: View {

    @State var width: CGFloat = 100
    @State var height: CGFloat = 100

    var content: Content
    init(content: Content) {
        self.content = content
    }

    var body: some View {
        VStack {
            content
                .border(Color.green, width: 0.5)
                .frame(width: width, height: height)
                .border(Color.black)
                .frame(width: UIScreen.main.bounds.width, height:  501)
                .background(Color.blue)
            HStack {
                Text("Width \(Int(width))")
                Slider(value: $width, in: 0...300)
            }
            HStack {
                Text("Height")
                Slider(value: $height, in: 0...500)
            }
        }

    }
}

struct MeasureBehavior_Previews: PreviewProvider {
    static var previews: some View {
        MeasureBehavior(
            content: {
                HStack {
                    Text("Hello, World")
                        .fixedSize()
                        .layoutPriority(2)
                    Rectangle().fill(Color.red)
//                        .frame(minWidth: 50)
                }
            }()
        )
        .padding()
    }
}
