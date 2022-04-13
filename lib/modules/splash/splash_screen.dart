// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_auth/models/splash_model.dart';
import 'package:flutter_auth/modules/login/login_screen.dart';
import 'package:flutter_auth/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  bool isLastPageViewer = false;

  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var splashController = PageController();


    List<SplashModel> boarding = [
      SplashModel(
          image: 'assets/images/splash/Online presentation_Two Color.png',
          title: 'welcom to our app"',
          body: 'please press next to go to the page 2 '),
      SplashModel(
          image: 'assets/images/splash/Startup_Monochromatic.png',
          title: 'this is test application',
          body:
          'please press next to go to the page 3'),
      SplashModel(
          image: 'assets/images/splash/Team meeting_Monochromatic.png',
          title: 'lets go to the login page',
          body:
          'please press next to go to the last page'),
    ];

    void submit() async {
      await CacheHelper.saveData(key: 'splash', value: true)!.then((value) {
        if (value) {
          navigateAndFinish(context, LoginScreen());
        }
      });
    }



    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              text: ('skip'),
              onPressed: () {
                submit();
              },
          )],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [

            Expanded(
                child: PageView.builder(
                  itemBuilder: (context, index) =>
                      buildSplashItem(boarding[index]),
                  itemCount: boarding.length,
                  controller: splashController,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    if (index == boarding.length-1) {
                      setState(() {
                        isLastPageViewer=true;
                      });
                    } else {
                      setState(() {
                        isLastPageViewer=false;

                      });
                    }
                  },
                )),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: splashController,
                      effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      expansionFactor: 3,
                      activeDotColor: primarySwatch,
                      dotWidth: 15.0,
                      spacing: 5.0,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLastPageViewer == true) {
                      submit();
                    } else {
                      setState(() {
                        splashController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      });
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildSplashItem(SplashModel model) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          )),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
        ),
        textDirection: TextDirection.ltr,

      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,
        ),
        textDirection: TextDirection.ltr,

      ),
      SizedBox(
        height: 15.0,
      ),
    ],
  ),
);
