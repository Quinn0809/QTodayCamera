//
//  CameraViewController.swift
//  TodayCamera
//
//  Created by Quinn_F on 2018/7/13.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit
import GPUImage
class CameraViewController: UIViewController {

    @IBOutlet weak var cameraModeControl: UISegmentedControl!
    @IBOutlet weak var renderView: GPUImageView!
    
    @IBOutlet weak var renderView_WH_Aspect: NSLayoutConstraint!
    @IBOutlet weak var controlsContainView: QNoResponseView!
    
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var effectView: UIVisualEffectView!
    var cameraController:CameraController?
    var filterController:FilterController?

    let filter:GPUImageFilter = GPUImageFilter.init(fragmentShaderFrom: shader)
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCameraController()
        configureFilterController()
        // Do any additional setup after loading the view.
        captureButton.layoutIfNeeded()
        captureButton.layer.cornerRadius = captureButton.frame.width/2
        captureButton.layer.masksToBounds = true
    }
    
    @IBAction func camerModeSwitch(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            changeUI_to_StillCamera()
        case 1:
            changeUI_to_VideoCamera()
        default:
            break
        }
        effectView.isHidden = false
        DispatchQueue.main.async {
            self.cameraController?.switchCameraMode(CameraMode(rawValue: sender.selectedSegmentIndex)!)
            self.configureFilterController()
            self.effectView.isHidden = true
        }
        
    }
    
}
//MARK:UIChange
extension CameraViewController{
    func changeUI_to_StillCamera(){
        

        UIView.animate(withDuration: 0.5) {
            self.renderView_WH_Aspect = self.renderView_WH_Aspect.setMultiplier(multiplier: 3.0/4.0)

            self.renderView.layoutIfNeeded()
        }
    }
    func changeUI_to_VideoCamera() {
        UIView.animate(withDuration: 0.5) {
            self.renderView_WH_Aspect = self.renderView_WH_Aspect.setMultiplier(multiplier: 9.0/16.0)

            self.renderView.layoutIfNeeded()
        }
    }
}
//MARK:CameraViewController
extension CameraViewController{
    func configureCameraController() {
        defer{
            cameraController?.startCapture()
        }
        cameraController = CameraController.init(cameraMode: .stillCamera)
    }
}
//MARK:
extension CameraViewController{
    func configureFilterController() {
        if let camera = cameraController?.camera{
            camera.removeAllTargets()
            camera.addTarget(renderView)
        }
    }
    func reConfigureFilter() {
        if let camera = cameraController?.camera{
            camera.removeAllTargets()
            camera.addTarget(renderView)
        }
    }
    
}
