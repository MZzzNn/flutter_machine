import 'package:flutter/material.dart';
import '../firebase_machine_screen.dart';
import '../local_machine_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Machine learning'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child:Image.asset(
                'assets/images/img1.png',
                fit: BoxFit.cover,
                height: 220,
                width: double.infinity,
              ),
            ),

            SizedBox(height: 25,),

            Text(
              'Now, You\'ve two options !',
              style: Theme.of(context).textTheme.headline5,
            ),

            SizedBox(height: 10,),

            SizedBox(
              width: MediaQuery.of(context).size.width*0.8,
              child: ElevatedButton(
                onPressed:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>FireBaseMachineScreen())),
                child: Text(
                    'FireBase Machine Screen',
                    style: Theme.of(context).textTheme.bodyText2
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width*0.8,
              child: ElevatedButton(
                onPressed:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LocalMachineScreen())),
                child: Text(
                    'Local Machine Screen',
                    style: Theme.of(context).textTheme.bodyText2
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
