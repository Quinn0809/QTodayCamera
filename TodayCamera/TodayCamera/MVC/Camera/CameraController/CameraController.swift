//
//  CameraController.swift
//  TodayCamera
//
//  Created by Quinn_F on 2018/7/14.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit
import GPUImage
enum CameraMode:Int {
    case stillCamera
    case videoCamera
}

class CameraController: NSObject {
    
    var stillCameraController:StillCameraController? = nil
    var videoCameraController:VideoCameraController? = nil
    var cameraMode:CameraMode = .stillCamera
    weak var camera:GPUImageVideoCamera?{
        return cameraMode == .stillCamera ? stillCameraController?.camera : videoCameraController?.camera
    }

    init(cameraMode:CameraMode) {
        super.init()
        self.cameraMode = cameraMode
        switch cameraMode {
        case .stillCamera:
            stillCameraController = StillCameraController(position: .back)
        case .videoCamera:
            videoCameraController = VideoCameraController(position: .back)
        }
    }

    func switchCameraMode(_ mode:CameraMode){
        guard mode !=  cameraMode else {
            print("\(QuinnTags.guard_error)camera mode is equal")
            return
        }
        self.cameraMode = mode
        switch mode {
        case .stillCamera:
            if let stillCameraController = stillCameraController{
                stillCameraController.reloadCamera()
            }else{
                stillCameraController = StillCameraController.init(position: videoCameraController?.cameraPosition ?? .back)
            }

        case .videoCamera:
            if let videoCameraController = videoCameraController{
                videoCameraController.reloadCamera()
            }else{
                videoCameraController = VideoCameraController.init(position: stillCameraController?.cameraPosition ?? .back)
            }
        }
        startCapture()
    }
    
    func startCapture() {
        switch cameraMode {
        case .stillCamera:
            videoCameraController?.stopCamera()
            stillCameraController?.startCamera()
        case .videoCamera:
            stillCameraController?.stopCamera()
            videoCameraController?.startCamera()
        }
    }
}

//MARK: StillCameraController
extension CameraController{
    
}

//MARK: VideoCameraController
extension CameraController{
    
}
