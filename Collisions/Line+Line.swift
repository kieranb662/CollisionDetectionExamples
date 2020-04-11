//
//  Line+Line.swift
//  MyExamples
//
//  Created by Kieran Brown on 4/2/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import CGExtender

struct Line_Line: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    
    func collisions(_ proxy: GeometryProxy, _ centers: [Int: [Anchor<CGPoint>]]) -> some View {
        let l1 = proxy[centers[1]!.first!]
        let l2 = proxy[centers[2]!.first!]
        let l3 = proxy[centers[3]!.first!]
        let l4 = proxy[centers[4]!.first!]
        
        return Group {
            if lineLine(l1.x, l1.y, l2.x, l2.y, l3.x, l3.y, l4.x, l4.y) {
                ZStack {
                    Line(from: l1, to: l2)
                    .stroke(Color.green, lineWidth: 5)
                    .allowsHitTesting(false)
                    Line(from: l3, to: l4)
                    .stroke(Color.green, lineWidth: 5)
                    .allowsHitTesting(false)
                }
            } else {
                ZStack {
                    Line(from: l1, to: l2)
                    .stroke(Color.blue, lineWidth: 5)
                    .allowsHitTesting(false)
                    Line(from: l3, to: l4)
                    .stroke(Color.blue, lineWidth: 5)
                    .allowsHitTesting(false)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            LineView(radius: 5, ids: (1,2), offset1: .zero, dragState1: .zero, offset2: CGSize(width: 100, height: 100), dragState2: .zero)
            LineView(radius: 5, ids: (3,4), offset1: CGSize(width: 200, height: 400), dragState1: .zero, offset2: CGSize(width: 100, height: 100), dragState2: .zero)
        }.overlayPreferenceValue(Key.self) { (centers: [Int: [Anchor<CGPoint>]])  in
            GeometryReader { (proxy: GeometryProxy) in
                self.collisions(proxy, centers)
            }
        }
    }
}

struct Line_Line_Previews: PreviewProvider {
    static var previews: some View {
        Line_Line()
    }
}
