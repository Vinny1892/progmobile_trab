# ecommerce_frontend

Descrição:

O Desenvolvimento desta aplicação Flutter com as regras de negócio baseado em um simples E-Commerce, tendo maior foco no front-end da aplicação.
Assim, o foco foi utilizar novas tecnologias, principalmente o Flutter, e não priorizamos o desempenho. 

Esta aplicação foi feita em Flutter e seus serviços vieram a partir de um micro serviço API-GATEWAY, que por sua vez é requisitado ao micro serviço. Toda a regra de negócio está separada do front-end, e feita no back-end, e o back-end está dentro de containers docker, aonde via API faz com que o front-end consiga consumir os serviços criados.


suas telas são:
    LOGIN, REGISTER: controle de USER(FUNCIONARIO, CLIENTE);
    PRODUCT: CRUD de produtos, clientes adicionar produtos ao seu carrinho de compra;
    CART: mostrar o que o cliente logado adicionou ao CART;
    ORDER: exibe compra realizada do cliente dos produtos que estavam no carrinho;

o arquivo .env no qual tem o item base_url é usado para  url da api

O nossos usuários são: Cliente e Funcionário,
onde Funcionário realiza CRUD de: funcionário e produto
e o Cliente pode inserir e remover produtos em seu carrinho de compra, e depois efetivar a compra dos produtos contidos no carrinho de compra



Nós acabamos não se atentando para "Economia de Energia", pois tivemos dificuldades técnicas com o Flutter.
Nós tivemos cuidado com "Segurança", todas as telas para ser acessadas precisam de um TOKEN, no qual é preciso estar logado para receber um TOKEN. A senha do usuário passa por uma função HASH para ser armazenada no banco de dados.
