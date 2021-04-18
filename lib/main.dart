import 'package:flutter/material.dart';
import 'package:flutter_recaptcha_v2/flutter_recaptcha_v2.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  RecaptchaV2Controller recaptchaV2Controller = RecaptchaV2Controller();
  String token = "";
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recaptchaV2Controller.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: recaptchaV2Controller.visible
              ? RecaptchaV2(
                  apiKey:
                      "6LdyO6oaAAAAANlrysO6wlAgVmzwMnrHywmjfwqc", // for enabling the reCaptcha
                  controller: recaptchaV2Controller,
                  onToken: (txt) {},

                  onVerifiedError: (err) {
                    print("%%%%%%%%%%%%%%%%%>");
                    print(err);
                    Toast.show("Capcha Error !!", context);
                  },

                  onVerifiedSuccessfully: (success) {
                    setState(() {
                      if (success) {
                        print(
                            "##############################################################");
                        Toast.show("Capcha Success", context);

                        /*  token is saved in responseToken variable you can send it now to backend */

                        print("Response Token: " +
                            recaptchaV2Controller.responseToken.toString());
                        // You've been verified successfully.
                        //
                        setState(() {
                          token =
                              recaptchaV2Controller.responseToken.toString();
                        });
                        recaptchaV2Controller.hide();
                      } else {
                        print(
                            "************************************************************");
                        Toast.show("Failed to verify", context);
                        // "Failed to verify.
                      }
                    });
                  },
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Your Token is : " + token),
                )),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
