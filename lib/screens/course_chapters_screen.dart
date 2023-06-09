import 'package:flutter/material.dart';

class CourseChaptersScreen extends StatefulWidget {
  CourseChaptersScreen({
    super.key,
    required this.form,
    required this.controllers,
  });

  final GlobalKey<FormState> form;
  List<TextEditingController> controllers = [];

  @override
  State<CourseChaptersScreen> createState() => _CourseChaptersScreenState();
}

class _CourseChaptersScreenState extends State<CourseChaptersScreen> {
  @override
  void initState() {
    super.initState();
    // Add an initial text field controller
    widget.controllers.add(TextEditingController());
  }

  void addTextField() {
    setState(() {
      // Add a new text field controller to the list
      widget.controllers.add(TextEditingController());
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
                  widget.controllers.removeAt(index);
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
    // Dispose all the text field widget.controllers
    for (var controller in widget.controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // void nextPage(int index) {
  //   final isValid = widget.form.currentState!.validate();

  //   if (!isValid) {
  //     return;
  //   }
  // }

  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (ctx) => ChapterContentScreen(
  //         chapterTitle: widget.controllers[index].text,
  //         courseTitle: widget.courseTitle,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Form(
            key: widget.form,
            child: Column(
              children: [
                for (var i = 0; i < widget.controllers.length; i++)
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          surfaceTintColor: Colors.white,
                          margin: const EdgeInsets.all(15),
                          elevation: 15,
                          child: TextFormField(
                            controller: widget.controllers[i],
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
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length < 3) {
                                return 'Chapter name should atleast be 3 characters long.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      // TextButton.icon(
                      //   onPressed: () => nextPage(i),
                      //   icon: const Icon(
                      //     Icons.arrow_outward_sharp,
                      //     size: 25,
                      //   ),
                      //   label: const Text(
                      //     'View Chapter Details',
                      //     style: TextStyle(
                      //       fontSize: 20,
                      //     ),
                      //   ),
                      // ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[700],
                          size: 28,
                        ),
                        onPressed: () => deleteTextField(
                          i,
                          widget.controllers[i].text.isEmpty
                              ? 'Do you want to delete this chapter?'
                              : 'Do you want to delete the chapter \'${widget.controllers[i].text}\'',
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
                  vertical: 60,
                ),
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ListView.builder(
                    itemCount: widget.controllers.length,
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
                            widget.controllers[index].text,
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
    );
  }
}
