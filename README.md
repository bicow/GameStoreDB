# GameStore - Sistema de Gerenciamento de E-commerce de Periféricos Gamer

## Descrição do Projeto

**GameStore** é um projeto acadêmico de banco de dados relacional desenvolvido em SQL Server que simula o sistema de uma loja virtual especializada em periféricos gamer (teclados mecânicos, mouses, headsets, etc.).

O objetivo principal é gerenciar:
- Cadastro de clientes, produtos, fornecedores e marcas
- Controle de estoque
- Registro e acompanhamento de pedidos
- Emissão de notas fiscais dos pedidos

---

## Estrutura do Banco de Dados

### Tabelas Criadas

- `Cliente` - Cadastro de clientes
- `Fornecedor` - Fornecedores dos produtos
- `MarcaProduto` - Marcas (ex: Razer, Logitech)
- `CategoriaProduto` - Categorias (Teclado, Mouse, Headset...)
- `Produto` - Catálogo de produtos
- `QuantidadeEstoque` - Controle de estoque por produto
- `Transporte` - Opções de entrega
- `Pedido` - Pedidos realizados
- `ItensPedido` - Itens de cada pedido
- `NotaPedido` - Nota fiscal associada ao pedido

---

## Script Completo

Todo o código SQL (criação do banco, tabelas, inserts, consultas, updates e deletes) está disponível no arquivo:
[`gamestore.sql`](gamestore.sql)

---

## Consultas Úteis Incluídas

- Listar produtos com marca e categoria
- Valor total de cada pedido
- Produtos com estoque baixo (< 20 unidades)
- Clientes que fizeram mais de um pedido
- Pedidos ordenados por data
- Atualização de preços e estoque
- Exclusão segura de registros

---

## Tecnologias Utilizadas

- SQL Server (T-SQL)
- Modelo Relacional
- Chaves primárias com `IDENTITY`
- Relacionamentos com `FOREIGN KEY`

---

## Como Executar

1. Abra o SQL Server Management Studio (SSMS)
2. Crie um novo banco ou use um existente
3. Execute o script completo `gamestore.sql` na ordem apresentada

> O banco será criado automaticamente com o comando `CREATE DATABASE GameStore;`
