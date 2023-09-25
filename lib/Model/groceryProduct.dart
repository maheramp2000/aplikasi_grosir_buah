class groceryProduct{

  final double price;
  final String name;
  final String description;
  final String image;
  final String weight;

  const groceryProduct({
    required this.price,
    required this.name,
    required this.description,
    required this.image,
    required this.weight
  });

}

const groceryProducts = <groceryProduct>[

      groceryProduct(
        price: 10.0,
        name: "Alpukat",
        description: "The avacado is a fleshy exotic fruit obtained from the tropical",
        image: "Assets/palta.png",
        weight: '500g'
        ),
      groceryProduct(
        price: 15.0,
        name: "Pisang",
        description: "It is good fruit for everyone except diabetics and obese because of its heih starch and more",
        image: "Assets/banana.png",
        weight: '1000g'
        ),
      groceryProduct(
        price: 15.0,
        name: "Mangga",
        description: "The Mango is a fleshy exotic fruit obtained from the tropical",
        image: "Assets/mango.png",
        weight: '800g'
        ),
      groceryProduct(
        price: 20.0,
        name: "Nanas",
        description: "The Pneapple is a fleshy exotic fruit obtained from the tropical",
        image: "Assets/pina.png",
        weight: '1000g'
        ),
      groceryProduct(
        price: 15.0,
        name: "Aanggur",
        description: "The Cherry is a fleshy exotic fruit obtained from the tropical",
        image: "Assets/cereza.png",
        weight: '500g'
        ),
      groceryProduct(
        price: 6.0,
        name: "Jeruk",
        description: "The Orange is a fleshy exotic fruit obtained from the tropical",
        image: "Assets/orange.png",
        weight: '1000g'
        ),

  ];