import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../widgets/food_widget.dart';
import 'details.dart';

class nutrition_page extends StatefulWidget {
  static const String id='nutrition_screen';
  const nutrition_page({super.key});

  @override
  State<nutrition_page> createState() => _nutrition_pageState();
}

class _nutrition_pageState extends State<nutrition_page> {
  final foods = [
    [
      'Avocado, Egg Toast',
      'images/food1.png',
      4.9,

      'Cover the eggs with water in a small saucepan. Bring the water to a rolling boil,'
          ' then reduce the heat to low and cook according to the desired doneness,',
      '645.4 kCal',
      '23.5 g',
      '171.3mg'

    ],
    [
      'Mac and Cheese',
      'images/food2.png',
      4.4,
      'Make the cheese sauce by combining a fat (butter), '
          'and starch (flour), then whisking in the milk products,Add in shredded cheeses, stir wel ',
      '470 kCal',
      '17 g',
      '1040 mg'

    ],
    [
      'Power bowl',
      'images/food3.png',
      4.6,
      'Heat your cast iron skillet over medium heat. Add the 1 tablespoon olive oil, 1 pound ground beef, '
          '1/2 chopped yellow onion, the whites of the green onions and 1 teaspoon salt.'
          ' Break up the beef with a spoon, and cook for 10-15 minutes until cooked through  ',
      '	477 kCal',
      '18 g',
      '15%'
    ],
    [
      'vegetable Salad',
      'images/food4.png',
      3.5,
      'Place lettuce, radishes, tomatoes, green onion, jicama, cucumber, and bell pepper in a large salad bowl.'
          'Whisk olive oil, lemon juice, pomegranate juice, water, garlic, dill, basil, salt, and black pepper in a small bowl. ',
      '13.1 kCal',
      '0.6 g',
      '13.1 mg'
    ],
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        //i will put arrow to back
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SizedBox(
              width: size * 0.010,
            ),
            Text(
              'palestine',
              style: GoogleFonts.poppins(
                fontSize: size * 0.040,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 20.0,
              ),
              child: Text(
                'We think you might enjoy these specially selected dishes',
                style: GoogleFonts.poppins(
                  fontSize: size * 0.050,
                  color: AppTheme.purpleText,
                ),
              ),
            ),
            SizedBox(
              height: size * 0.050,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    print(foods[index][1].toString());
                    return GestureDetector(
                      onTap: () {
                        // Push the desired page onto the navigator's stack
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(food: foods[index],
                              text: foods[index][3].toString(),
                              img: foods[index][1].toString(),
                              cal: foods[index][4].toString(),
                                pro:foods[index][5].toString(),
                                cals:foods[index][6].toString(),
                            ),
                          ),
                        );
                      },
                      child: FoodWidget(
                        size: size,
                        foodName: foods[index][0].toString(),
                        image: foods[index][1].toString(),
                        star: double.parse(foods[index][2].toString()),
                      //  decriptin: foods[index][3].toString(),
                      ),
                    );
                  },

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
