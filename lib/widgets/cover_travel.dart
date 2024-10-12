import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hero/helpers/file_manager.dart';
import 'dart:io';
import 'package:hero/palette.dart';
import 'package:get_it/get_it.dart';
import 'package:hero/widgets/warning_message.dart';

GetIt getIt = GetIt.instance;

// ignore: must_be_immutable
class CoverTravel extends StatefulWidget {
  String? travel;
  bool detail;
  Uint8List? cover;
  bool? fullScreen;
  final Function(Uint8List bytes, String extension)? onSaveFunction;
  CoverTravel({required this.detail, this.cover, this.fullScreen, this.travel, required this.onSaveFunction, super.key});

  @override
  State<CoverTravel> createState() => _CoverTravelState();
}

class _CoverTravelState extends State<CoverTravel> {
  FileManager fileManager = getIt.get<FileManager>();
  late XFile? _selectedImage = null;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Uint8List? bytes = await fileManager.convertXFileToUint8List(image);
      final String extension = image.name.split('.').last.toLowerCase(); // Extract the file extension

      // Check if the format is supported
      if (extension.toLowerCase() == 'png' || extension.toLowerCase() == 'jpg' || extension.toLowerCase() == 'jpeg' || extension.toLowerCase() == 'gif') {
        widget.onSaveFunction!(bytes!, extension); // Pass bytes and extension to the save function
        setState(() {
          _selectedImage = image;
        });
      } else {
        // Handle unsupported format
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unsupported image format: $extension')),
        );
      }
    }
  }

  Future<XFile> loadImage() async {
    return fileManager.convertUint8ListToXFile(widget.cover!, widget.travel!);   
  }

  @override
  void initState() {
    if(widget.cover != null){
      loadImage();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        (widget.cover==null)
          ?Container(
            width: double.infinity,
            height: (widget.fullScreen == true)
              ?MediaQuery.of(context).size.height
              :200.0,
            color: Colors.grey[300],
            child: _selectedImage == null
                ? Icon(
                    Icons.explore,
                    size: 100.0,
                    color: Colors.grey[600],
                  )
                : Image.file(
                    File(_selectedImage!.path),
                    fit: (widget.fullScreen == true)
                      ? BoxFit.contain 
                      : BoxFit.cover,
                    width: double.infinity,
                  ),
          )
          :Container(
            width: double.infinity,
            height: (widget.fullScreen == true)
              ?MediaQuery.of(context).size.height
              :200.0,
            color: Colors.grey[300],
            child: (_selectedImage != null)
              ?Image.file(
                File(_selectedImage!.path),
                fit: (widget.fullScreen == true)
                  ? BoxFit.contain 
                  : BoxFit.cover,
                width: double.infinity,
              )
              :FutureBuilder<XFile>(
                  future: loadImage(), 
                  builder: (BuildContext context, AsyncSnapshot<XFile> snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: WarningMessage(message:'Error loading image'));
                    } else if (snapshot.hasData) {
                      return Image.file(
                        File(snapshot.data!.path),
                        fit: (widget.fullScreen == true)
                          ? BoxFit.contain 
                          : BoxFit.cover,
                        width: double.infinity,
                      );
                    } else {
                      return Center(child: WarningMessage(message:'No image available'));
                    }
                  }
                )
          ),
        (widget.detail==false)
          ?Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              icon: const CircleAvatar(
                backgroundColor:Palette.primary,
                child: Icon(
                  Icons.edit,
                  color: Palette.white,
                ),
              ),
              onPressed: _pickImage,
              tooltip: 'Edit Cover Photo',
              iconSize: 30.0,
            ),
          )
          :const Text('')
      ],
    );
  }
}