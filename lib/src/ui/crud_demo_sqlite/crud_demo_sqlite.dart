import 'package:flutter/material.dart';
import 'package:movie_app/src/utils/helpers/crud_sql_helper.dart';

class CrudDemoSqlite extends StatefulWidget {
  const CrudDemoSqlite({
    super.key,
  });

  @override
  State<CrudDemoSqlite> createState() => _CrudDemoSqliteState();
}

class _CrudDemoSqliteState extends State<CrudDemoSqlite> {
  List<Map<String, dynamic>> _journals = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
    print("...number of items ${_journals.length}");
  }

  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text, _descriptionController.text);
    _refreshJournals();
    print("...number of items ${_journals.length}");
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _titleController.text, _descriptionController.text);
    _refreshJournals();
    print("...number of items ${_journals.length}");
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
    print("...number of items ${_journals.length}");
  }

  void _showForm(int? id) async {
    //below for updating our item and submit it
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 110),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(hintText: 'Description'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (id == null) {
                          await _addItem();
                        }
                        if (id != null) {
                          _updateItem(id);
                        }
                        //clearing the text fields
                        _titleController.text = '';
                        _descriptionController.text = '';

                        //close the bottom sheet
                        Navigator.of(context).pop();
                      },
                      child: Text(id == null ? 'Create New' : 'Update'))
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQL"),
      ),
      body: ListView.builder(
          itemCount: _journals.length,
          itemBuilder: (context, index) => Card(
                color: Colors.blue.shade50,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(_journals[index]['title']),
                  subtitle: Text(_journals[index]['description']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () => _showForm(_journals[index]['id']),
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () =>
                                _deleteItem(_journals[index]['id']),
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ),
                ),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm(null);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
