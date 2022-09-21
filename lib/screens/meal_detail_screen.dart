import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/mealdetail';

  final Function toggleFavorite;
  final Function isFavourite;
  MealDetailScreen(this.toggleFavorite,this.isFavourite);

  Widget buildSectionTitle(BuildContext context,String text){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
  Widget buildContainer( Widget child){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      height: 150.0,
      width: 300.0,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId=ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId,);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300.0,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl,
                fit: BoxFit.cover,),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(itemBuilder: (context,index){
                return Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                );
              },
                itemCount: selectedMeal.ingredients.length,),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                  itemCount: selectedMeal.steps.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${(index + 1)}'),
                          ),
                          title: Text(selectedMeal.steps[index]),
                        ),
                        Divider(color: Colors.grey,),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(mealId),
        child: Icon(isFavourite(mealId)
            ? Icons.star
            : Icons.star_border),
      ),
    );
  }
}
