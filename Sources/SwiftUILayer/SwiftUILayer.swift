import SwiftUI
import CommonExtension

public struct SwiftUILayer<T: View>: ViewModifier {
    private var def = SwiftUILayerStyle._default;
    @Binding var isPresented: Bool;
    @State var enabled = true;
    var style: SwiftUILayerStyle;
    var child: AnyView;
    var onDismiss:(()->Void)?
    
    public init(isPresented: Binding<Bool>, style: SwiftUILayerStyle, content child: ()->T){
        self.style = style;
        self.child = AnyView(child());
        self._isPresented = isPresented
    }
    
    public init(isPresented: Binding<Bool>, style: SwiftUILayerStyle, content child: ()->T, onDismiss: (()->Void)? ){
        self.style = style;
        self.child = AnyView(child());
        self._isPresented = isPresented
        self.onDismiss = onDismiss
    }
    
    public func closeLayer() {
        self.isPresented = false
        onDismiss?()
    }
    
    
    public func body(content: Content) -> some View {
        return ZStack{
            Color.clear.zIndex(0.1)
            content.zIndex(0.2)
            ZStack(alignment: style.alignment){
                ZStack{
                    // 1. 遮罩层
                    if(style.coverColor != nil) {
                        Rectangle()
                            .fill(style.coverColor!)
                            .opacity(isPresented ? 1.0 : 0)
                            .ignoresSafeArea()
                            .zIndex(2.1)
                            .onTapGesture {
                                if(style.closeOnTapCover){
                                    closeLayer()
                                }
                            }
                    }
                    // 2. 模糊层
                    if style.blur != nil {
#if os(iOS)
                        BlurEffectView(style:style.blur!)
                            .transition(.opacity)
                            .opacity(isPresented ? 1.0 : 0)
                            .debugPrint(value: "Show blur OK")
                            .zIndex(2.2)
                            .onTapGesture {
                                if(style.closeOnTapCover){
                                    closeLayer()
                                }
                            }
                        
#endif
#if os(macOS)
                        BlurEffectView(material: .fullScreenUI)
                            .transition(.opacity)
                            .opacity(isPresented ? 1.0 : 0)
                            .zIndex(2.2)
                            .onTapGesture {
                                if(style.closeOnTapCover){
                                    closeLayer()
                                }
                            }
#endif
                    }
                }
                .zIndex(1.1)
                
                if(isPresented) {
                    // 3. 子元素
                    child
                        .fixedSize()
                        .ignoresSafeArea()
                        .animation(style.animation ?? .none)
                        .ifLet(style.transition, transform: {$0.transition($1)})
                        .zIndex(1.2)
                        .ifLet(style.shadow, transform: {$0.shadow(color: $1.color, radius: $1.radius, x: $1.x, y: $1.y)})
                }
            }
            .zIndex(0.3)
            .animation(style.animation ?? nil)
            .transition(.opacity)
        }
    }
}



public extension View{
    @ViewBuilder
    func layer<T: View>(isPresented: Binding<Bool>,
                        style: SwiftUILayerStyle,
                        content: @escaping ()-> T,
                        onDismiss: (()->Void)?) -> some View{
        self.modifier(SwiftUILayer<T>(isPresented: isPresented, style: style, content: content,onDismiss: onDismiss))
    }
    
    @ViewBuilder
    func layer<T: View>(isPresented: Binding<Bool>,
                        style: SwiftUILayerStyle,
                        content: @escaping ()-> T) -> some View{
        self.modifier(SwiftUILayer<T>(isPresented: isPresented, style: style, content: content))
    }
}

public struct LayerButton {
    public init(title: String, action: LayerButton.Action? = nil) {
        self.title = title
        self.action = action
    }
    
    public typealias Action = ()->Void;
    var title: String;
    var action: Action?;
}




#if os(iOS)
internal struct BlurEffectView: UIViewRepresentable {
    
    /// The style of the Blut Effect View
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
#endif

#if os(macOS)
internal struct BlurEffectView: NSViewRepresentable
{
    var material: NSVisualEffectView.Material
    var blendingMode: NSVisualEffectView.BlendingMode = .withinWindow
    
    func makeNSView(context: Context) -> NSVisualEffectView
    {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
        visualEffectView.state = NSVisualEffectView.State.active
        return visualEffectView
    }
    
    func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context)
    {
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
    }
}
#endif

#if os(iOS)
public typealias BlurEffect = UIBlurEffect.Style
#endif
#if os(macOS)
public typealias BlurEffect = NSVisualEffectView.Material
#endif

