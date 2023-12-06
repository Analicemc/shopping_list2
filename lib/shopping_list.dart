import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<ShoppingItem> _items = [];
  double _totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Compras'),
        ),
        body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return _buildShoppingListItem(_items[index]);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addItem();
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: _buildTotalSection(_totalPrice));
  }

  Widget _buildShoppingListItem(ShoppingItem item) {
    return Column(
      children: [
        ListTile(
          title: Text(
            item.description,
            style: TextStyle(
              decoration: item.isBought ? TextDecoration.lineThrough : null,
              color: item.isBought ? Colors.grey : Colors.black,
            ),
          ),
          subtitle: Text('Quantidade: ${item.quantity}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                iconSize: 20,
                onPressed: () {
                  _editItem(item);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                iconSize: 20,
                color: Colors.red,
                onPressed: () {
                  _showDeleteConfirmationDialog(item);
                },
              ),
              Checkbox(
                value: item.isBought,
                onChanged: (value) {
                  _updateItemStatus(item);
                },
              ),
            ],
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
        ),
      ],
    );
  }

  void _addItem() async {
    TextEditingController descriptionController = TextEditingController();
    TextEditingController quantityController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Item'),
        content: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantidade'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _items.add(
                  ShoppingItem(
                    description: descriptionController.text,
                    quantity: int.parse(quantityController.text),
                  ),
                );
              });
              Navigator.pop(context);
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(ShoppingItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmação"),
          content: Text(
              "Tem certeza de que deseja remover o item ${item.description}?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                _removeItem(item);
                Navigator.pop(context); // Fecha o diálogo
              },
              child: Text("Confirmar"),
            ),
          ],
        );
      },
    );
  }

  void _removeItem(ShoppingItem item) {
    setState(() {
      _totalPrice -= item.price;
      _items.remove(item);
    });
  }

  void _updateItemStatus(ShoppingItem item) async {
    TextEditingController priceController = TextEditingController();

    if (item.isBought) {
      setState(() {
        _totalPrice -= item.price;
        item.isBought = false;
        item.price = 0;
      });
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Informar Preço: ${item.description}"),
        content: TextField(
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Preço'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                item.isBought = true;
                item.price = double.parse(priceController.text);
                _totalPrice += item.price;
              });
              Navigator.pop(context);
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _editItem(ShoppingItem item) async {
    TextEditingController descriptionController =
        TextEditingController(text: item.description);
    TextEditingController quantityController =
        TextEditingController(text: item.quantity.toString());
    TextEditingController priceController =
        TextEditingController(text: item.price.toString());

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Item'),
        content: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantidade'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Preço'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                item.description = descriptionController.text;
                item.quantity = int.parse(quantityController.text);
                item.price = double.parse(priceController.text);
              });
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection(double _totalPrice) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total da compra: R\$ $_totalPrice'),
        ],
      ),
    );
  }
}
