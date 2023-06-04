import 'package:flutter/material.dart';
import 'package:islamify_admin/screens/chapter_content_screen.dart';

class CourseChaptersScreen extends StatefulWidget {
  CourseChaptersScreen({
    super.key,
    required this.courseTitle,
    required this.imageUrl,
  });

  final String courseTitle;
  final String imageUrl;

  @override
  State<CourseChaptersScreen> createState() => _CourseChaptersScreenState();
}

class _CourseChaptersScreenState extends State<CourseChaptersScreen> {
  final _form = GlobalKey<FormState>();

  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    // Add an initial text field controller
    controllers.add(TextEditingController());
  }

  void addTextField() {
    setState(() {
      // Add a new text field controller to the list
      controllers.add(TextEditingController());
    });
  }

  void deleteTextField(int index, String content) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              // Remove the text field controller at the specified index
              onPressed: () {
                setState(() {
                  controllers.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text('Delete!'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose all the text field controllers
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Form(
              key: _form,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var i = 0; i < controllers.length; i++)
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              margin: const EdgeInsets.all(15),
                              elevation: 15,
                              child: TextFormField(
                                controller: controllers[i],
                                textCapitalization:
                                    TextCapitalization.sentences,
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
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Chapter ${i + 1}',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                onChanged: (value) => setState(() {}),
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ChapterContentScreen(
                                  chapterTitle: controllers[i].text,
                                  courseTitle: widget.courseTitle,
                                ),
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_outward_sharp,
                              size: 25,
                            ),
                            label: const Text(
                              'View Chapter Details',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[700],
                              size: 28,
                            ),
                            onPressed: () => deleteTextField(
                              i,
                              controllers[i].text.isEmpty
                                  ? 'Do you want to delete this chapter?'
                                  : 'Do you want to delete the chapter \'${controllers[i].text}\'',
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton.icon(
                      icon: const Icon(
                        Icons.add,
                        size: 25,
                      ),
                      onPressed: addTextField,
                      label: const Text(
                        'Add Chapter',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: screenHeight,
              width: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Card(
                  color: Colors.blueAccent[100],
                  margin: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 100,
                  ),
                  elevation: 15,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ListView.builder(
                      itemCount: controllers.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 15,
                          ),
                          elevation: 10,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              controllers[index].text,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        );
                      },
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