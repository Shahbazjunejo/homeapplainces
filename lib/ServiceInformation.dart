import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceInformation extends StatelessWidget {
  String contract = " ";
  String price = " ";


  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      contract = args['contract'];
      price = args['price'];
    }

    return MaterialApp(
      title: 'Date Selector Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserInfromationScreen(
        price: price,
        contract: contract,
      ),
    );
  }
}

class UserInfromationScreen extends StatefulWidget {
  final String price;
  final String contract;

  UserInfromationScreen({required this.price, required this.contract});

  @override
  _UserInfromationState createState() =>
      _UserInfromationState(price: price, contract: contract);
}

class _UserInfromationState extends State<UserInfromationScreen> {
  final String price;
  final String contract;

  _UserInfromationState({required this.price, required this.contract});

  TimeOfDay selectedTime = TimeOfDay.now();
  late TextEditingController _dateController;
  final TextEditingController fullnameController = new TextEditingController();
  late TextEditingController timeController ;
  final TextEditingController phonenumberController =
  new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Set the initial value of the date controller to the current date
    _dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    timeController=TextEditingController(
        text: DateFormat('HH:mm:ss').format(DateTime.now()));

  }

  // Function to show the date picker dialog

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime   = picked;
        timeController.text='Selected Time: ${_formatTime(selectedTime)}';
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    // Create a DateTime object with today's date and the selected time
    DateTime dateTime = DateTime(0, 0, 0, time.hour, time.minute);
    // Use DateFormat from the intl package to format the time
    return DateFormat('HH:mm:ss').format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    int dropDownservice = 0;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill)),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      '    Service :  ',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton(
                      value: dropDownservice,
                      onChanged: (int? newVal){
                        setState(() {
                          dropDownservice = newVal!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 0,
                          child: Text('cleaning'),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text('care'),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text('grooming'),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text('beauty'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _dateController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: ' Date',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Born Date';
                    }
                  },
                  readOnly:
                  true, // So the user has to use the calendar to pick the date
                ),
                TextFormField(
                  controller: timeController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.timer, color: Colors.black),
                    hintText: "Time",
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Time';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  //  controller: passwordController,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.home, color: Colors.black),
                      hintText: "Address",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid addresss';
                      }
                    }),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40.0,
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  margin: const EdgeInsets.only(top: 15.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')),
                        );

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(widget.contract),
                              content: Text(
                                  '$contract  has been Register with the with payment of $price'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushNamed(
                                        '/PaymentScreen',
                                        arguments: {
                                          'price': "${widget.price}",
                                        });
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text("Submit",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}