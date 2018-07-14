//
//  QGrayColorFilter.swift
//  TodayCamera
//
//  Created by Quinn_F on 2018/7/14.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit
import GPUImage


let shader =
"""
varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform highp float colorB;

void main()
{
lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
lowp vec4 outputColor;
outputColor.r = (textureColor.r * 0.393) + (textureColor.g * 0.769) + (textureColor.b * 0.189);
outputColor.g = (textureColor.r * 0.349) + (textureColor.g * 0.686) + (textureColor.b * 0.168);
//outputColor.b = (textureColor.r * 0.272) + (textureColor.g * 0.534) + (textureColor.b * 0.131);
outputColor.b = colorB;

outputColor.a = 1.0;

if (textureCoordinate.x > 0.5){
    gl_FragColor = outputColor;
}else{
    gl_FragColor = vec4(1.0,1.0,1.0,1.0);
}
}
"""

