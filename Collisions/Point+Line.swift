//
//  Point+Line.swift
//  MyExamples
//
//  Created by Kieran Brown on 4/2/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import CGExtender


struct Point_Line: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    
    func collisions(_ proxy: GeometryProxy, _ centers: [Int: [Anchor<CGPoint>]]) -> some View {
        let l1 = proxy[centers[1]!.first!]
        let l2 = proxy[centers[2]!.first!]
        let point  = proxy[centers[3]!.first!]
        // Distance from endPoints to point
        let d1: CGFloat = distance(l1, point)
        let d2: CGFloat = distance(l2, point)
        let buffer: CGFloat = 0.1
        let lineLength: CGFloat = distance(l1, l2)
        let screenCenterX = proxy.size.width/2
        let screenCenterY = proxy.size.height/2
        let pOffset = CGSize(width: point.x - screenCenterX, height: point.y - screenCenterY)
        
        return Group {
            if (d1+d2 >= lineLength-buffer && d1+d2 <= lineLength+buffer) {
                Line(from: l1, to: l2)
                    .stroke(Color.green, lineWidth: 5)
                    .allowsHitTesting(false)
                Circle()
                    .fill(Color.orange)
                    .frame(width: 10, height: 10)
                    .allowsHitTesting(false)
                    .offset(pOffset)
            } else {
                Line(from: l1, to: l2)
                .stroke(Color.yellow, lineWidth: 5)
                .allowsHitTesting(false)
            }
        }
    }

    var body: some View {
        ZStack {
            LineView(ids: (1, 2),
                     offset1: .zero, dragState1: .zero,
                     offset2: CGSize(width: 100, height: 200), dragState2: .zero)
            CircleView(radius: 5, id: 3)
        }.overlayPreferenceValue(Key.self) { (centers: [Int: [Anchor<CGPoint>]])  in
            GeometryReader { (proxy: GeometryProxy) in
                self.collisions(proxy, centers)
            }
        }
    }
}

struct Point_Line_Previews: PreviewProvider {
    static var previews: some View {
        Point_Line()
    }
}
