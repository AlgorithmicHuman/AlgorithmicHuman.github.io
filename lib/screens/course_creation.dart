import 'package:flutter/material.dart';
import 'package:islamify_admin/screens/chapter_content_screen.dart';
import 'package:islamify_admin/screens/course_chapters_screen.dart';
import 'package:islamify_admin/widgets/course_details.dart';

class CourseCreationScreen extends StatefulWidget {
  const CourseCreationScreen({super.key});

  @override
  State<CourseCreationScreen> createState() => _CourseCreationScreenState();
}

class _CourseCreationScreenState extends State<CourseCreationScreen> {
  int _mainIndex = 0;
  final List<TextEditingController> chapters = [];

  final GlobalKey<FormState> _CDformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _CChpformKey = GlobalKey<FormState>();

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: _mainIndex > 0 ? StepState.complete : StepState.indexed,
        isActive: _mainIndex >= 0,
        title: const Text('Course Details'),
        content: CourseDetails(
          form: _CDformKey,
        ), // Use UniqueKey for the form widget
        subtitle: const Text(' The course\'s name & image url'),
      ),
      Step(
        state: _mainIndex > 1 ? StepState.complete : StepState.indexed,
        isActive: _mainIndex >= 1,
        title: const Text('Course Chapters'),
        content: CourseChaptersScreen(
          form: _CChpformKey,
          controllers: chapters,
        ),
        subtitle: const Text('The chapters of this course'),
      ),
      Step(
        isActive: _mainIndex >= 2,
        title: const Text('Chapter Cards'),
        content: ListView.builder(
          itemCount: chapters.length,
          itemBuilder: (ctx, index) => Card(
            color: Theme.of(context).cardColor,
            child: ExpansionTile(
              title: Text(
                chapters[index].text.isEmpty
                    ? 'Please provide a chapter name'
                    : 'Cards for the chapter: \'${chapters[index].text}\'',
              ),
              maintainState: true,
              children: const [
                ChapterContentScreen(),
              ],
            ),
          ),
          shrinkWrap: true,
        ),
        subtitle: const Text('The cards of this chapter'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        currentStep: _mainIndex,
        type: StepperType.horizontal,
        steps: getSteps(),
        onStepCancel: () {
          _mainIndex == 0
              ? null
              : setState(() {
                  _mainIndex -= 1;
                });
        },
        onStepContinue: () {
          if (_mainIndex == 0) {
            final isCourseValid =
                _CDformKey.currentState!.validate(); // Validate the form
            if (isCourseValid) {
              setState(
                () {
                  _mainIndex += 1;
                },
              );
            } else {
              print('Error! course!');
            }
          }
          if (_mainIndex == 1) {
            final isChapterValid = _CChpformKey.currentState!.validate();
            if (isChapterValid) {
              setState(
                () {
                  _mainIndex += 1;
                },
              );
            } else {
              print('Error chapter!');
            }
          } else {}
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    _mainIndex <= 1 ? 'Continue' : 'Publish Course',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: details.onStepCancel,
                  child: Text(
                    'Back',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
