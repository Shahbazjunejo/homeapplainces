import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _cardController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    String price="0";

    if (args != null) {

       price = args['price'];
       _cvcController.text=price;

    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                   Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width - 80,
                    decoration:  BoxDecoration(
                      color: const Color(0xff1c2e4a),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Total Price", textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                              fontSize: 18
                          ),
            
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                           Text(price, style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 18
                          ),)
                        ],
                      ),
                    ),
                  ),
            
                Container(
                  height: 80,
                  width: 850,
                  decoration:  BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/images/img.png"),
                    ),
                  ),
                ),
                Text(
                  'Credit Card Number',
                  style: TextStyle(fontSize: 16),
                ),
            
                    TextFormField(
                      controller: _cardController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.credit_card),
                        hintText: 'xx-xxxxxxxx-xx',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),



                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter  card number';
                        }
                        if (value.length < 10) {
                          return 'card number must be at least 10 characters';
                        }
                        return null;
                      },


                    ),
            
            
                Text(
                  'Card Holder Name',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  controller: _expiryController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Card User Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter  Card User Name';
                    }
                    if (value.length < 4) {
                      return 'Card User Name must be at least 4 characters';
                    }
                    return null;
                  },



                ),
                SizedBox(height: 16),
                Text(
                  'Amount',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
            
                  controller: _cvcController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.money),
                    hintText: '00',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),
                const SizedBox(
                  width: 20,
                ),
            
                Center(
                  child: SizedBox(
                    width: 600, // specify the desired width
                    height: 80, // specify the desired height
                    child: ElevatedButton(
                      onPressed: () {

    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('PAYMENT'),
            content: Text('PAYMENT HAS BEEN PAID'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _cardController.clear();
                  _cvcController.clear();
                  _expiryController.clear();
                  Navigator.of(context).pushNamed('/HomeScreen');
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
                      },   style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                    ),
                      child: Text('Pay Now'),
                    ),
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