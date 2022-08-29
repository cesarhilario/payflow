import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';

class BarcodeScannerController {
  final statusNotifier =
      ValueNotifier<BarcodeScannerStatus>(BarcodeScannerStatus());

  BarcodeScannerStatus get status => statusNotifier.value;
  set status(BarcodeScannerStatus status) => statusNotifier.value = status;

  static final List<BarcodeFormat> formats = [BarcodeFormat.all];
  final barcodeScanner = BarcodeScanner(formats: formats);

  CameraController? cameraController;
  InputImage? imagePicker;

  void getAvailableCameras() async {
    try {
      final response = await availableCameras();
      final camera = response.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.back);

      cameraController =
          CameraController(camera, ResolutionPreset.max, enableAudio: false);

      await cameraController!.initialize();

      scanWithCamera();
      listenCamera();
    } catch (e) {
      status = BarcodeScannerStatus.error(e.toString());
    }
  }

  Future<void> scannerBarCode(InputImage? inputImage) async {
    if (inputImage != null) {
      try {
        final List<Barcode> barcodes =
            await barcodeScanner.processImage(inputImage);

        var barcode;
        for (Barcode item in barcodes) {
          barcode = item.displayValue;
        }

        if (barcode != null && status.barcode.isEmpty) {
          status = BarcodeScannerStatus.barcode(barcode);
          cameraController!.dispose();
          await barcodeScanner.close();
        }

        return;
      } catch (e) {
        print("Error on scannerBarCode$e");
      }
    }
  }

  void scanWithImagePicker() async {
    final response = await ImagePicker().getImage(source: ImageSource.gallery);
    InputImage? inputImage;

    if (response != null) {
      inputImage = InputImage.fromFilePath(response.path);
    }

    scannerBarCode(inputImage);
  }

  void scanWithCamera() {
    status = BarcodeScannerStatus.available();

    Future.delayed(const Duration(seconds: 20)).then((value) {
      if (status.hasBarcode == false) {
        status = BarcodeScannerStatus.error("Timeout de leitura de boleto");
      }
    });
  }

  void listenCamera() {
    if (cameraController!.value.isStreamingImages == false) {
      cameraController!.startImageStream((cameraImage) async {
        if (status.stopScanner == false) {
          try {
            final WriteBuffer allBytes = WriteBuffer();
            for (final Plane plane in cameraImage.planes) {
              allBytes.putUint8List(plane.bytes);
            }
            final bytes = allBytes.done().buffer.asUint8List();

            final Size imageSize = Size(
                cameraImage.width.toDouble(), cameraImage.height.toDouble());

            const InputImageRotation imageRotation =
                InputImageRotation.rotation0deg;

            final InputImageFormat? inputImageFormat =
                InputImageFormatValue.fromRawValue(cameraImage.format.raw);

            final planeData = cameraImage.planes.map(
              (Plane plane) {
                return InputImagePlaneMetadata(
                  bytesPerRow: plane.bytesPerRow,
                  height: plane.height,
                  width: plane.width,
                );
              },
            ).toList();

            if (imageRotation != null && inputImageFormat != null) {
              final inputImageData = InputImageData(
                size: imageSize,
                imageRotation: imageRotation,
                inputImageFormat: inputImageFormat,
                planeData: planeData,
              );

              final inputImage = InputImage.fromBytes(
                  bytes: bytes, inputImageData: inputImageData);

              scannerBarCode(inputImage);
            }
          } catch (e) {
            print(e);
          }
        }
      });
    }
  }

  void dispose() {
    statusNotifier.dispose();
    barcodeScanner.close();
    if (status.showCamera) {
      cameraController!.dispose();
    }
  }
}
