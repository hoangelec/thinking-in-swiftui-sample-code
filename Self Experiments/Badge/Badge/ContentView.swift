//
//  ContentView.swift
//  Badge
//
//  Created by Hoang Cap on 11/10/2023.
//

import SwiftUI

struct Badge: View {
    var value: Int?
    var badgeSize: CGFloat
    var body: some View {
        Group {
            if let value, value > 0 {
                ZStack {
                    Capsule()
                        .fill(.red)
                        .frame(width: badgeSize, height: badgeSize)
                    Text("\(value < 10 ? "\(value)" : "10+" )")
                        .foregroundColor(.white)
                        .font(.footnote)
                        .bold()

                }
            }
        }
    }
}

extension View {
    private static var defaultBadgeSize: CGFloat { 30 }
    func badge(value: Int?, badgeSize: CGFloat = defaultBadgeSize) -> some View {
        overlay(alignment: .topTrailing) {
            Badge(value: value, badgeSize: badgeSize)
                .offset(.init(width: badgeSize / 2, height: -(badgeSize / 2)))
//                .frame(width: badgeSize, height: badgeSize)
        }

    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello")
        .padding()
        .border(.blue)
        .badge(value: 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.layoutDirection, .rightToLeft)
    }
}
