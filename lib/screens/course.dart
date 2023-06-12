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
  int _index = 0;
  final GlobalKey<FormState> _CDformKey = GlobalKey<FormState>();

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: _index > 0 ? StepState.complete : StepState.indexed,
        isActive: _index >= 0,
        title: const Text('Course Details'),
        content: CourseDetails(
          form: _CDformKey,
        ), // Use UniqueKey for the form widget
        subtitle: const Text('Course\'s name & image url'),
      ),
      Step(
        state: _index > 1 ? StepState.complete : StepState.indexed,
        isActive: _index >= 1,
        title: const Text('Course Chapters'),
        content: Container(
          // alignment: Alignment.centerLeft,
          child: CourseChaptersScreen(),
        ),
        subtitle: const Text('The chapters for this course'),
      ),
      Step(
        isActive: _index >= 2,
        title: const Text('Chapter Cards'),
        content: Container(
          // alignment: Alignment.centerLeft,
          child: const Text('Content for Step 3'),
        ),
        subtitle: const Text('The cards for this chapter'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        currentStep: _index,
        type: StepperType.horizontal,
        steps: getSteps(),
        onStepCancel: () {
          _index == 0
              ? null
              : setState(() {
                  _index -= 1;
                });
        },
        onStepContinue: () {
          if (_index == 0) {
            final isFormValid =
                _CDformKey.currentState!.validate(); // Validate the form
            if (isFormValid) {
              setState(() {
                _index += 1;
              });
            } else {
              print('Error!');
            }
          } else {
            // Rest of the code...
          }
        },
        onStepTapped: (step) => setState(
          () {
            _index = step;
          },
        ),
      ),
    );
  }
}
