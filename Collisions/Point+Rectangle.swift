//
//  Point+Rectangle.swift
//  CollisionEngine
//
//  Created by Kieran Brown on 3/7/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import CGExtender


struct Point_Rectangle: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    var size: CGSize = CGSize(width: 100, height: 200)
    
    func collisions(_ proxy: GeometryProxy, _ centers: [Int: [Anchor<CGPoint>]]) -> some View {
        let point = proxy[centers[1]!.first!]
        let rect = proxy[centers[2]!.first!]
        let screenCenterX = proxy.size.width/2
        let screenCenterY = proxy.size.height/2
        let offset = CGSize(width: rect.x - screenCenterX, height: rect.y - screenCenterY)
        let pOff = CGSize(width: point.x - screenCenterX, height: point.y - screenCenterY)
        
        return Group {
            if pointRect(point.x, point.y, rect.x-size.width/2, rect.y-size.height/2, size.width, size.height) {
                ZStack {
                    Rectangle().fill(Color.orange).frame(width: size.width, height: size.height).allowsHitTesting(false).offset(offset)
                    Circle().fill(Color.blue).frame(width: 5*2, height: 5*2).allowsHitTesting(false).offset(pOff)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            RectangleView(size: size, id: 2)
            CircleView(radius: 5, id: 1)
        }.overlayPreferenceValue(Key.self) { (centers: [Int: [Anchor<CGPoint>]])  in
            GeometryReader { (proxy: GeometryProxy) in
                self.collisions(proxy, centers)
            }
        }
    }
}

struct Point_Rectangle_Previews: PreviewProvider {
    static var previews: some View {
        Point_Rectangle()
    }
}
