//
//  File.swift
//  
//
//  Created by 张宇佳 on 2022/1/14.
//

import SwiftUI

private struct AlertView<E: View, T: View>: View{
    var title: (()-> E)? ;
    var content: ()-> T;
    var buttons : [LayerButton];
    var width: CGFloat = 250;
    var height: CGFloat = 200;
    var buttonHeight: CGFloat = 40;
    var titleHeight: CGFloat = 20;
    var contentHeight: CGFloat {
        return height - buttonHeight - titleHeight - 20 - 15;
    }
    
    var body: some View {
        VStack(spacing: 0){
            if let title = title {
                title()
                    .frame(height: titleHeight)
                Spacer()
            }
            content()
            Spacer()
            Rectangle().fill(.white).frame(height: 2)
                .padding(0)
            HStack(spacing: 0){
                ForEach(buttons.indices, id:\.self){ index in
                    Button{
                        if let action = buttons[index].action {
                            action()
                        }
                    }label: {
                        ZStack{
                            BlurEffectView(style: .regular)
                            Text(buttons[index].title)
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(height: buttonHeight)
                        }
                        .clipped()
                    }
                    .buttonStyle(.plain)
                    if(index+1 < buttons.count){
                        Rectangle()
                            .fill(.white)
                            .frame(width: 2,height: buttonHeight)
                    }
                }
            }
            
        }
        .padding(.top,15)
        .frame(width: width)
        .background(BlurEffectView(style: .regular))
        .cornerRadius(15)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            
        }
        .layerAlert(isPresented: .constant(true), content: {
            VStack{
                Text("This is information!")
                    .padding()
            }
        }, buttons: [
            LayerButton(title: "OK", action: {
                print("click ok")
            })
            ,
            LayerButton(title: "CN", action: {
                print("click ok")
            })
        ])
        .frame(width: 400, height: 500)
        
    }
}

public extension View{
    
    @ViewBuilder
    func layerAlert<T: View>(isPresented: Binding<Bool>,
                             content: @escaping ()-> T,
                             buttons: [LayerButton],
                             onDismiss: (()->Void)? = nil) -> some View {
        self.modifier(SwiftUILayer(isPresented: isPresented, style: alertStyle, content: {
            AlertView<T,T>(title: nil, content: content, buttons: buttons)
        }, onDismiss: onDismiss))
    }
    
    @ViewBuilder
    func layerAlert<E: View, T: View>(isPresented: Binding<Bool>,
                                      title: (() -> E)?,
                                      content: @escaping ()->T,
                                      buttons: [LayerButton],
                                      onDismiss: (()->Void)? = nil,
                                      style: SwiftUILayerStyle? = alertStyle)-> some View {
        self.modifier(
            SwiftUILayer(isPresented: isPresented, style: alertStyle, content: {
                AlertView(title: title, content: content , buttons: buttons)
            }, onDismiss: onDismiss))
    }
}




public let alertStyle = SwiftUILayerStyle(
    coverColor: Color.black.opacity(0.1),
    closeOnTapCover: false,
    blur: .regular,
    transition: .scale,
    animation: .easeInOut,
    shadow: .init(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 0)
)
