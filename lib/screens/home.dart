import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_sample/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  final car1 =
      'https://imageio.forbes.com/specials-images/imageserve/5d35eacaf1176b0008974b54/2020-Chevrolet-Corvette-Stingray/0x0.jpg?format=jpg&crop=4560,2565,x790,y784,safe&width=960';
  final car2 =
      'https://cdn.motor1.com/images/mgl/mrz1e/s3/coolest-cars-feature.webp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 20,
        title: Text(
          'HOME',
          style: TextStyle(
            color: Colors.purple.shade200,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showAlertDialog(context);
              //signOut(context);
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.purple.shade200,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (ctx, index) {
            return ListTile(
              title: Text('Person $index'),
              subtitle: Text('Message $index'),
              leading: index.isEven
                  ? CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red,
                      backgroundImage: NetworkImage(car1),
                    )
                  : ClipRect(
                      child: Image.network(
                        car2,
                        height: 95,
                        width: 60,
                      ),
                    ),
              trailing: const Text('10:00 a.m'),
            );
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: 24,
        ),
      ),
    );
  }

  void signOut(BuildContext ctx) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.clear();

    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const ScreenLogin()),
        (route) => false);
  }

  showAlertDialog(BuildContext ctx) {
    Widget okButton = CupertinoButton(
      child: const Text("Yes"),
      onPressed: () {
        signOut(ctx);
      },
    );
    Widget cancelButton = CupertinoButton(
      onPressed: () {
        Navigator.pop(ctx);
      },
      child: const Text('No'),
    );

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text("Sign Out"),
      content: const Text("Are you sure?"),
      actions: [okButton, cancelButton],
    );

    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
