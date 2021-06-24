# ecommerce_frontend

Aplicação front-end para o projeto ecommerce,
onde o foco não é desenvolver o projeto em si,
mas usar novas tecnoligas.

Esta aplicação é feita em Flutter, e seus dados são servidos a partir do micro serviço API-GATEWAY, que por sua vez requisita o respectivo micro serviço.

Esta aplicação flutter não tem otimizações minimas,
pois o foco foi lidar com diversos micro serviços se comunicando via gRPC.

suas telas são:
    LOGIN, REGISTER: controler de USER(FUNCIONARIO, CLIENTE);
    PRODUCT: CRUD de produtos, clientes adiciona produtos ao seu carrinho de compra;
    CART: mostrar o que o cliente logado adiciou ao CART;
    ORDER: exibe compra realizada do cliente dos produtos que estavam no carrinho;

o arquivo .env no qual tem o item base_url é usado para  url da api
