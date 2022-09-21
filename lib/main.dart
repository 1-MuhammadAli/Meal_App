import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/category_meals_screen.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

import 'dummy_data.dart';
import 'models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,
  };
  List<Meal> _favoriteMeals = [];

  List<Meal> _availableMeals = DUMMY_MEALS;
  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal){
        if(_filters['gluten']! && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose']! && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan']! && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian']! && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }
  void _toggleFavorite(String mealId)
  {
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0){
      _favoriteMeals.removeAt(existingIndex);
    }
    else{
      _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }
  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        //primaryColor: Colors.white,
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText2: const TextStyle(
            fontSize: 20.0,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
          // titleMedium: const TextStyle(
          //   fontSize: 20.0,
          //   fontFamily: 'RobotoCondensed',
          //   fontWeight: FontWeight.bold,
          // ),
        ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/':(ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName:(ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName:(ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName:(ctx) => FiltersScreen(_setFilters,_filters),
      },
      // onGenerateRoute: (setting){
      //   print(setting.arguments);
      //   if(setting.name == '/mealdetail'){
      //     return ...;
      //   }
      //   else if(setting.name == '/somethingelse'){
      //     return ...;
      //   }
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
      ),
        body:CategoriesScreen(),
    );
  }
}

