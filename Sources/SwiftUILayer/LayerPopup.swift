//
//  File.swift
//  
//
//  Created by 张宇佳 on 2022/1/14.
//

import Foundation
import SwiftUI

public extension View{
    @ViewBuilder
    func layerPopup<T:View>(isPresented: Binding<Bool>,
                            style: SwiftUILayerStyle,
                            width: CGFloat,
                            height: CGFloat,
                            blur: UIBlurEffect.Style? = nil,
                            bgColor: Color? = nil,
                            content: @escaping ()-> T) -> some View{
        self.modifier(SwiftUILayer(isPresented: isPresented, style: style, content: {
            LayerPopup(height: height, width: width, blur: blur , bgColor: bgColor, content: content)
        }))
    }
}


struct LayerPopup<T:View>: View{
    var height: CGFloat;
    var width: CGFloat;
    var blur: UIBlurEffect.Style?
    var bgColor: Color?
    var content: ()-> T;
    
    
    var body: some View{
        ZStack{
            if(blur != nil){
                BlurEffectView(style: blur!)
            }else if(bgColor != nil){
                Rectangle()
                    .fill(bgColor!)
            }
            VStack{
                content()
                Text("width=\(width)")
            }
        }
        .frame(width: width,height: height)
        .ignoresSafeArea()
    }
}
//
//struct LayerPopup_Preview: PreviewProvider{
//    @State static var show = true;
//    static var previews: some View {
//        Button{
//            show.toggle()
//        }label: {
//            Text("Show")
//        }
//        .layerPopup(isPresented: $show, style: style) {
//            Text("OK")
//        }
//    }
//}
