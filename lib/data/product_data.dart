import 'dart:convert';
import 'package:http/http.dart' as http;

var ProductData;

Future<void> getDummyUser() async {
  var url = Uri.parse("https://jsonplaceholder.typicode.com/users");
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      ProductData = jsonDecode(response.body);
    } else {
      print("Failed to get user. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error occurred: $e");
  }
}

List<Map> Products = [
  {
    "name": "Apple",
    "category": "Fruits",
    "price": "199.9",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGTiYre_aIbJWugt5CU-Lq671R3sA_HRX-H5So9_z2OQ&s",
    "status": "Available",
    "location": "Second Shelf",
    "description":
        "Apples are a good source of nutrients, including fiber, vitamin C, and antioxidants which can help support healthy digestion, brain health, and weight management.",
    "isFavorite": false,
  },
  {
    "name": "Banana",
    "category": "Fruits",
    "price": "149.5",
    "image":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Banana-Single.jpg/1024px-Banana-Single.jpg",
    "status": "Available",
    "location": "Fruit Section",
    "description":
        "Bananas are rich in potassium, vitamin C, and vitamin B6. They are a convenient and nutritious snack.",
    "isFavorite": false,
  },
  {
    "name": "Milk",
    "category": "Dairy",
    "price": "299.0",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStOZ-9BIlFdjxa6qcYq8cYSEBeciRH1yc05wSSKGHVXQ&s",
    "status": "Available",
    "location": "Dairy Aisle",
    "description":
        "Milk is a good source of calcium and protein, essential for bone health and muscle repair.",
    "isFavorite": false,
  },
  {
    "name": "Eggs",
    "category": "Dairy",
    "price": "399.9",
    "image":
        "https://static.vecteezy.com/system/resources/previews/022/794/153/non_2x/eggs-in-the-basket-free-png.png",
    "status": "Available",
    "location": "Refrigerated Section",
    "description":
        "Eggs are a versatile food rich in protein, vitamins, and minerals. They can be cooked in various ways.",
    "isFavorite": false,
  },
  {
    "name": "Bread",
    "category": "Bakery",
    "price": "99.9",
    "image":
        "https://www.healthline.com/hlcmsresource/images/AN_images/AN120-Whole-Wheat-Bread-732x549-Thumb.jpg",
    "status": "Available",
    "location": "Bakery Section",
    "description":
        "Bread is a staple food made from flour, yeast, water, and salt. It's a source of carbohydrates and provides energy.",
    "isFavorite": false,
  },
  {
    "name": "Beaf",
    "category": "Meat",
    "price": "599.9",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ1c6KQSQMdqTsMSpDAZ5J3aEwJEektwdT1DI2NL7CpA&s",
    "status": "Available",
    "location": "Meat Department",
    "description":
        "Chicken breast is a lean source of protein, low in fat and calories. It's versatile and can be cooked in various dishes.",
    "isFavorite": false,
  },
  {
    "name": "Spinach",
    "category": "Vegetables",
    "price": "249.9",
    "image":
        "https://www.healthline.com/hlcmsresource/images/AN_images/AN71-Spinach-732x549-thumb.jpg",
    "status": "Available",
    "location": "Produce Section",
    "description":
        "Spinach is a leafy green vegetable rich in iron, vitamins, and antioxidants. It's beneficial for overall health.",
    "isFavorite": false,
  },
  {
    "name": "Tomatoes",
    "category": "Vegetables",
    "price": "179.9",
    "image":
        "https://www.healthline.com/hlcmsresource/images/AN_images/AN54-Tomatoes-732x549-Thumb.jpg",
    "status": "Available",
    "location": "Produce Section",
    "description":
        "Tomatoes are rich in vitamins and antioxidants. They can be eaten raw in salads or cooked in various dishes.",
    "isFavorite": false,
  },
  {
    "name": "Coffee",
    "category": "Beverages",
    "price": "499.9",
    "image":
        "https://www.healthline.com/hlcmsresource/images/AN_images/AN14-Cup-of-Coffee-732x549-thumb.jpg",
    "status": "Available",
    "location": "Beverages Aisle",
    "description":
        "Coffee is a popular beverage made from roasted coffee beans. It contains caffeine and antioxidants.",
    "isFavorite": false,
  },
  {
    "name": "Orange",
    "category": "Beverages",
    "price": "249.9",
    "image":
        "https://www.healthline.com/hlcmsresource/images/AN_images/AN39-Orange-Juice-732x549-thumb.jpg",
    "status": "Available",
    "location": "Beverages Aisle",
    "description":
        "Orange juice is a refreshing beverage rich in vitamin C and other nutrients. It's a popular breakfast drink.",
    "isFavorite": false,
  }
];

List<Map<String, dynamic>> categories = [
  {
    "title": "Fruits",
    "image":
        "https://static.wixstatic.com/media/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png/v1/fill/w_557,h_414,al_c,lg_1,q_85/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png"
  },
  {
    "title": "Vegetables",
    "image":
        "https://image.freepik.com/free-vector/vegetables-background_23-2147504248.jpg"
  },
  {
    "title": "Dairy",
    "image":
        "https://static.vecteezy.com/system/resources/thumbnails/035/642/273/small/ai-generated-egg-in-carton-free-png.png"
  },
  {
    "title": "Meat",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ1c6KQSQMdqTsMSpDAZ5J3aEwJEektwdT1DI2NL7CpA&s"
  },
  {
    "title": "Bakery",
    "image":
        "https://image.freepik.com/free-vector/bakery-background_23-2148245683.jpg"
  },
  {
    "title": "Beverages",
    "image":
        "https://image.freepik.com/free-vector/different-types-drinks_23-2147651837.jpg"
  },
  {
    "title": "Snacks",
    "image":
        "https://image.freepik.com/free-vector/snacks-background-template_23-2148240884.jpg"
  },
  {
    "title": "Frozen Foods",
    "image":
        "https://image.freepik.com/free-vector/frozen-food-background-template_23-2148262186.jpg"
  },
  {
    "title": "Canned Goods",
    "image":
        "https://image.freepik.com/free-vector/canned-foods-background-template_23-2148245872.jpg"
  },
  {
    "title": "Condiments",
    "image":
        "https://image.freepik.com/free-vector/condiments-background-template_23-2148245680.jpg"
  }
];
