
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/util/app_styles.dart';

import '../util/app_colors.dart';

class ContributionPage extends StatefulWidget {
  const ContributionPage({Key? key}) : super(key: key);

  @override
  State<ContributionPage> createState() => _ContributionPageState();
}

class _ContributionPageState extends State<ContributionPage> {
  final amount = TextEditingController();
  final amount_list = [500, 1000, 5000, 10000];
  int? _selecteAmount;

  sendMoney (){
    var data = Map<String , dynamic>();
    data['user_id'] = 'id';
    data['amount'] = amount;
    data['phone'] = 'phone';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
      ),
        body: ListView(
      children: [
        const Gap(50),
        Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/images/jmProfile.jpg'))),
            ),
          ],
        ),
        const Gap(20),
        Column(
          children: [
            Text('JESSAN JOSEPHAT'),
          ],
        ),
        const Gap(20),
        Column(
          children: [
            Text('From : 06870626354'),
          ],
        ),
        const Gap(20),
        Column(
          children: [
            Text('TO : MT THERESIA WA MTOTO YESU '),
          ],
        ),
        const Gap(20),
        Column(
          children: [
            Container(
              height: 100,
              width: 250,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 10, right: 15),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(6),
                      ],
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'AMOUNT',
                      ),
                      controller: amount,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 5.0,
              children: List<Widget>.generate(
                4,
                (int index) {
                  return InputChip(
                      label: Text(
                        '${amount_list[index]}',
                        style: Styles.headLineStyle5,
                      ),
                      selected: _selecteAmount == index,
                      onSelected: (bool selected) {
                        setState(() {
                          if (_selecteAmount == index) {
                            _selecteAmount = null;
                            amount.text = '';
                          } else {
                            _selecteAmount = index;
                            amount.text = amount_list[index].toString();
                          }
                        });
                      });
                },
              ).toList(),
            ),
          ],
        ),
        const Gap(20),
        Column(
          children: [
            SizedBox(
              height: 60,
              width: 180,
              child: ElevatedButton(
                onPressed: () { SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  );
                },
                child: const Text('Proceed',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        )
      ],
    ));
  }
}
