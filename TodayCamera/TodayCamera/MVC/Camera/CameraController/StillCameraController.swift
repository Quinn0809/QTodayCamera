//
//  StillCameraController.swift
//  TodayCamera
//
//  Created by Quinn_F on 2018/7/14.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit
import GPUImage
class StillCameraController: NSObject {
    var camera:GPUImageStillCamera? = nil
    var cameraPosition:AVCaptureDevice.Position = .front
    let preset:String = AVCaptureSessionPresetPhoto
    init(position:AVCaptureDevice.Position) {
        super.init()
        cameraPosition = position
        camera = GPUImageStillCamera.init(sessionPreset: preset, cameraPosition: cameraPosition)
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
            print("\(QuinnTags.guard_error)still camera is nil")
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
