import 'package:flutter/material.dart';
import 'package:medease/helper_widgets/colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var textStyle1 = themeData.textTheme.bodyText1;
    var heading1 = themeData.textTheme.headline1;
    var textStyle2 = themeData.textTheme.bodyText2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.color2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                'E',
                style: heading1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            backgroundColor: Colors.blue,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ))
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: const BoxDecoration(
                  color: AppColors.color2,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(100))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Virtual healthcare for you',
                        style: heading1.copyWith(color: Colors.black),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Image.asset(
                  'assets/images/onboarding_3.png',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Our services',
                  style: textStyle1,
                ),
                const SizedBox(
                  height: 15,
                ),
                GridView.builder(
                    itemCount: 6,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (ctx, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        margin: const EdgeInsets.all(5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Data',
                                style: textStyle1,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                'We can safely say that the disciples have been with Jesus long enough to know that what he says comes true but the man on the other end may have just been a regular person praying to be used by God or has been shown a sign. another example would be the donkey used by Jesus, though their names where not recorded they aligned with the scriptures by allowing the savior to use what they had. ',
                                style: textStyle2,
                                maxLines: 6,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/onboarding_2.png',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Leading Healtcare Providers',
                      style: textStyle1,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'We can safely say that the disciples have been with Jesus long enough to know that what he says comes true but the man on the other end may have just been a regular person praying to be used by God or has been shown a sign. another example would be the donkey used by Jesus, though their names where not recorded they aligned with the scriptures by allowing the savior to use what they had. ',
                      style: textStyle2,
                      maxLines: 6,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Learn more')));
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.blue,
                        side: const BorderSide(color: Colors.blue, width: 2),
                        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.blue
                        ),
                      ),
                      child: const Text('Don\'t have an account? Sign up')),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
