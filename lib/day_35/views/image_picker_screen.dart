import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ppkd_b6/constant/app_color.dart';

class ImagePickerScreenDay35 extends StatefulWidget {
  const ImagePickerScreenDay35({super.key});

  @override
  State<ImagePickerScreenDay35> createState() => _ImagePickerScreenDay35State();
}

class _ImagePickerScreenDay35State extends State<ImagePickerScreenDay35> {
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  String? _base64String;
  bool _isConverting = false;

  Future<void> _pickFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      _processImage(File(pickedFile.path));
    }
  }

  Future<void> _pickFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      _processImage(File(pickedFile.path));
    }
  }

  Future<void> _processImage(File imageFile) async {
    setState(() {
      _selectedImage = imageFile;
      _isConverting = true;
      _base64String = null;
    });

    try {
      final bytes = await imageFile.readAsBytes();
      final base64Encoded = base64Encode(bytes);

      setState(() {
        _base64String = base64Encoded;
        _isConverting = false;
      });
    } catch (e) {
      setState(() {
        _isConverting = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal convert ke base64: $e'),
            backgroundColor: Colors.red,
          ), // SnackBar
        );
      }
    }
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
      _base64String = null;
    });
  }

  Widget _buildDecodedPreview() {
    if (_base64String == null) return const SizedBox.shrink();

    try {
      final decodedBytes = base64Decode(_base64String!);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🎨 Preview dari Base64 (decoded):',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ), // Text
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(
              decodedBytes,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ), // Image.memory
          ), // ClipRRect
        ],
      ); // Column
    } catch (e) {
      return Text(
        'Gagal decode: $e',
        style: const TextStyle(color: Colors.red),
      ); // Text
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 36 - Image Picker & Base64',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ), // Text
        backgroundColor: AppColor.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (_selectedImage != null)
            IconButton(
              onPressed: _clearImage,
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Hapus Gambar',
            ), // IconButton
        ],
      ), // AppBar
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPickerButtons(),
            const SizedBox(height: 24),
            if (_selectedImage != null) ...[
              _buildSectionTitle('🖼️ Gambar yang Dipilih:'),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _selectedImage!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ), // Image.file
              ), // ClipRRect
              const SizedBox(height: 16),
              _buildFileInfo(),
              const SizedBox(height: 16),
            ],
            if (_isConverting)
              const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text('Mengkonversi ke base64...'),
                  ],
                ), // Column
              ), // Center
            if (_base64String != null) ...[
              _buildSectionTitle('✨ Base64 String:'),
              const SizedBox(height: 8),
              _buildBase64Container(),
              const SizedBox(height: 8),
              Text(
                'Panjang base64: ${_base64String!.length} karakter',
                style: TextStyle(color: AppColor.greyText, fontSize: 13),
              ), // Text
              const SizedBox(height: 24),
              _buildDecodedPreview(),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Base64 string berhasil di-copy!'),
                      backgroundColor: AppColor.primaryColor,
                    ), // SnackBar
                  );
                },
                icon: const Icon(Icons.copy),
                label: const Text('Copy Base64'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ), // RoundedRectangleBorder
                ), // ElevatedButton.styleFrom
              ), // ElevatedButton.icon
            ],
            if (_selectedImage == null && !_isConverting) _buildEmptyState(),
          ],
        ), // Column
      ), // SingleChildScrollView
    ); // Scaffold
  }

  Widget _buildPickerButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _pickFromGallery,
            icon: const Icon(Icons.photo_library_outlined),
            label: const Text('Gallery'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ), // RoundedRectangleBorder
            ), // ElevatedButton.styleFrom
          ), // ElevatedButton.icon
        ), // Expanded
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _pickFromCamera,
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text('Camera'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.secondaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ), // RoundedRectangleBorder
            ), // ElevatedButton.styleFrom
          ), // ElevatedButton.icon
        ), // Expanded
      ],
    ); // Row
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ); // Text
  }

  Widget _buildFileInfo() {
    final fileSize = _selectedImage!.lengthSync();
    final fileSizeKB = (fileSize / 1024).toStringAsFixed(1);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.primaryColor.withValues(alpha: 0.2)),
      ), // BoxDecoration
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('📂 Path', _selectedImage!.path.split('/').last),
          const SizedBox(height: 4),
          _buildInfoRow('📦 Ukuran', '$fileSizeKB KB'),
        ],
      ), // Column
    ); // Container
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ), // Text
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: AppColor.greyText),
            overflow: TextOverflow.ellipsis,
          ), // Text
        ), // Expanded
      ],
    ); // Row
  }

  Widget _buildBase64Container() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C),
        borderRadius: BorderRadius.circular(10),
      ), // BoxDecoration
      child: Text(
        '${_base64String!.substring(0, _base64String!.length > 200 ? 200 : _base64String!.length)}...',
        style: const TextStyle(
          color: Color(0xFFF8F8F2),
          fontFamily: 'monospace',
          fontSize: 11,
        ), // TextStyle
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
      ), // Text
    ); // Container
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 80,
            color: AppColor.greyText.withValues(alpha: 0.4),
          ), // Icon
          const SizedBox(height: 16),
          Text(
            'Pilih gambar dari Gallery atau Camera\nuntuk di-convert ke Base64',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.greyText, fontSize: 15),
          ), // Text
        ],
      ), // Column
    ); // Container
  }
}
