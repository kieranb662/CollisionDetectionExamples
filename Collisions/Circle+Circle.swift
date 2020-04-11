//
//  Circle+Circle.swift
//  CollisionEngine
//
//  Created by Kieran Brown on 3/7/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import CGExtender

struct Circle_Circle: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    let r1: CGFloat = 50.0
    let r2: CGFloat = 50.0
    
    func collisions(_ proxy: GeometryProxy, _ centers: [Int: [Anchor<CGPoint>]]) -> some View {
        let c1 = proxy[centers[1]!.first!]
        let c2 = proxy[centers[2]!.first!]
        let screenCenterX = proxy.size.width/2
        let screenCenterY = proxy.size.height/2
        let offset = CGSize(width: c1.x - screenCenterX, height: c1.y - screenCenterY)
        let pOff = CGSize(width: c2.x - screenCenterX, height: c2.y - screenCenterY)
        
        return Group {
            if distance(c1, c2) < r1+r2 {
                ZStack {
                    Circle().fill(Color.orange).frame(width: r1*2, height: r1*2).allowsHitTesting(false).offset(offset)
                    Circle().fill(Color.orange).frame(width: r2*2, height: r2*2).allowsHitTesting(false).offset(pOff)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            CircleView(radius: r1, id: 2)
            CircleView(radius: r2, id: 1)
        }.overlayPreferenceValue(Key.self) { (centers: [Int: [Anchor<CGPoint>]])  in
            GeometryReader { (proxy: GeometryProxy) in
                self.collisions(proxy, centers)
            }
        }
    }
}

struct Circle_Circle_Previews: PreviewProvider {
    static var previews: some View {
        Circle_Circle()
    }
}
