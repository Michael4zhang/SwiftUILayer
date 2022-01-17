//
//  File.swift
//  
//
//  Created by 张宇佳 on 2022/1/13.
//

import Foundation
import SwiftUI

public struct SwiftUILayerStyle{
    public init(coverColor: Color? = nil, alignment: Alignment = .center, closeOnTapCover: Bool = true, blur: UIBlurEffect.Style? = nil, transition: AnyTransition? = nil, animation: Animation? = nil, shadow: LayerShadow? = nil) {
        self.coverColor = coverColor
        self.alignment = alignment
        self.closeOnTapCover = closeOnTapCover
        self.blur = blur
        self.transition = transition
        self.animation = animation
        self.shadow = shadow
    }
    
    public static let _default: SwiftUILayerStyle = SwiftUILayerStyle.getDefault()
    
    // 遮罩层颜色
    public var coverColor: Color?;
    // 停靠位置
    public var alignment: Alignment = .center
    // 点击遮罩或模糊层时是否关闭弹窗
    public var closeOnTapCover: Bool = true
    // 遮罩层样式
    public var blur: UIBlurEffect.Style?
    // 动画配置
    public var transition: AnyTransition?
    public var animation: Animation?
    // 阴影
    public var shadow: LayerShadow?
    
    
    public func copy() -> SwiftUILayerStyle{
        return SwiftUILayerStyle(coverColor: self.coverColor, alignment: self.alignment, closeOnTapCover: self.closeOnTapCover,
                                 blur: self.blur, transition: self.transition , animation: self.animation  , shadow: self.shadow);
    }
    
    private static func getDefault() -> SwiftUILayerStyle {
        return SwiftUILayerStyle()
    }
}


public struct LayerShadow {
    public init(color:Color = Color(.sRGBLinear, white: 0, opacity: 0.33),radius:CGFloat = 10,x:CGFloat = 4,y:CGFloat = 0 ) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
    
    var color: Color;
    var radius: CGFloat;
    var x: CGFloat;
    var y: CGFloat
}
