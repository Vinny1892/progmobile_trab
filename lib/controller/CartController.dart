// import 'package:ecommerce_frontend/view/cart/show_cart.dart';

import 'package:ecommerce_frontend/controller/ProductController.dart';
import 'package:ecommerce_frontend/repositories/CartRepository.dart';
import 'package:ecommerce_frontend/model/Cart.dart';
import 'package:ecommerce_frontend/model/Product.dart';

class CartController {
  Future<Cart> getCart(String id) {
    var cart = new CartRepository().getCart(id);
    return cart;
    //return products as List<Product>;
  }

  Future<bool> removeProduct(Cart cart, String productIDRemove) async {
    bool result = await CartRepository().removeProduct(cart, productIDRemove);
    if (result) return true;
    return false;
  }

  Future<Cart> getCartByClientId(String clientId) async {
    Cart cart = await new CartRepository().getCartByClientId(clientId);
    // cart.products =
    //     await new ProductController().getProductsByCart(cart.productListId);
    return cart;
  }

  // UpdateAddOneProduct
  Future<bool> addProduct(Product product, String clientId) async {
    Cart cart = await getCartByClientId(clientId);
    print(" cartID  ${cart.id}");
    print("AQUI CARINHOOOOO");
    if (cart.id == "") {
      return Future<bool>.value(false);
    }
    var response =
        new CartRepository().addProduct(product.id.toString(), clientId);
    return response;
  }

  Future<bool> changeStatusCartToFalse(String cartID, bool status) async {
    bool resp = await CartRepository().ChangeStatusCartToFalse(cartID, status);
    if (resp) return true;
    return false;
  }
}
