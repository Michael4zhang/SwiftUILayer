# SwiftUILayer

一个为SwiftUI编写的弹出层组件， 示例可查看iOSDemo，仅支持iOS14及以上，代码结构以及界面构成思路参考自: [SwiftUIOverlayContainer](https://github.com/fatbobman/SwiftUIOverlayContainer)

###  ViewStyle 

```swift
// 更多查看SwiftUILayerStyle
static var style = SwiftUILayerStyle(
        alignment: .center, closeOnTapCover: true, blur: .light, transition: .scale, animation: .easeInOut, shadow: LayerShadow(color: .black, radius: 5, x: 0, y: 0))
```



### Layer基础弹出框

```swift
MyView
	.layer(isPresented: $show, style: ContentView.style){
		VStack{
      Spacer()
      Text("Hello, world!")
      	.padding()
      Spacer()
    }
    .frame(
      width: width == nil ? geo.frame(in: .local).width : width,
      height: height == nil ? geo.frame(in: .local).height : height
    )
    .background(Color.blue)
	}
```



### Alert 弹窗

```swift
// 单个按钮
MyView.layerAlert(isPresented: $alertInfo,content: {
    Text("This information")
}, buttons: [
    LayerButton(title: "确定", action: {
        print("OK")
        alertInfo = false;
    })
])

// 多按钮， 多按钮会在底部均分宽度，最好只放两个以下
MyView.layerAlert(isPresented: $alertInfo2, title: {
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
```

### 抽屉

```swift
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


MyView.layerPopup(isPresented: $pop, style: popStyle,
                  width: width == nil ? geo.frame(in: .local).width : width!,
                  height: height == nil ? geo.frame(in: .local).height : height!,
                  blur: .regular) {
    ZStack{
        Spacer()
        Text("左侧抽屉").fixedSize(horizontal: false, vertical: true)
        Spacer()
    }
}
```



