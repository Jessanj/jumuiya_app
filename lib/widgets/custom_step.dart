// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
//
// import '../util/constants.dart';
// import '../widgets/custom_button.dart';
// // import '../widgets/custom_step.dart';
//
// class NidaVerificationPage extends StatefulWidget {
//   const NidaVerificationPage({Key? key}) : super(key: key);
//
//   @override
//   State<NidaVerificationPage> createState() => _NidaVerificationPageState();
// }
//
// class _NidaVerificationPageState extends State<NidaVerificationPage> with TickerProviderStateMixin {
//   int _currentStep = 0;
//   List steps = [] ;
//   String _question1 = 'Question 1';
//   String _question2 = 'Question 2';
//   String _question3 = 'Question 3';
//   String _question4 = 'Question 4';
//   String _question5 = 'Question 5';
//
//   Icon stepIconBuilder(int currentStep) {
//     return Icon(
//       Icons.check.codePoint  as IconData,
//       color: currentStep == _currentStep ? Colors.green : Colors.red,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         appBar: AppBar(
//           title: Text('NIDA Verification'),
//         ),
//         body: ListView(
//           children: [
//             Stepper(
//               currentStep: _currentStep,
//               controlsBuilder: (BuildContext context, ControlsDetails details) {
//                 return Row(
//                   children: [
//                     CustomButton(
//                       onTap: (){
//                         if (_currentStep < 5 - 1) {
//                           details.onStepContinue!();
//                           //steps[_currentStep - 1].icon = Icon(Icons.check, color: Colors.green);
//                         }
//                       },
//                       title: "Next",
//                     )
//                   ],
//                 );
//               },
//               steps: [
//                 CustomStep(
//                     icon: Icons.check,
//                     title:  _question1,
//                     content: Padding(
//                         padding : const EdgeInsets.only(top: 4 , bottom: 4),
//                         child : TextFormField(
//                           scrollPadding: const EdgeInsets.only(bottom:100),
//                           decoration:  AppConstants.inputDecorationForms.copyWith(
//                             labelText: 'Answer',
//                           ),
//                         )
//                     )
//                 ),
//                 CustomStep(
//                     icon: Icons.close,
//                     title: _question2,
//                     content: Padding(
//                         padding : const EdgeInsets.only(top: 4 , bottom: 4),
//                         child : TextFormField(
//                           scrollPadding: const EdgeInsets.only(bottom:100),
//                           decoration:  AppConstants.inputDecorationForms.copyWith(
//                             labelText: 'Answer',
//                           ),
//                         )
//                     )
//                 ),
//                 CustomStep(
//                     icon: Icons.check,
//                     title: _question3,
//                     content: Padding(
//                         padding : const EdgeInsets.only(top: 4 , bottom: 4),
//                         child : TextFormField(
//                           scrollPadding: const EdgeInsets.only(bottom:100),
//                           decoration:  AppConstants.inputDecorationForms.copyWith(
//                             labelText: 'Answer',
//                           ),
//                         )
//                     )
//                 ),
//                 CustomStep(
//                     icon: Icons.close,
//                     title: _question4,
//                     content: Padding(
//                         padding : const EdgeInsets.only(top: 4 , bottom: 4),
//                         child : TextFormField(
//                           scrollPadding: const EdgeInsets.only(bottom:100),
//                           decoration:  AppConstants.inputDecorationForms.copyWith(
//                             labelText: 'Answer',
//                           ),
//                         )
//                     )
//                 ),
//                 CustomStep(
//                     icon: Icons.check,
//                     title: _question5,
//                     content: Padding(
//                         padding : const EdgeInsets.only(top: 4 , bottom: 4),
//                         child : TextFormField(
//                           scrollPadding: const EdgeInsets.only(bottom:100),
//                           decoration:  AppConstants.inputDecorationForms.copyWith(
//                             labelText: 'Answer',
//                           ),
//                         )
//                     )
//                 ),
//               ],
//             ),
//           ],
//         )
//     );
//   }
//
// }
//
// class CustomStep extends Step {
//   final IconData icon;
//
//   CustomStep({
//     required this.icon,
//     String? title,
//     Widget? content,
//     bool isActive = false,
//   }) : super(
//     title: title != null ? Text(title) : Text(''),
//     content: content ?? Text(''),
//     isActive: isActive,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         children: [
//           Icon(icon),
//           Expanded(
//             child: Text(title! as String),
//           ),
//         ],
//       ),
//     );
//   }
// }