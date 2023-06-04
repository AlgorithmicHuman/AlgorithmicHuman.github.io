import 'package:flutter/material.dart';
import 'package:islamify_admin/screens/course_chapters_screen.dart';

class CourseCreationScreen extends StatefulWidget {
  const CourseCreationScreen({super.key});

  @override
  State<CourseCreationScreen> createState() => _CourseCreationScreenState();
}

class _CourseCreationScreenState extends State<CourseCreationScreen> {
  final _form = GlobalKey<FormState>();

  final _courseTitleController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _courseTitleController.dispose();
    _imageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 100,
                horizontal: 50,
              ),
              child: Center(
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: TextFormField(
                          controller: _courseTitleController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.abc),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Course Title',
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          onChanged: (str) => setState(() {}),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: TextFormField(
                          keyboardType: TextInputType.url,
                          controller: _imageController,
                          autocorrect: false,
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.link),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'ImageUrl',
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          onFieldSubmitted: (str) => setState(() {}),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            icon: const Icon(
                              Icons.arrow_forward,
                              size: 25,
                            ),
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => CourseChaptersScreen(
                                  courseTitle: _courseTitleController.text,
                                  imageUrl: _imageController.text,
                                ),
                              ),
                            ),
                            label: const Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 80,
                vertical: 180,
              ),
              child: SizedBox(
                height: screenHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Card(
                    elevation: 5,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _imageController.text.isEmpty
                            ? Container(
                                color: Colors.blueAccent[100],
                                child: const Center(
                                  child: Text(
                                    'Provide an image url to see it here!',
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : Image.network(
                                _imageController.text,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Container(
                                    color: Colors.red,
                                    child: Center(
                                      child: Text(
                                        'Failed to load image: $exception',
                                        style: const TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                },
                              ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          height: 120,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.black.withOpacity(0.40),
                            child: Center(
                              child: Text(
                                _courseTitleController.text,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
