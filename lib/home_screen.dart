import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gym_ml_project/login_screen.dart';
import 'package:gym_ml_project/tips_screen.dart';
import 'package:image/image.dart' as _img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  var output;

  Float32List normalizeInput(File imageFile) {
    const inputSize = 224;
    final bytes = imageFile.readAsBytesSync();

    // Load the image using Flutter's image decoding library
    final image = _img.decodeImage(Uint8List.fromList(bytes));

    // Resize the image to match the input size of your model
    final resizedImage =
        _img.copyResize(image!, width: inputSize, height: inputSize);

    // Normalize pixel values to be between 0 and 1
    final normalizedImage = Float32List(1 * inputSize * inputSize * 3);
    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        final pixel = resizedImage.getPixel(x, y);
        normalizedImage[y * inputSize * 3 + x * 3] = pixel.r / 255.0;
        normalizedImage[y * inputSize * 3 + x * 3 + 1] = pixel.g / 255.0;
        normalizedImage[y * inputSize * 3 + x * 3 + 2] = pixel.b / 255.0;
      }
    }
    return normalizedImage;
  }

  Future<void> classifyImage() async {
    final interpreter = await Interpreter.fromAsset(
        'assets/muscle_classification_model_updated.tflite');
    interpreter.allocateTensors();

    // Perform the classification
    Float32List normalizedInput = normalizeInput(_image!);
    var input =
        normalizedInput.buffer.asFloat32List().reshape([1, 224, 224, 3]);
    var result = List.filled(2, 0.0).reshape([1, 2]);
    interpreter.run(input, result);
    interpreter.close();
    output = result[0][1] > result[0][0] ? 'Imbalanced' : 'Balanced';
    output.toString().contains('Imbalanced')
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TipsScreen(
                      image: _image!,
                    )))
        : null;
  }

  pickImage() async {
    debugPrint("Picking image...");
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    ); // Use 'pickImage' from ImagePicker
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
      debugPrint("Image picked.");
    });
    classifyImage();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Muscle Imbalance Prediction',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.grey.withOpacity(0.35),
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black
                      .withOpacity(0.75), // Set the background color
                ),
                child: Image.asset(
                  "assets/images/t_logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: const Text('Home'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                  // Add navigation logic for the Home page here
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                title: const Text('About Us'),
                onTap: () {
                  // Add navigation logic for the About Us page here
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.contact_mail,
                  color: Colors.black,
                ),
                title: const Text('Contact Us'),
                onTap: () {
                  // Add navigation logic for the Contact Us page here
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                  // Add logout logic here
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 5.0,
          tooltip: 'Pick Image',
          onPressed: pickImage,
          child: const Icon(
            Icons.add_a_photo,
            size: 25,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.01),
            Center(
              child: Container(
                height: size.height * 0.45,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white,
                    width: 2.5,
                  ),
                ),
                child: _image == null
                    ? const Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.grey,
                      )
                    : Image.file(
                        _image!,
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _image == null
                ? Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      bottom: size.height * 0.02,
                    ),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'Muscle Imbalance Prediction App',
                            style: TextStyle(
                              fontSize: size.height *
                                  0.02, // Adjust the font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text:
                                'This app allows you to quickly and easily classify muscle images into "Balance" or "Imbalance" categories. It uses advanced machine learning techniques to provide accurate results.',
                            style: TextStyle(
                              fontSize: size.height *
                                  0.015, // Adjust the font size as needed
                            ),
                          ),
                          const TextSpan(text: '\n\n'),
                          TextSpan(
                            text: 'How To Use?',
                            style: TextStyle(
                              fontSize: size.height *
                                  0.02, // Adjust the font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text:
                                '1. Tap the camera button to select an image from your gallery.',
                            style: TextStyle(
                              fontSize: size.height *
                                  0.015, // Adjust the font size as needed
                            ),
                          ),
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text:
                                '2. Your chosen image will appear in the designated box.',
                            style: TextStyle(
                              fontSize: size.height *
                                  0.015, // Adjust the font size as needed
                            ),
                          ),
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text:
                                '3. The app will automatically classify the muscle as\n\t\t\t\t\t"Balanced" or "Imbalanced."',
                            style: TextStyle(
                              fontSize: size.height *
                                  0.015, // Adjust the font size as needed
                            ),
                          ),
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text:
                                '4. The result will be displayed in a card below the image.',
                            style: TextStyle(
                              fontSize: size.height *
                                  0.015, // Adjust the font size as needed
                            ),
                          ),
                          const TextSpan(text: '\n\n'),
                          TextSpan(
                            text:
                                'Enjoy effortless muscle classification with this app!',
                            style: TextStyle(
                              fontSize: size.height *
                                  0.015, // Adjust the font size as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : output != null &&
                        output
                            .isNotEmpty // Check if output is not null and not empty
                    ? Column(
                        children: [
                          Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(size.height * 0.015),
                              child: Text(
                                '$output',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.05,
                              right: size.width * 0.05,
                              top: size.height * 0.02,
                              bottom: size.height * 0.05,
                            ),
                            child: Text(
                              'Hurray...\nCongrats, Your muscles are balanced.',
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.emoji_emotions_outlined,
                            size: size.height * 0.15,
                            color: Colors.amber,
                          )
                        ],
                      )
                    : Card(
                        elevation: 5,
                        color: Colors.orange,
                        child: Padding(
                          padding: EdgeInsets.all(size.height * 0.015),
                          child: Text(
                            'No Results Found!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
