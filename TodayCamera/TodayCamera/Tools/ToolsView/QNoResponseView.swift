//
//  QNoResponseView.swift
//  TodayCamera
//
//  Created by Quinn_F on 2018/7/14.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit

class QNoResponseView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event);
        if (view == self) {
            return nil
        }
        return view
    }
}
