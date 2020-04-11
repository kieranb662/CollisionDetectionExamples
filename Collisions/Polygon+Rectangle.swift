//
//  Polygon+Rectangle.swift
//  MyExamples
//
//  Created by Kieran Brown on 4/2/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import CGExtender

struct Polygon_Rectangle: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    var size: CGSize = CGSize(width: 100, height: 200)
    var vertices: [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: 100, y: 0), CGPoint(x: 120, y: 50), CGPoint(x: 65, y: 25)]
    
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
            if  polyRect(verts, point.x-self.size.width/2, point.y-self.size.height/2, self.size.width, self.size.height) {
                Polygon(vertices: verts)
                    .fill(Color.orange)
                    .allowsHitTesting(false)
                Rectangle()
                    .fill(Color.purple)
                    .frame(width: self.size.width, height: self.size.height)
                    .allowsHitTesting(false)
                    .offset(pOffset)
            }
        }
    }
    var body: some View {
        ZStack {
            RectangleView(size: self.size, id: 0)
            PolygonView(idStart: 1, vertices: vertices)
        }.overlayPreferenceValue(Key.self) { (centers: [Int: [Anchor<CGPoint>]])  in
            GeometryReader { (proxy: GeometryProxy) in
                self.collisions(proxy, centers)
            }
        }
    }
}

struct Polygon_Rectangle_Previews: PreviewProvider {
    static var previews: some View {
        Polygon_Rectangle()
    }
}
