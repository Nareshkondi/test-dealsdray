import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  final int _cardCount = 4; 

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int currentPage = _pageController.page!.round();
      if (currentPage == 0) {
        _pageController.jumpToPage(_cardCount * 100);
      } else if (currentPage == _cardCount * 200 - 1) {
        _pageController.jumpToPage(_cardCount * 100 - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search here",
            suffixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications,),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 160,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _cardCount * 200, 
                itemBuilder: (context, index) {
                  int displayIndex = index % _cardCount;
                  return _buildCarouselCard(displayIndex);
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 23, 134, 226),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text("KYC Pending", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text("You need to provide the required documents for your account activation."),
                    const SizedBox(height: 4),
                    TextButton(onPressed: () {}, child: const Text("Click Here"))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCategoryIcon(Icons.phone, "Mobile",Colors.blue),
                  buildCategoryIcon(Icons.laptop, "Laptop",Colors.green),
                  buildCategoryIcon(Icons.camera_alt, "Camera",Colors.red[200]),
                  buildCategoryIcon(Icons.lightbulb, "LED",Colors.orange[400]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("EXCLUSIVE FOR YOU", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 400,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          ProductCard(),
                          ProductCard(),
                          ProductCard(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Chat"),
        icon: const Icon(Icons.chat),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: "Deals"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildCarouselCard(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5), 
      decoration: BoxDecoration(
        color: Colors.blue, 
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4),
        ],
      ),
      child: Center(
        child: Text(
          "Card ${index + 1}",
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildCategoryIcon(IconData icon, String label,color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 2),
        ],
      ),
      child: const Column(
        children: [
          Expanded(child: Placeholder()), 
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Product Name"),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("32% Off", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
