//
//  ImagePickerVC.swift
//  iosDemo
//
//  Created by Kyle on 2020/3/16.
//  Copyright © 2020 KyleBing. All rights reserved.
//

import UIKit

/// 0. 这个 ViewController  需要实现 UIImagePickerControllerDelegate 和 UINavigationControllerDelegate 两个协议
class ImagePickerVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// 1. 新建 UIImagePickerController 对象
    var imagePicker: UIImagePickerController = UIImagePickerController()
    lazy var imageView = UIImageView(frame: view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btnPick = UIBarButtonItem(title: "Pick", style: .plain, target: self, action: #selector(pickAnImage))
        let btnLayerClip = UIBarButtonItem(title: "Clip", style: .plain, target: self, action: #selector(clipImage))
        navigationItem.rightBarButtonItems = [btnLayerClip, btnPick]

        /// 2. 设置 picker 的 delegate 和 相关设置
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        /// 3. 设置 imageView 的属性
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }
    
    
    @objc func pickAnImage(){
        /// 4. 点击选图片时，展示这个 picker controller
        present(imagePicker, animated: true) {
            print("UIImagePickerController: presented")
        }
    }
    
    @objc func clipImage() {
//        imageView.layer.cornerRadius = 10 // 可以设置 view 的 radius
        
        if imageView.layer.mask != nil, let sublayers = imageView.layer.sublayers{
            // 删除 mask 和 边框
            imageView.layer.mask = nil
            for layer in sublayers {
                layer.removeFromSuperlayer()
            }
        } else {
            // 添加 mask 和 边框
            let frameHeight:CGFloat = 200
            let frameEdge:CGFloat = 30
            let frameRect = CGRect(x: frameEdge,
                                   y: (imageView.frame.size.height - frameHeight)/2,
                                   width: imageView.frame.size.width - frameEdge * 2,
                                   height: frameHeight)
            // add mask
            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(roundedRect: frameRect, cornerRadius: 10).cgPath
            imageView.layer.mask = maskLayer
            
            // add a frame
            let frameLayer = CAShapeLayer()
            frameLayer.lineWidth = 3
            frameLayer.fillColor = UIColor.clear.cgColor // calayer 默认填充颜色是纯黑色
            frameLayer.strokeColor = UIColor.orange.cgColor
            frameLayer.path = UIBezierPath(roundedRect: frameRect, cornerRadius: 10).cgPath
            imageView.layer.addSublayer(frameLayer) // 添加 frameLayer 到最顶层 Layer
        }
        
    }

    
    // MARK: - Image picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /// 5. 用户选中一张图片时触发这个方法，返回关于选中图片的 info
        /// 6. 获取这张图片中的 originImage 属性，就是图片本身
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("error: did not picked a photo")
        }
        /// 7. 根据需要做其它相关操作，这里选中图片以后关闭 picker controller 即可
        picker.dismiss(animated: true) { [unowned self] in
            // add a image view on self.view
            self.imageView.image = selectedImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        /// 8. 用户点击取消时
        picker.dismiss(animated: true) {
            print("UIImagePickerController: dismissed")
        }
    }
    
    
    
    
}
