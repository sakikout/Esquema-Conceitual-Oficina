# Esquema Conceitual Oficina

Este repositório possui o modelo do desafio da DIO para o desenvolvimento de um banco de dados de um sistema de controle de gerenciamento e execução de ordens de serviço em uma oficina mecânica.

## Descrição do Projeto Conceitual 
- Clientes levam veículos à oficina mecânica para serem consertados ou para passarem por revisões  periódicas
- Cada veículo é designado a uma equipe de mecânicos que identifica os serviços a serem executados e preenche uma OS com data de entrega.
- A partir da OS, calcula-se o valor de cada serviço, consultando-se uma tabela de referência de mão-de-obra
- O valor de cada peça também irá compor a OSO cliente autoriza a execução dos serviços
- A mesma equipe avalia e executa os serviços
- Os mecânicos possuem código, nome, endereço e especialidade
- Cada OS possui: n°, data de emissão, um valor, status e uma data para conclusão dos trabalhos.

# Considerações Finais
O modelo EER foi desenvolvido utilizando o [MySQL Workbench](https://www.mysql.com/products/workbench/), além de ter sido feito unicamente por mim.
