//
//  Circle+Rectangle.swift
//  CollisionEngine
//
//  Created by Kieran Brown on 3/7/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import CGExtender

struct Circle_Rectangle: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    let size: CGSize = CGSize(width: 100, height: 200)
    let r: CGFloat = 50
    
    func collisions(_ proxy: GeometryProxy, _ centers: [Int: [Anchor<CGPoint>]]) -> some View {
        let rect = proxy[centers[1]!.first!]
        let center = proxy[centers[2]!.first!]
        let screenCenterX = proxy.size.width/2
        let screenCenterY = proxy.size.height/2
        let offset = CGSize(width: rect.x - screenCenterX, height: rect.y - screenCenterY)
        let pOff = CGSize(width: center.x - screenCenterX, height: center.y - screenCenterY)

        return Group {
            if circleRect(center.x, center.y, r, rect.x-size.width/2, rect.y-size.height/2, size.width, size.height) {
                ZStack {
                    Rectangle().fill(Color.orange).frame(width: size.width, height: size.height).allowsHitTesting(false).offset(offset)
                    Circle().fill(Color.green).frame(width: r*2, height: r*2).allowsHitTesting(false).offset(pOff)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            RectangleView(size: size, id: 1)
            CircleView(radius: r, id: 2)
        }.overlayPreferenceValue(Key.self) { (centers: [Int: [Anchor<CGPoint>]])  in
            GeometryReader { (proxy: GeometryProxy) in
                self.collisions(proxy, centers)
            }
        }
    }
}

struct Circle_Rectangle_Previews: PreviewProvider {
    static var previews: some View {
        Circle_Rectangle()
    }
}
