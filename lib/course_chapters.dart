import 'package:flutter/material.dart';
import 'package:islamify_admin/widgets/styled_field.dart';

class CourseChapters extends StatefulWidget {
  CourseChapters({
    super.key,
    required this.courseTitle,
    required this.imageUrl,
  });

  String courseTitle;
  String imageUrl;

  @override
  State<CourseChapters> createState() => _CourseChaptersState();
}

class _CourseChaptersState extends State<CourseChapters> {
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
    final _screenHeight = MediaQuery.of(context).size.height;

    final _chapterController = TextEditingController();

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
                            child: StyledField(
                              controller: controllers[i],
                              hintText: 'Chapter ${i + 1}',
                              icon: const Icon(Icons.abc),
                              onSubmit: (value) => setState(() {}),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
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
              height: _screenHeight,
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
