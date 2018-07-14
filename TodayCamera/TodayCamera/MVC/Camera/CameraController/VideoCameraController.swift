//
//  VideoCameraController.swift
//  TodayCamera
//
//  Created by Quinn_F on 2018/7/14.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit
import GPUImage
class VideoCameraController: NSObject {

    var camera:GPUImageVideoCamera? = nil
    var cameraPosition:AVCaptureDevice.Position = .front
    let preset:String = AVCaptureSessionPresetHigh

    init(position:AVCaptureDevice.Position) {
        super.init()
        cameraPosition = position
        camera = GPUImageVideoCamera.init(sessionPreset: AVCaptureSessionPresetHigh, cameraPosition: cameraPosition)
        camera?.outputImageOrientation = .portrait
    }
    
    func startCamera() {
        camera?.startCapture()
    }
    func stopCamera() {
        camera?.stopCapture()
    }
    func reloadCamera() {
        guard let camera = camera else{
            print("\(QuinnTags.guard_error)video camera is nil")
            return
        }
        camera.captureSession.beginConfiguration()
        if camera.captureSession.canSetSessionPreset(preset){
            camera.captureSession.sessionPreset = preset
        }
        camera.captureSession.commitConfiguration()
    }
    func changeCameraDirection(position:AVCaptureDevice.Position){
        if position == camera?.cameraPosition(){
            return
        }
        camera?.rotateCamera()
        cameraPosition = camera?.cameraPosition() ?? .front
    }
}
