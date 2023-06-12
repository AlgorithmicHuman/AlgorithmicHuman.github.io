import 'package:flutter/material.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({
    super.key,
    required this.form,
  });

  final GlobalKey<FormState> form;

  @override
  State<CourseDetails> createState() =>
      _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  final TextEditingController _courseTitleController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  bool _isValidUrl = true;

  @override
  void initState() {
    super.initState();
    _courseTitleController.text = '';
    _imageController.text = '';
  }

  @override
  void dispose() {
    _courseTitleController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Form(
              key: widget.form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    surfaceTintColor: Colors.white,
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
                      onChanged: (_) => setState(() {}),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length < 4) {
                          return 'Course title should be at least 4 characters long.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  Card(
                    surfaceTintColor: Colors.white,
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
                        hintText: 'Image URL',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      onChanged: (_) => setState(() {
                        _isValidUrl = true;
                      }),
                      validator: (value) {
                        if (value == null || value.isEmpty || !_isValidUrl) {
                          return 'Please provide a valid image URL';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 1000,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Card(
                  elevation: 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (_imageController.text.isEmpty)
                        Container(
                          color: Colors.blueAccent[100],
                          child: const Center(
                            child: Text(
                              'Provide an image URL to see it here!',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      else
                        Image.network(
                          _imageController.text,
                          fit: BoxFit.cover,
                          errorBuilder: (context, exception, StackTrace) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                _isValidUrl = false;
                              });
                            });
                            return Container(
                              color: const Color(0xFFED264E),
                              child: Center(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text:
                                            'FAILED TO LOAD IMAGE! THE ERROR WAS: \n \n',
                                        style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF27213C),
                                        ),
                                      ),
                                      TextSpan(
                                        text: '$exception',
                                        style: const TextStyle(
                                          fontSize: 35,
                                          //fontWeight: FontWeight.bold,
                                          color: Color(0xFFF5F5DC),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // child: Text(
                                //   'Failed to load image $exception',
                                //   style: const TextStyle(
                                //     fontSize: 35,
                                //     fontWeight: FontWeight.bold,
                                //     color: Colors.white,
                                //   ),
                                //   textAlign: TextAlign.center,
                                // ),
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
    );
  }
}
