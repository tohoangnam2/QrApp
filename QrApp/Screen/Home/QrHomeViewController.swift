import UIKit
import AVFoundation
import Foundation

class QrHomeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cameraQR: UIView!
    @IBOutlet weak var flash: UIButton!
    @IBOutlet weak var zoomSlider: UISlider!
    @IBOutlet weak var changeCamera: UIButton!
    @IBOutlet weak var topNavView: UIView!

    @IBOutlet weak var topStackview: UIStackView!
    @IBOutlet weak var libraryImage: UIButton!

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var currentInput: AVCaptureDeviceInput!
    var isUsingFrontCamera = false

    override func viewDidLoad() {
        super.viewDidLoad()

        zoomSlider.value = 0
        topNavView.layer.cornerRadius = 20


        setupCamera()
    }
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
  }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        previewLayer?.frame = cameraQR.bounds

        view.bringSubviewToFront(libraryImage)
    }

    func setupCamera() {
        captureSession = AVCaptureSession()

        // Lấy camera sau làm mặc định
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Không tìm thấy camera sau")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: device)
            currentInput = input

            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }

            let output = AVCaptureMetadataOutput()
            if captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
                output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                output.metadataObjectTypes = [.qr]
            }

            // Setup previewLayer để hiển thị camera
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.zPosition = -1 // Đẩy xuống dưới cùng tránh đè UI

            // Thêm previewLayer vào layer cameraQR ở vị trí đầu tiên
            cameraQR.layer.insertSublayer(previewLayer, at: 0)

            captureSession.startRunning()
        } catch {
            print("Lỗi thiết lập camera: \(error)")
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {

        guard let obj   = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let value = obj.stringValue else { return }

        captureSession.stopRunning()

        // Tạo bản ghi lịch sử
        let record = HistoryModel(
            histype: .scan,
            image   : generateThumbnail(from: value),
            title : value,
            type : value.hasPrefix("http") ? "URL" : "TEXT",
            date : Date()
        )

        HistoryStore.shared.add(record)

        showAlert(value)
    }
  func generateThumbnail(from text: String, scale: CGFloat = 6) -> UIImage? {
      // 1. Tạo data ASCII
      guard let data = text.data(using: .ascii),
            // 2. Lấy filter QR
            let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }

      filter.setValue(data, forKey: "inputMessage")
      filter.setValue("Q", forKey: "inputCorrectionLevel")   // Mức dự phòng lỗi (L/M/Q/H)

      // 3. Lấy output CIImage
      guard let outputImage = filter.outputImage else { return nil }

      // 4. Phóng đại để không bị mờ
      let transform = CGAffineTransform(scaleX: scale, y: scale)
      let scaledImage = outputImage.transformed(by: transform)

      // 5. Chuyển qua UIImage
      return UIImage(ciImage: scaledImage)
  }



    func showAlert(_ text: String) {
        let alert = UIAlertController(title: "QR Code", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.captureSession.startRunning()
        })
        present(alert, animated: true)
    }

    @IBAction func didTapFlash(_ sender: UIButton) {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        do {
            try device.lockForConfiguration()
            device.torchMode = (device.torchMode == .on) ? .off : .on
            device.unlockForConfiguration()
        } catch {
            print("Lỗi bật/tắt đèn pin: \(error)")
        }
    }

    @IBAction func didTapZoom(_ sender: UISlider) {
        guard let device = currentInput?.device else { return }
        do {
            try device.lockForConfiguration()
            let zoomFactor = CGFloat(sender.value) * (device.activeFormat.videoMaxZoomFactor - 1.0) + 1.0
            device.videoZoomFactor = min(max(zoomFactor, 1.0), device.activeFormat.videoMaxZoomFactor)
            device.unlockForConfiguration()
        } catch {
            print("Lỗi zoom: \(error)")
        }
    }

    @IBAction func didTapLibraryImage(_ sender: UIButton) {
        print("Tapped library!") // Debug log

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary

        present(picker, animated: true)
    }

    // Delegate khi chọn ảnh trong thư viện
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        if let image = info[.originalImage] as? UIImage {
            detectQRCodeInImage(image)
        }
    }

    func detectQRCodeInImage(_ image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            showAlert("Không thể xử lý ảnh")
            return
        }

        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        if let features = detector?.features(in: ciImage), !features.isEmpty {
            for feature in features {
                if let qrFeature = feature as? CIQRCodeFeature,
                   let message = qrFeature.messageString {
                    showAlert("QR Code từ ảnh: \(message)")
                    return
                }
            }
        } else {
            showAlert("Không tìm thấy mã QR trong ảnh")
        }
    }

    @IBAction func didTapGenerate(_ sender: Any) {
    }

    @IBAction func didTapHistory(_ sender: Any) {

    }
}
