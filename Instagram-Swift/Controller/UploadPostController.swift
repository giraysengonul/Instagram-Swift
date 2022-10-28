//
//  UploadPostController.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 21.10.2022.
//

import UIKit
protocol UploadPostControllerDelegate: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}
class UploadPostController: UIViewController {
    // MARK: - Properties
    weak var delegate: UploadPostControllerDelegate?
    var selectedImage: UIImage?{
        didSet{ photoImageView.image = selectedImage }
    }
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    private lazy var captionTextView: InputTextView = {
        let textView = InputTextView()
        textView.placeholdertext = "Enter caption.."
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
        return textView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
// MARK: - Helpers
extension UploadPostController{
    private func style(){
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapDone))
        //photoImageView style
        photoImageView.layer.cornerRadius = 10
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoImageView)
        //captionTextView style
        captionTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(captionTextView)
        //characterCountLabel style
        characterCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(characterCountLabel)
    }
    private func layout(){
        //photoImageView layout
        NSLayoutConstraint.activate([
            photoImageView.heightAnchor.constraint(equalToConstant: 180),
            photoImageView.widthAnchor.constraint(equalToConstant: 180),
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 8),
            photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        //captionTextView layout
        NSLayoutConstraint.activate([
            captionTextView.heightAnchor.constraint(equalToConstant: 64),
            captionTextView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
            captionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            view.trailingAnchor.constraint(equalTo: captionTextView.trailingAnchor, constant: 12)
        ])
        //characterCountLabel layout
        NSLayoutConstraint.activate([
            captionTextView.bottomAnchor.constraint(equalTo: characterCountLabel.bottomAnchor,constant: -8),
            view.trailingAnchor.constraint(equalTo: characterCountLabel.trailingAnchor, constant: 12),
        ])
    }
    private func checkMaxLength(_ textView: UITextView){
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
}
// MARK: - Selector
extension UploadPostController{
    @objc func didTapCancel(_ sender: UIBarButtonItem){
        dismiss(animated: true)
    }
    @objc func didTapDone(_ sender: UIBarButtonItem){
        guard let image = selectedImage else{ return }
        guard let caption = captionTextView.text else { return }
        PostService.uploadPost(caption: caption, image: image) { error in
            if let error = error{
                print("Failed to upload post with error \(error.localizedDescription)")
                return
            }
            self.delegate?.controllerDidFinishUploadingPost(self)
        }
    }
}
// MARK: - UITextViewDelegate
extension UploadPostController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}
