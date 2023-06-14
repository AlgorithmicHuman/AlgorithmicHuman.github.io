import 'package:flutter/material.dart';

class ChapterContentScreen extends StatefulWidget {
  const ChapterContentScreen({
    super.key,
  });

  @override
  State<ChapterContentScreen> createState() => _ChapterContentScreenState();
}

class _ChapterContentScreenState extends State<ChapterContentScreen> {
  final form = GlobalKey<FormState>();

  List<TextEditingController> controllers = [];
  List<String> cardContents = [];
  String selectedCard = '';

  @override
  void initState() {
    super.initState();
    // Add an initial text field controller
    controllers.add(TextEditingController());
    cardContents.add('');
  }

  void addTextField() {
    setState(() {
      // Add a new text field controller to the list
      controllers.add(TextEditingController());
      cardContents.add('');
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
                  cardContents.removeAt(index);
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

  void selectCard(String card) {
    setState(() {
      selectedCard = card;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: form,
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
                                  hintText: 'Card ${i + 1}',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                onChanged: (enteredText) {
                                  selectCard(enteredText);
                                  setState(() {
                                    cardContents[i] = enteredText;
                                  });
                                },
                                onTap: () => selectCard(controllers[i].text),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide some text to be included in the card.';
                                  }
                                  return null;
                                },
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
                                  ? 'Do you want to delete this Card?'
                                  : 'Do you want to delete the Card \'${controllers[i].text}\'',
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
                        'Add Card',
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
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 80,
              vertical: 140,
            ),
            child: SizedBox(
              height: screenHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Card(
                    color: Colors.white,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          selectedCard,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
