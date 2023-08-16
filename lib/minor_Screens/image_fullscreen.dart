import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appBar_widgets.dart';

class ImageFullScreen extends StatefulWidget {
  final List<dynamic> imagesList;
  const ImageFullScreen({Key? key, required this.imagesList}) : super(key: key);

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  final PageController _pageController = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBack(),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                ('${index + 1}') +
                    ('/') +
                    (widget.imagesList.length.toString()),
                style: const TextStyle(
                  fontSize: 24,
                  letterSpacing: 8,
                ),
              ),
            ),
            SizedBox(
                height: size.height * 0.5,
                child: PageView(
                    onPageChanged: (value) {
                      setState(() {
                        index = value;
                      });
                    },
                    controller: _pageController,
                    children: images())),
            SizedBox(height: size.height * 0.2, child: imageView())
          ],
        ),
      ),
    );
  }

  Widget imageView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _pageController.jumpToPage(index);
          },
          child: Container(
            width: 120,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.yellow),
                borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.imagesList[index].toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: widget.imagesList.length,
    );
  }

  List<Widget> images() {
    return List.generate(widget.imagesList.length, (index) {
      return InteractiveViewer(
          //interactive viewer makes it possible to zoom in and out of image
          transformationController: TransformationController(),
          child: Image.network(widget.imagesList[index].toString()));
    });
  }
}
