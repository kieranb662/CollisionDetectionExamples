//
//  Point+Polygon.swift
//  MyExamples
//
//  Created by Kieran Brown on 4/2/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import CGExtender

struct Point_Polygon: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    var vertices: [CGPoint] = [CGPoint(x: 0, y: 0),
                               CGPoint(x: 100, y: 0),
                               CGPoint(x: 120, y: 50),
                               CGPoint(x: 65, y: 25)]
    
    func collisions(_ proxy: GeometryProxy, _ centers: [Int: [Anchor<CGPoint>]]) -> some View {
        var verts: [CGPoint] = []
        for i in 0..<vertices.count {
            verts.append(proxy[centers[1 + i]!.first!])
        }
        
        let point  = proxy[centers[0]!.first!]
        let screenCenterX = proxy.size.width/2
        let screenCenterY = proxy.size.height/2
        let pOffset = CGSize(width: point.x - screenCenterX, height: point.y - screenCenterY)
        
        return Group {
            if  polygonPoint(verts, point.x, point.y) {
                Polygon(vertices: verts)
                    .fill(Color.orange)
                    .allowsHitTesting(false)
                Circle()
                    .fill(Color.purple)
                    .frame(width: 10, height: 10)
                    .allowsHitTesting(false)
                    .offset(pOffset)
            }
        }
    }
    
    var body: some View {
        ZStack {
            PolygonView(idStart: 1, vertices: vertices)
            CircleView(radius: 5, id: 0)
        }.overlayPreferenceValue(Key.self) { (centers: [Int: [Anchor<CGPoint>]])  in
            GeometryReader { (proxy: GeometryProxy) in
                self.collisions(proxy, centers)
            }
        }
    }
}

struct Point_Polygon_Previews: PreviewProvider {
    static var previews: some View {
        Point_Polygon()
    }
}
