//
//  Line+Circle.swift
//  MyExamples
//
//  Created by Kieran Brown on 4/2/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import CGExtender

struct Line_Circle: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    let r: CGFloat = 50.0
    
    func collisions(_ proxy: GeometryProxy, _ centers: [Int: [Anchor<CGPoint>]]) -> some View {
        let center = proxy[centers[1]!.first!]
        let l1 = proxy[centers[2]!.first!]
        let l2 = proxy[centers[3]!.first!]
        let screenCenterX = proxy.size.width/2
        let screenCenterY = proxy.size.height/2
        let cOffset = CGSize(width: center.x - screenCenterX, height: center.y - screenCenterY)
        
        return Group {
            if lineCircle(l1.x, l1.y, l2.x, l2.y, center.x, center.y, r) {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 100, height: 100)
                    .allowsHitTesting(false)
                    .offset(cOffset)
                
                Line(from: l1, to: l2)
                    .stroke(Color.green, lineWidth: 5)
                    .allowsHitTesting(false)
            } else {
                Line(from: l1, to: l2)
                    .stroke(Color.yellow, lineWidth: 5)
                    .allowsHitTesting(false)
            }
        }
    }
    
    var body: some View {
        ZStack {
            CircleView(radius: r, id: 1)
            LineView(radius: 5, ids: (2,3), offset1: .zero, dragState1: .zero, offset2: CGSize(width: 100, height: 200), dragState2: .zero)
        }.overlayPreferenceValue(Key.self) { (centers: [Int: [Anchor<CGPoint>]])  in
            GeometryReader { (proxy: GeometryProxy) in
                self.collisions(proxy, centers)
            }
        }
    }
}

struct Line_Circle_Previews: PreviewProvider {
    static var previews: some View {
        Line_Circle()
    }
}
