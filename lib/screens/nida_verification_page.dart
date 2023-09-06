import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../util/app_colors.dart';
import '../util/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_step.dart';

class NidaVerificationPage extends StatefulWidget {
  const NidaVerificationPage({Key? key}) : super(key: key);

  @override
  State<NidaVerificationPage> createState() => _NidaVerificationPageState();
}

class _NidaVerificationPageState extends State<NidaVerificationPage> with TickerProviderStateMixin {
  int _currentStep = 0;
  int steps = 4;
  String _question1 = 'Question 1';
  String _question2 = '';
  String _question3 = '';
  String _question4 = '';
  String _question5 = '';

  Icon stepIconBuilder(int currentStep) {
    if (currentStep == _currentStep) {
      return Icon(Icons.check, color: Colors.green);
    } else {
      return Icon(Icons.close, color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Text('NIDA Verification'),
      ),
      body: ListView(
        children: [
          Stepper(
            onStepContinue: () {
              setState(() {
                _currentStep = _currentStep + 1;
                if(_currentStep == 5 ){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NidaVerificationPage())) ;
                }
              });
            },
            currentStep: _currentStep,
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                children: [
                  CustomButton(
                    onTap: (){
                      if (_currentStep < 5 - 1) {
                        details.onStepContinue!();
                      }else{
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NidaVerificationPage())) ;
                      }
                    },
                    title: "Next",
                  ),
                ],
              );
            },
            steps: [
              Step(
                title: Text('Question 1'),
                content: Padding(
                    padding : const EdgeInsets.only(top: 4 , bottom: 4),
                    child : TextFormField(
                      scrollPadding: const EdgeInsets.only(bottom:100),
                      decoration:  AppConstants.inputDecorationForms.copyWith(
                        labelText: 'Answer',
                      ),
                    )
                ),
              ),
              Step(
                title: Text('Question 2'),
                content: Padding(
                    padding : const EdgeInsets.only(top: 4 , bottom: 4),
                    child : TextFormField(
                      scrollPadding: const EdgeInsets.only(bottom:100),
                      decoration:  AppConstants.inputDecorationForms.copyWith(
                        labelText: 'Answer',
                      ),
                    )
                ),
              ),
              Step(
                title: Text('Question 3'),
                content: Padding(
                    padding : const EdgeInsets.only(top: 4 , bottom: 4),
                    child : TextFormField(
                      scrollPadding: const EdgeInsets.only(bottom:100),
                      decoration:  AppConstants.inputDecorationForms.copyWith(
                        labelText: 'Answer',
                      ),
                    )
                ),
              ),
              Step(
                title: Text('Question 4'),
                content: Padding(
                    padding : const EdgeInsets.only(top: 4 , bottom: 4),
                    child : TextFormField(
                      scrollPadding: const EdgeInsets.only(bottom:100),
                      decoration:  AppConstants.inputDecorationForms.copyWith(
                        labelText: 'Answer',
                      ),
                    )
                ),
              ),
              Step(
                title: Text('Question 5'),
                content: Padding(
                    padding : const EdgeInsets.only(top: 4 , bottom: 4),
                    child : TextFormField(
                      scrollPadding: const EdgeInsets.only(bottom:100),
                      decoration:  AppConstants.inputDecorationForms.copyWith(
                        labelText: 'Answer',
                      ),
                    )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
