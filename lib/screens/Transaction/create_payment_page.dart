import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../util/app_colors.dart';
import '../../util/app_styles.dart';
import '../../util/constants.dart';
import '../../widgets/left_drawer.dart';

class CreatePaymentPage extends StatefulWidget {
  const CreatePaymentPage({super.key});

  @override
  State<CreatePaymentPage> createState() => _CreatePaymentPageState();

}

class _CreatePaymentPageState extends State<CreatePaymentPage> {
  int? selectedPaymentTo;
  late List<String> items;
  String? selectedPaymentMethod;

  final amount = TextEditingController();
  final phone = TextEditingController();
  late Color containerColorAirtel = Colors.transparent;
  late Color containerColorTigo = Colors.transparent;
  late Color containerColorMpesa= Colors.transparent;

  @override
  void initState() {
    super.initState();
    items =
    ['SADAKA', 'ZAKA', 'MICHANGO', 'CHANGIZO MAARUMU', 'OTHER OTHER THING'];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: const Text('Add Contribution'),
      ),
      drawer: const Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: LeftDrawer(),
      ),
      body: ListView(
          children: [
          const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Select Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ],
            ),
            const Gap(10),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Change the container's color to green
                      setState(() {
                        containerColorAirtel = Colors.blueAccent;
                        containerColorMpesa = Colors.transparent;
                        containerColorTigo = Colors.transparent;
                        selectedPaymentMethod = 'Airtel';
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: containerColorAirtel,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                'assets/images/airtel.png',
                                width: 50.0,
                                height: 50.0,
                              ),
                            ),

                            Gap(3),
                            Text('Airtel')
                          ],
                        )
                    ),
                  ),
                  GestureDetector(
                  onTap: () {
                  // Change the container's color to green
                  setState(() {
                  containerColorMpesa = Colors.blueAccent;
                  containerColorAirtel = Colors.transparent;
                  containerColorTigo = Colors.transparent;
                  selectedPaymentMethod = 'Mpesa';
                  });
                  },
                  child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: containerColorMpesa,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/images/mpesa.png',
                        width: 50.0,
                        height: 50.0,
                      ),
                    ),

                    Gap(3),
                    Text('M-Pesa')
                  ],
                  )
                  ),
                  ),
                  GestureDetector(
                            onTap: () {
                              // Change the container's color to green
                              setState(() {
                                containerColorTigo = Colors.blueAccent;
                                containerColorAirtel = Colors.transparent;
                                containerColorMpesa = Colors.transparent;
                                selectedPaymentMethod = 'tigo-pesa';
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: containerColorTigo,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        'assets/images/tigo.png',
                                        width: 50.0,
                                        height: 50.0,
                                      ),
                                    ),

                                    Gap(3),
                                    Text('Tigo-Pesa')
                                  ],
                                )
                            ),
                          ),
                ],
            ),
            const Gap(10),
            Padding(
              padding: EdgeInsets.only(left: 15 , bottom: 5 , right: 15),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(12)
                ],
                scrollPadding: EdgeInsets.only(bottom:25),
                decoration: AppConstants.inputDecorationForms.copyWith(
                  labelText: 'Phone Number',
                  hintText: 'Enter Your Pay Phone number',
                ),
                controller: phone,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Phone number cannot be null.";
                  }
                  return null;
                },
              ),
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Select Payment To' , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
              ],
            ),
            const Gap(8),
    Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 5.0,
          runSpacing: 5.0,
          children: List<Widget>.generate(5, (int index) {
              return InputChip(
                label: Text( items[index], style: Styles.headLineStyle5,),
                selected: selectedPaymentTo == index,
                onSelected: (bool selected) {
                  setState(() {
                    if (selectedPaymentTo == index) {
                      selectedPaymentTo = null;
                    } else {
                      selectedPaymentTo = index;
                    }
                  });
                });
              },
          ).toList(),
        ),
      ],
    ),
    const Gap(10),
    Column(
      children: [
        Padding(padding: EdgeInsets.only(left: 15, bottom: 10, right: 15),
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              LengthLimitingTextInputFormatter(8),
            ],
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)
              ),
              hintText: 'AMOUNT',
            ),
            controller: amount,
          ),
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Payment Details' , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
      ],
    ),
    const Gap(10),

    Container(
      margin: EdgeInsets.all(5),
      height: 200,
      width : MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.blueAccent
        ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Payment Method: '),
              Gap(10),
              Text(selectedPaymentMethod == null ? '': selectedPaymentMethod.toString())
            ],
          ),
          Row(
            children: [
              Text('Phone Number: '),
              Text(phone.text)
            ],
          ),
          Row(
            children: [
              Text('Payment for: '),
              Text(selectedPaymentTo == null? '' : items[selectedPaymentTo!.toInt()].toString())
            ],
          ),
          Row(
            children: [
              Text('Amount: '),
              Text(amount.text)
            ],
          ),
        ],
      ),
    ),
    Column(
      children: [
        SizedBox(
          height: 60,
          width: 180,
          child: ElevatedButton(
            onPressed: () {
              SizedBox( height: 100, width: 100, child: CircularProgressIndicator(),);
              },
            child: const Text('Proceed', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    )
          ]
    ,
    )
    );
  }
}
