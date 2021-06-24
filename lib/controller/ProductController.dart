import 'package:ecommerce_frontend/repositories/ProductRepository.dart';
import 'package:ecommerce_frontend/model/Product.dart';

class ProductController {
  Future<List<Product>> get_all() {
    var products = new ProductRepository().getAll();
    return products;
    //return products as List<Product>;
  }

  Future<bool> put(Product product) {
    if (product == null) {
      return Future<bool>.value(false);
    }
    return new ProductRepository().put(product);
  }

  Future<bool> post(Product product) {
    if (product == null) {
      return Future<bool>.value(false);
    }
    return new ProductRepository().post(product);
  }

  Future<bool> delete(int id) {
    //print(product.toString());
    if (id == null) {
      return Future<bool>.value(false);
    }
    return new ProductRepository().delete(id);
  }

  Future<List<Product>> getProductsByCart(List<dynamic> productsIDs) async {
    print("AQUI PRODUCTS BY CART");
    List<Product> products = [];
    if (productsIDs == null) {
      return Future<List<Product>>.value(products);
    }
    for (final productId in productsIDs) {
      Product product = await new ProductRepository().getById(productId);
      if (product != null) {
        products.add(product);
        print("ADICIONANDO PRODUTO NO ARRAY DE PRODUTO");
      }
    }
    return products;
  }
}
