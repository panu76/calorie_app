import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ReceiptScannerScreen extends StatefulWidget {
  const ReceiptScannerScreen({super.key});

  @override
  State<ReceiptScannerScreen> createState() => _ReceiptScannerScreenState();
}

class _ReceiptScannerScreenState extends State<ReceiptScannerScreen> {
  final _picker = ImagePicker();
  final _textRecognizer = TextRecognizer();

  String? _scannedText;
  bool _isProcessing = false;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked == null) return;

    setState(() {
      _isProcessing = true;
    });

    final file = File(picked.path);
    final inputImage = InputImage.fromFile(file);
    final result = await _textRecognizer.processImage(inputImage);

    setState(() {
      _scannedText = result.text;
      _isProcessing = false;
    });
  }

  @override
  void dispose() {
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Receipt (ML Kit)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _isProcessing ? null : _pickImage,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Capture Receipt'),
            ),
            const SizedBox(height: 16),
            if (_isProcessing)
              const Center(child: CircularProgressIndicator())
            else if (_scannedText != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(_scannedText!),
                ),
              )
            else
              const Text('No text scanned yet.'),
          ],
        ),
      ),
    );
  }
}

