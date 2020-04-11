//
//  Line+Rect.swift
//  MyExamples
//
//  Created by Kieran Brown on 4/2/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI
import CGExtender


struct Line_Rect: View {
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    var size: CGSize = CGSize(width: 100, height: 250)
     
     func collisions(_ proxy: GeometryProxy, _ centers: [Int: [Anchor<CGPoint>]]) -> some View {
        let center = proxy[centers[1]!.first!]
         let l1 = proxy[centers[2]!.first!]
         let l2 = proxy[centers[3]!.first!]
         let screenCenterX = proxy.size.width/2
         let screenCenterY = proxy.size.height/2
         let offset = CGSize(width: center.x - screenCenterX, height: center.y - screenCenterY)
    
         return Group {
            if lineRect(l2.x, l2.y, l1.x, l1.y, center.x-self.size.width/2, center.y-self.size.height/2, self.size.width, self.size.height) {
                 ZStack {
                    Rectangle()
                        .fill(Color.orange)
                        .frame(width: size.width, height: size.height)
                        .allowsHitTesting(false)
                        .offset(offset)
                     Line(from: l1, to: l2)
                     .stroke(Color.green, lineWidth: 5)
                     .allowsHitTesting(false)
                     
                 }
             } else {
                 ZStack {
                     Line(from: l1, to: l2)
                     .stroke(Color.blue, lineWidth: 5)
                     .allowsHitTesting(false)
                     
                 }
             }
         }
     }
     
     
     var body: some View {
         ZStack {
            RectangleView(size: self.size, id: 1)
             LineView(radius: 5, ids: (2,3), offset1: CGSize(width: 200, height: 400), dragState1: .zero, offset2: CGSize(width: 100, height: 100), dragState2: .zero)
         }.overlayPreferenceValue(Key.self) { (centers: [Int: [Anchor<CGPoint>]])  in
             GeometryReader { (proxy: GeometryProxy) in
                 self.collisions(proxy, centers)
             }
         }
     }
}

struct Line_Rect_Previews: PreviewProvider {
    static var previews: some View {
        Line_Rect()
    }
}
