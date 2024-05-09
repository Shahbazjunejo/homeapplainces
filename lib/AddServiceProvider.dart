import 'package:flutter/material.dart';

import 'DatabaseHelper.dart';

class AddServiceProvider extends StatefulWidget {
  AddServiceProvider({super.key});



@override
AddServiceProviderstate createState() => AddServiceProviderstate();
}




class AddServiceProviderstate extends State<AddServiceProvider> {

  final TextEditingController username = TextEditingController();
  final TextEditingController password= TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController emailaddress = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();

   String _selectedItem='add service';
  String dropdownValue='sss';
  int dropDownValue = 0;
  int dropDownitems = 0;
  int dropDownarea = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text("Add Service provider",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 30,),
            _buildTextField(hint: 'name',controller: username),
            const SizedBox(height: 20,),
            _buildTextField(hint: 'contact',controller: phonenumber),
            const SizedBox(height: 20,),
            const Text("Service Provider",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
            DropdownButton(
              value: dropDownValue,
              onChanged: (int? newVal){
                setState(() {
                  dropDownValue = newVal!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 0,
                  child: Text('Appliance Heroes'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('HomeTech Solutions'),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text('FixIt Appliance Repair'),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text('Pro Appliance Services'),
                ),
                DropdownMenuItem(
                  value: 4,
                  child: Text('Handy Home Appliances'),
                ),
                DropdownMenuItem(
                  value: 5,
                  child: Text('Swift Appliance Repairs'),
                ),

              ],




            ),

            const SizedBox(height: 30,),
            const Text("Service Items",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
            DropdownButton(
              value: dropDownitems,
              onChanged: (int? newVal){
                setState(() {
                  dropDownitems = newVal!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 0,
                  child: Text('Home Appliances'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('Electronics'),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text('Plumbing'),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text('HVAC'),
                ),
              ],
            ),


            const SizedBox(height: 30,),
            const Text("Service Area",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
            DropdownButton(
              value: dropDownarea,
              onChanged: (int? newVal){
                setState(() {
                  dropDownarea = newVal!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 0,
                  child: Text('North'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('South'),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text('East'),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text('West'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {

                String homeapplaicnces='Home Appliances';
                String area='North';
                if(dropDownitems==0){
homeapplaicnces='Home Appliances';
                }else if (dropDownitems==1){
                homeapplaicnces='Electronics';
                }
                else if (dropDownitems==2){
                homeapplaicnces='Plumbing';
                }
                else if (dropDownitems==3){
                homeapplaicnces='HVAC';
                }

                if( dropDownarea==0){
                  area='North';
                }else if ( dropDownarea==1){
                  area='South';
                }
                else if ( dropDownarea==2){
                  area='East';
                }
                else if ( dropDownarea==3){
                  area='West';
                }


                insertserviceprovider( username!.text,phonenumber!.text,fullname!.text,homeapplaicnces,area);
              /*  username.clear();
                password.clear();
                fullname.clear();
                emailaddress.clear();
                phonenumber.clear();*/
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Service provider '),
                      content: Text('Service provider been Added'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14.0),
              ),
              child: const Text('Add Service provider ', style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),),
            ),
            const SizedBox(
              height: 30,
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, bool obscureText = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      ),
      obscureText: obscureText,
    );
  }


  Widget buildDropdown({
    required String value,
    required List<String> items,
    required String hint,
    required ValueChanged<String?>? onChanged,
  }) {
    return DropdownButton<String>(
      value: value,
      hint: hint != null ? Text(hint) : null,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );


  }
  void insertserviceprovider(String username, String contact, String servicename,
      String serviceprovided, String servicearea) async {
    int id = await DatabaseHelper.instance.insertserviceprovider({
      DatabaseHelper.columnName: username,
      DatabaseHelper.columncontact: contact,
      DatabaseHelper.serviceName: servicename,
      DatabaseHelper.serviceprovided: serviceprovided,
      DatabaseHelper.servicearea: servicearea,
    });
    if (id != null) {
      // Registration successful
      print('User registered successfully');
    } else {
      // Registration failed
      print('Failed to register user');
    }
  }
}
