# ecommerce_frontend

O Desenvolvimento desta aplicação foi feito para dar base a um 
projeto de E-Commerce tendo total foco no front-end da aplicação.
Assim o foco foi utilizar novas técnologias e nao focar estritamente no melhor 
desempenho e possibilidade possivel para o cenário do projeto. 

Esta aplicação foi feita em Flutter e seus serviços vieram a partir de um microservicço API-GATEWAY, que por sua vez é requisita ao microserviço.

Esta aplicação flutter não tem as otimizações minimas,
pois o foco foi lidar com diversos microserviços. se comunicando via gRPC.

suas telas são:
    LOGIN, REGISTER: controler de USER(FUNCIONARIO, CLIENTE);
    PRODUCT: CRUD de produtos, clientes adiciona produtos ao seu carrinho de compra;
    CART: mostrar o que o cliente logado adiciou ao CART;
    ORDER: exibe compra realizada do cliente dos produtos que estavam no carrinho;

o arquivo .env no qual tem o item base_url é usado para  url da api
