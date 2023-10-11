//
//  OverlayExperiment.swift
//  SwiftUILayoutExperiments
//
//  Created by Hoang Cap on 11/10/2023.
//

import SwiftUI

struct OverlayExperiment: View {
    var body: some View {
        Circle()
            .stroke(Color.green, lineWidth: 2)
            .overlay(
                Circle()
                    .padding(EdgeInsets.init(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .foregroundColor(.green)
            )
            .overlay {
                Text("Hello")
                    .foregroundColor(.white)
            }
            .frame(width: 100, height: 100)

    }
}

struct OverlayExperiment_Previews: PreviewProvider {
    static var previews: some View {
        OverlayExperiment()
    }
}
