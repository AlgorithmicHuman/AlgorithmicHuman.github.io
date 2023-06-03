import 'package:flutter/material.dart';

class CourseForm extends StatefulWidget {
  const CourseForm({super.key});

  @override
  State<CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
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
    final _screenHeight = MediaQuery.of(context).size.height;

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
                          onFieldSubmitted: (str) => setState(() {
                            // _imageController.text;
                          }),
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
                          onFieldSubmitted: (str) => setState(() {
                            // _imageController.text;
                          }),
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
                            onPressed: () {},
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
                horizontal: 100,
                vertical: 200,
              ),
              child: SizedBox(
                height: _screenHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Card(
                    elevation: 5,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _imageController.text.isEmpty
                            ? const SizedBox.expand(
                                child: Center(
                                  child: Text(
                                    'Provide an image url to see it here!',
                                    style: TextStyle(
                                      fontSize: 35,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : Image.network(
                                _imageController.text,
                                fit: BoxFit.cover,
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
