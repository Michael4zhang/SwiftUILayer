//
//  ContentView.swift
//  iOSDemo
//
//  Created by 张宇佳 on 2022/1/13.
//

import SwiftUI
import SwiftUILayer

struct ContentView: View {
    @State var show: Bool = false;
    @State var alertInfo: Bool = false;
    @State var alertInfo2: Bool = false;
    @State var pop: Bool = false;
    static var style = SwiftUILayerStyle(
        alignment: .center, closeOnTapCover: true, blur: .light, transition: .scale, animation: .easeInOut, shadow: LayerShadow(color: .black, radius: 5, x: 0, y: 0))
    
    
    @State var popStyle: SwiftUILayerStyle = style.copy();
    
    @State var height: CGFloat? = nil;
    @State var width: CGFloat? = nil;
    
    
    var body: some View {
        GeometryReader{geo in
            VStack{
                Spacer()
                HStack{
                    Button{
                        width = 300;
                        height = 300;
                        show.toggle()
                    }label: {
                        Text("Show layer")
                    }
                    .buttonStyle(.submitRounded)
                    Button{
                        alertInfo.toggle()
                    }label: {
                        Text("Show alert")
                    }
                    .buttonStyle(.submitRounded)
                    
                    Button{
                        alertInfo2.toggle()
                    }label: {
                        Text("Show alert")
                    }
                    .buttonStyle(.submitRounded)
                    
                    Button{
                        width = nil;
                        height = nil;
                        popStyle = ContentView.style.copy();
                        popStyle.alignment = .leading
                        popStyle.transition = .move(edge: .leading)
                        width = 300
                        pop.toggle()
                    }label: {
                        Text("左侧抽屉")
                    }
                    .buttonStyle(.submitRounded)
                }
                
                HStack{
                    Button{
                        width = nil;
                        height = nil;
                        popStyle = ContentView.style.copy();
                        popStyle.alignment = .top
                        popStyle.transition = .move(edge: .top)
                        height = 300
                        pop.toggle()
                    }label: {
                        Text("上抽屉")
                    }
                    .buttonStyle(.submitRounded)
                    
                    Button{
                        width = nil;
                        height = nil;
                        popStyle = ContentView.style.copy();
                        popStyle.alignment = .bottom
                        popStyle.transition = .move(edge: .bottom)
                        height = 300
                        pop.toggle()
                    }label: {
                        Text("下抽屉")
                    }
                    .buttonStyle(.submitRounded)
                    
                    Button{
                        width = nil;
                        height = nil;
                        popStyle = ContentView.style.copy();
                        popStyle.alignment = .trailing
                        popStyle.transition = .move(edge: .trailing)
                        width = 300
                        pop.toggle()
                    }label: {
                        Text("右侧抽屉")
                    }
                    .buttonStyle(.submitRounded)
                }
                Spacer()
            }
            
            .layer(isPresented: $show, style: ContentView.style) {
                VStack{
                    Spacer()
                    Text("Hello, world!")
                        .padding()
                    Spacer()
                }
                .frame(width: width == nil ? geo.frame(in: .local).width : width,
                       height: height == nil ? geo.frame(in: .local).height : height)
                .background(Color.blue)
            } onDismiss: {
                print("layer dismiss")
            }
            .layerAlert(isPresented: $alertInfo,content: {
                Text("This information")
            }, buttons: [
                LayerButton(title: "确定", action: {
                    print("OK")
                    alertInfo = false;
                })
            ])
            .layerAlert(isPresented: $alertInfo2, title: {
                Text("Information")
            }, content: {
                Text("HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello")
                    .padding()
            }, buttons: [
                LayerButton(title: "OK", action: {
                    print("OK")
                    alertInfo2 = false;
                }),
                LayerButton(title: "Cancel", action: {
                    print("is cancel")
                    alertInfo2 = false;
                })
            ])
            .layerPopup(isPresented: $pop,style: popStyle,
                          width: width == nil ? geo.frame(in: .local).width : width!,
                          height: height == nil ? geo.frame(in: .local).height : height!,
                          blur: .regular) {
                ZStack{
                    Spacer()
                    Text("左侧抽屉").fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
            }
        }
        .background(Color.green)
        .edgesIgnoringSafeArea(.all)
        
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct BlurEffectView: UIViewRepresentable {
    
    /// The style of the Blut Effect View
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
