//
//  Rectangle+Rectangle.swift
//  CollisionEngine
//
//  Created by Kieran Brown on 3/7/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import CGExtender

struct Rectangle_Rectangle: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    let r1: CGSize = CGSize(width: 100, height: 200)
    let r2: CGSize = CGSize(width: 200, height: 100)
    
    
    func collisions(_ proxy: GeometryProxy, _ centers: [Int: [Anchor<CGPoint>]]) -> some View {
        let rect1 = proxy[centers[1]!.first!]
        let rect2 = proxy[centers[2]!.first!]
        let screenCenterX = proxy.size.width/2
        let screenCenterY = proxy.size.height/2
        let offset = CGSize(width: rect1.x - screenCenterX, height: rect1.y - screenCenterY)
        let pOff = CGSize(width: rect2.x - screenCenterX, height: rect2.y - screenCenterY)
        
        return Group {
            if rectRect(rect1.x-r1.width/2, rect1.y-r1.height/2, r1.width, r1.height, rect2.x-r2.width/2, rect2.y-r2.height/2, r2.width, r2.height) {
                ZStack {
                    Rectangle().fill(Color.orange).frame(width: r1.width, height: r1.height).allowsHitTesting(false).offset(offset)
                    Rectangle().fill(Color.green).frame(width: r2.width, height: r2.height).allowsHitTesting(false).offset(pOff)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            RectangleView(size: r1, id: 1)
            RectangleView(size: r2, id: 2)
        }.overlayPreferenceValue(Key.self) { (centers: [Int: [Anchor<CGPoint>]])  in
            GeometryReader { (proxy: GeometryProxy) in
                self.collisions(proxy, centers)
            }
        }
    }
}

struct Rectangle_Rectangle_Previews: PreviewProvider {
    static var previews: some View {
        Rectangle_Rectangle()
    }
}
