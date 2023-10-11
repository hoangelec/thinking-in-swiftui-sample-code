//
//  AlignmentGuideExperiment.swift
//  SwiftUILayoutExperiments
//
//  Created by Hoang Cap on 11/10/2023.
//

import SwiftUI

enum MyCenterID: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context.height
//        context.width
    }
}

extension VerticalAlignment {
    static let myCenter: VerticalAlignment = VerticalAlignment(MyCenterID.self)
}


struct AlignmentGuideExperiment: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AlignmentGuideExperiment_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .myCenter) {
            Rectangle().fill(Color.blue).frame(width: 50, height: 50)
            Rectangle().fill(Color.green).frame(width: 60, height: 30)
            Rectangle().fill(Color.red)
                .frame(width: 40, height: 40)
//                .alignmentGuide(.myCenter, computeValue: { d in
//                    return d[.myCenter] + 20
//                })
        }.border(Color.red, width: 1)

    }
}
