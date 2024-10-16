// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';
//
// void main() {
//   runApp(const MyApp());
//   loadModel(); // Load the TensorFlow Lite model
// }
//
// void loadModel() async {
//   try {
//     await Tflite.loadModel(
//       model: "assets/muscle_classification_model.tflite",
//       labels: "assets/labels.txt",
//     );
//     debugPrint("Model Loaded Successfully");
//   } catch (e) {
//     debugPrint("Failed to load model: $e");
//   }
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: ImageDetectionScreen(),
//     );
//   }
// }
//
// class ImageDetectionScreen extends StatefulWidget {
//   const ImageDetectionScreen({super.key});
//
//   @override
//   _ImageDetectionScreenState createState() => _ImageDetectionScreenState();
// }
//
// class _ImageDetectionScreenState extends State<ImageDetectionScreen> {
//   File? _image;
//
//   Future<void> getImage() async {
//     print("Getting Image");
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//         print("Got the image");
//         processImage(_image!);
//       });
//     }
//   }
//
//   Future<void> processImage(File imageFile) async {
//     try {
//       TensorImage preprocessedImage = await preprocessImage(imageFile);
//       await runModelOnPreprocessedImage(preprocessedImage);
//     } catch (e) {
//       print('Error processing image: $e');
//     }
//   }
//
//   Future<List> preprocessImage(File imageFile) async {
//     Uint8List imageBytes = await imageFile.readAsBytes();
//     TensorImage tensorImage = TensorImage(TensorImageDataType.uint8);
//     tensorImage.load(TensorBuffer.createUint8Buffer(imageBytes),
//         imageSize: IntSize(224, 224));
//     tensorImage = preprocessImageTensor(tensorImage);
//     return tensorImage.getData();
//   }
//
//   TensorImage preprocessImageTensor(TensorImage inputTensor) {
//     inputTensor.loadRgb();
//     inputTensor = inputTensor.normalize(0, 255);
//     return inputTensor;
//   }
//
//   Future<void> runModelOnPreprocessedImage(TensorImage inputTensor) async {
//     var recognitions = await Tflite.runModelOnBinary(
//       binary: inputTensor.buffer,
//       asynch: true,
//     );
//
//     print('Raw Recognitions: $recognitions');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Detection App'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               _image == null
//                   ? Text('Select an image to analyze.')
//                   : Image.file(_image!),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: getImage,
//                 child: Text('Select Image'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';
//
// void main() {
//   runApp(const MyApp());
//   loadModel(); // Load the TensorFlow Lite model
// }
//
// void loadModel() async {
//   try {
//     await Tflite.loadModel(
//       model: "assets/muscle_classification_model.tflite",
//       labels: "assets/labels.txt",
//     );
//     debugPrint("Model Loaded Successfully");
//   } catch (e) {
//     debugPrint("Failed to load model: $e");
//   }
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: ImageDetectionScreen(),
//     );
//   }
// }
//
// class ImageDetectionScreen extends StatefulWidget {
//   const ImageDetectionScreen({super.key});
//
//   @override
//   _ImageDetectionScreenState createState() => _ImageDetectionScreenState();
// }
//
// class _ImageDetectionScreenState extends State<ImageDetectionScreen> {
//   File? _image;
//   List<dynamic>? _results;
//
//   Future getImage() async {
//     print("Getting Image");
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//         print("Got the image");
//         detectImage();
//       });
//     }
//   }
//
//   void detectImage() async {
//     try {
//       print("Detecting Image...");
//       if (_image == null) return;
//
//       print(_image!.path);
//
//       var recognitions = await Tflite.runModelOnImage(
//         path: _image!.path,
//         numResults: 2,
//         threshold: 0.1,
//         imageMean: 0.0,
//         // Adjust if needed based on your model requirements
//         imageStd: 255.0, // Adjust if needed based on your model requirements
//       );
//
//       if (recognitions != null && recognitions.isNotEmpty) {
//         print("Raw Recognitions: $recognitions");
//         setState(() {
//           _results = recognitions;
//           print("Detected Results: ${_results![0]}");
//         });
//       } else {
//         print("No results found.");
//       }
//     } catch (e) {
//       print("Error detecting image: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Detection App'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               _image == null
//                   ? Text('Select an image to analyze.')
//                   : Image.file(_image!),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: getImage,
//                 child: Text('Select Image'),
//               ),
//               SizedBox(height: 20),
//               _results != null
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: _results!.map((result) {
//                         String label = result['index'] == 0
//                             ? 'Balanced Muscles'
//                             : 'Imbalanced Muscles';
//                         return Text(
//                             'Label: $label - Confidence: ${result['confidence']}');
//                       }).toList(),
//                     )
//                   : Text('No results yet.'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// NEW CODE... FROM CLIENT

import 'package:flutter/material.dart';
import 'package:gym_ml_project/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muscular',
      home: LoginScreen(),
    );
  }
}
