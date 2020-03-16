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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pick", style: .plain, target: self, action: #selector(pickAnImage))
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
