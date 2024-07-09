import 'package:flutter/material.dart';
import '../../../../utils/image_loader.dart';
import '../../../../utils/showToast.dart';
import '../widgets/form_container_widget.dart';

class AddPostDialogNew extends StatefulWidget {
  final Function( String imageUrl, String postText, double price, double review, double reduction) onAdd;
  final String? initialDescription;
  final String? initialImageUrl;
  final double? initialPrice;
  final double? initialReview;
  final double? initialReduction;

  const AddPostDialogNew({
    Key? key,
    required this.onAdd,
    this.initialDescription,
    this.initialImageUrl,
    this.initialPrice,
    this.initialReview,
    this.initialReduction,
  }) : super(key: key);

  @override
  State<AddPostDialogNew> createState() => _AddPostDialogNewState();
}

class _AddPostDialogNewState extends State<AddPostDialogNew> {
  late TextEditingController _textEditingController;
  late TextEditingController _priceEditingController;
  late TextEditingController _reductionEditingController;
  late String _imageUrl;
  late double review;
  String path = 'posts';

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialDescription ?? '');
    _priceEditingController = TextEditingController(text: widget.initialPrice?.toString() ?? '');
    _reductionEditingController = TextEditingController(text: widget.initialReduction?.toString() ?? '');
    _imageUrl = widget.initialImageUrl ?? '';
    review = widget.initialReview ?? 0.0;
  }

  Future<void> _loadImageUrl() async {
    try {
      final url = await ImageLoader().openPicker(path);
      setState(() {
        _imageUrl = url;
      });
    } catch (error) {
      print("Error loading image: $error");
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _priceEditingController.dispose();
    _reductionEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 1,
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Product',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            FormContainerWidget(
              controller: _textEditingController,
              hintText: 'Description',
            ),
            const SizedBox(height: 20),
            FormContainerWidget(
              controller: _priceEditingController,
              hintText: 'Price',
            ),
            const SizedBox(height: 20),
            FormContainerWidget(
              controller: _reductionEditingController,
              hintText: 'Reduction',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                      ),
                      onPressed: _loadImageUrl,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Upload Image',
                          style: TextStyle(color: Colors.black87, fontSize: 22.0),
                        ),
                      ),
                    ),
                    if (_imageUrl.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Image.network(
                          _imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black87, fontSize: 22.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                      ),
                      onPressed: () {
                        widget.onAdd(
                          _imageUrl,
                          _textEditingController.text,
                          double.parse(_priceEditingController.text),
                          review,
                          double.parse(_reductionEditingController.text),
                        );
                        Navigator.pop(context);
                        showCustomToast(context, "Product added successfully");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.initialDescription == null ? 'Add' : 'Update',
                          style: TextStyle(color: Colors.black87, fontSize: 22.0),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
