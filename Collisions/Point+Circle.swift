//
//  Point+Circle.swift
//  CollisionEngine
//
//  Created by Kieran Brown on 3/7/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import CGExtender


struct Point_Circle: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    var r: CGFloat = 50
    
    func collisions(_ proxy: GeometryProxy, _ centers: [Int: [Anchor<CGPoint>]]) -> some View {
        let point = proxy[centers[1]!.first!]
        let circle = proxy[centers[2]!.first!]
        let screenCenterX = proxy.size.width/2
        let screenCenterY = proxy.size.height/2
        let offset = CGSize(width: circle.x - screenCenterX, height: circle.y - screenCenterY)
        let pOff = CGSize(width: point.x - screenCenterX, height: point.y - screenCenterY)
        
        return Group {
            if distance(point, circle) < r {
                ZStack {
                    Circle().fill(Color.orange).frame(width: 2*self.r, height: 2*self.r).allowsHitTesting(false).offset(offset)
                    Circle().fill(Color.blue).frame(width: 10, height: 10).allowsHitTesting(false).offset(pOff)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            CircleView(radius: r, id: 2)
            CircleView(radius: 5, id: 1)
        }.overlayPreferenceValue(Key.self) { (centers: [Int: [Anchor<CGPoint>]])  in
            GeometryReader { (proxy: GeometryProxy) in
                self.collisions(proxy, centers)
            }
        }
    }
}

struct Point_Circle_Previews: PreviewProvider {
    static var previews: some View {
        Point_Circle()
    }
}
