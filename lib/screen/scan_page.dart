import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:flutter_vision/flutter_vision.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late CameraController controller;
  late FlutterVision vision;
  late List<Map<String, dynamic>> yoloResults;
  CameraImage? cameraImage;
  bool isLoaded = false;
  bool isDetecting = false;

  late List<CameraDescription> cameras;

  Map<String, int> objectCounts = {};
  Map<String, int> objectEntries = {};
  Map<String, int> objectExits = {};

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    cameras = await availableCameras();
    vision = FlutterVision();
    controller = CameraController(cameras[1], ResolutionPreset.low);
    controller.initialize().then((value) {
      loadYoloModel().then((value) {
        setState(() {
          isLoaded = true;
          isDetecting = false;
          yoloResults = [];
        });
      });
    });
  }

  @override
  void dispose() async {
    super.dispose();
    controller.dispose();
    await vision.closeYoloModel();
  }

  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
        labels: 'assets/labels.txt',
        modelPath: 'assets/best_float32.tflite',
        modelVersion: "yolov8",
        numThreads: 1,
        useGpu: true);
    setState(() {
      isLoaded = true;
    });
  }

  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    final result = await vision.yoloOnFrame(
      // Fungsi yoloOnFrame mengambil frame gambar dari kamera dan menggunakan model YOLO untuk mendeteksi objek di dalam gambar.
      bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
      imageHeight: cameraImage.height,
      imageWidth: cameraImage.width,
      iouThreshold: 0.4,
      confThreshold: 0.4,
      classThreshold: 0.5,
    );
    if (result.isNotEmpty) {
      setState(() {
        yoloResults = result;
      });
      for (final item in yoloResults) {
        final tag = item['tag'];
        final confidence = item['box'][4] * 100;
        await sendDataToAPI(tag, confidence);
        updateObjectCount(tag);
      }
    }
  }

  void updateObjectCount(String tag) {
    setState(() {
      if (objectCounts.containsKey(tag)) {
        objectCounts[tag] = objectCounts[tag]! + 1;
      } else {
        objectCounts[tag] = 1;
      }

      // Hitung jumlah objek masuk dan keluar
      if (tag == "female" || tag == "male") {
        // Anda dapat menambahkan logika tambahan untuk menentukan apakah objek masuk atau keluar
        // Contoh sederhana: jika objek baru, dianggap masuk
        // Jika objek hilang dari frame, dianggap keluar

        // Tambahkan logika tambahan di sini untuk menghitung masuk dan keluar

        // Contoh logika sederhana:
        if (objectCounts[tag]! % 2 == 0) {
          if (objectEntries.containsKey(tag)) {
            objectEntries[tag] = objectEntries[tag]! + 1;
          } else {
            objectEntries[tag] = 1;
          }
        } else {
          if (objectExits.containsKey(tag)) {
            objectExits[tag] = objectExits[tag]! + 1;
          } else {
            objectExits[tag] = 1;
          }
        }
      }
    });
  }

  Future<void> startDetection() async {
    setState(() {
      isDetecting = true;
    });
    if (controller.value.isStreamingImages) {
      return;
    }
    await controller.startImageStream((image) async {
      if (isDetecting) {
        cameraImage = image;
        yoloOnFrame(image);
      }
    });
  }

  Future<void> stopDetection() async {
    setState(() {
      isDetecting = false;
      yoloResults.clear();
    });
  }

  Future<void> sendDataToAPI(String tag, double confidence) async {
    const url =
        'https://7c41-36-80-183-46.ngrok-free.app/receivedata'; // Ganti dengan URL API Flask Anda
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'tag': tag,
        'confidence': confidence,
      }),
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
    } else {
      print('Failed to send data: ${response.statusCode}');
    }
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (yoloResults.isEmpty) return [];
    double factorX = screen.width / (cameraImage?.height ?? 1);
    double factorY = screen.height / (cameraImage?.width ?? 1);

    Color colorPick = const Color.fromARGB(255, 50, 233, 30);

    return yoloResults.map((result) {
      double objectX = result["box"][0] * factorX;
      double objectY = result["box"][1] * factorY;
      double objectWidth = (result["box"][2] - result["box"][0]) * factorX;
      double objectHeight = (result["box"][3] - result["box"][1]) * factorY;

      return Positioned(
        left: objectX,
        top: objectY,
        width: objectWidth,
        height: objectHeight,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.pink, width: 2.0),
          ),
          child: Text(
            "${result['tag']} ${(result['box'][4] * 100)}",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: const Color.fromARGB(255, 115, 0, 255),
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> displayObjectEntriesExits() {
    return [
      const Text('Masuk:', style: TextStyle(fontSize: 18, color: Colors.green)),
      ...objectEntries.entries.map((entry) {
        return Text('${entry.key}: ${entry.value}',
            style: const TextStyle(fontSize: 18, color: Colors.green));
      }).toList(),
      const Text('Keluar:', style: TextStyle(fontSize: 18, color: Colors.red)),
      ...objectExits.entries.map((entry) {
        return Text('${entry.key}: ${entry.value}',
            style: const TextStyle(fontSize: 18, color: Colors.red));
      }).toList(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (!isLoaded) {
      return const Scaffold(
        body: Center(
          child: Text("Model not loaded, waiting for it"),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(
              controller,
            ),
          ),
          ...displayBoxesAroundRecognizedObjects(size),
          Positioned(
            bottom: 75,
            width: MediaQuery.of(context).size.width,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 5, color: Colors.white, style: BorderStyle.solid),
              ),
              child: isDetecting
                  ? IconButton(
                      onPressed: () async {
                        await stopDetection();
                      },
                      icon: const Icon(
                        Icons.stop,
                        color: Colors.red,
                      ),
                      iconSize: 50,
                    )
                  : IconButton(
                      onPressed: () async {
                        await startDetection();
                      },
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                      iconSize: 50,
                    ),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...displayObjectEntriesExits(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
