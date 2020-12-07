import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:flutter_tags/flutter_tags.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:async';

import 'package:sayangdompet/bus.dart';
import 'package:sayangdompet/helpers/toast.dart';
import 'package:sayangdompet/helpers/api.dart';

class TransactionAction extends StatefulWidget {
  @override
  _TransactionActionState createState() => _TransactionActionState();
}

class _TransactionActionState extends State<TransactionAction> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  String _type = 'in';
  TextEditingController _titleController = TextEditingController();
  // TextEditingController _amountController = TextEditingController();
  MoneyMaskedTextController _amountController =
      MoneyMaskedTextController(leftSymbol: 'Rp. ');

  TextEditingController _descriptionController = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  List _categories = <String>[];
  List _categoriesSuggestion = <String>[];

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tambah Transaksi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: FlatButton.icon(
                      color: Colors.white,
                      textColor: _type == 'in' ? Colors.red : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        setState(() => _type = 'in');
                      },
                      label: Text('Masuk'),
                      icon: Icon(Icons.arrow_circle_down_outlined),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: FlatButton.icon(
                      color: Colors.white,
                      textColor: _type == 'out' ? Colors.red : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        setState(() => _type = 'out');
                      },
                      label: Text('Keluar'),
                      icon: Icon(Icons.arrow_circle_up_sharp),
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Judul Transaksi *',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: (String arg) {
                  if (arg == '')
                    return 'Judul tidak boleh kosong';
                  else
                    return null;
                },
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Nominal Transaksi *',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                keyboardType: TextInputType.number,
                validator: (String arg) {
                  if (arg == '')
                    return 'Jumlah Transaksi tidak boleh kosong';
                  else
                    return null;
                },
              ),
              SizedBox(height: 5),
              SimpleAutoCompleteTextField(
                key: key,
                decoration: InputDecoration(
                  labelText: 'Kategori',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  helperMaxLines: 3,
                  helperText:
                      'Silahkan pilih kategori yang tersedia / ketik manual untuk membuat kategori baru, lalu tekan enter',
                ),
                suggestions: _categoriesSuggestion,
                clearOnSubmit: true,
                textSubmitted: (newCategory) => setState(() {
                  if (newCategory != "" && !_categories.contains(newCategory)) {
                    _categories.add(newCategory);
                  }
                }),
              ),
              SizedBox(height: 20),
              Tags(
                itemCount: _categories.length,
                itemBuilder: (int index) {
                  final item = _categories[index];
                  return ItemTags(
                    activeColor: Colors.red,
                    key: Key(index.toString()),
                    index: index, // required
                    title: item,
                    pressEnabled: false,
                    removeButton: ItemTagsRemoveButton(
                      onRemoved: () {
                        setState(() {
                          _categories.removeAt(index);
                        });
                        return true;
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.red,
                      textColor: Colors.white,
                      label: Text('Simpan'),
                      icon: Icon(Icons.save),
                      onPressed: _submitTransaction,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: FlatButton.icon(
                      label: Text('Batal'),
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getCategories() {
    callApi().get('/category/list').then((response) {
      List _tmpCategories = <String>[];
      response.data['categories']
          .forEach((category) => _tmpCategories.add(category['name']));
      // print(_tmpCategories);
      setState(() {
        _categoriesSuggestion.addAll(_tmpCategories);
        print(_tmpCategories);
      });
      // print(_tmpCategories);
    });
  }

  void _submitTransaction() async {
    if (!_formKey.currentState.validate()) {
      showToast(
        type: 'error',
        message: 'Silahkan isi dengan benar',
      );
    } else {
      if (!_isLoading) {
        setState(() => _isLoading = true);
        try {
          await callApi().post('/transaction/action', data: {
            'title': _titleController.text,
            'type': _type,
            'amount': _amountController.text,
            'description': _descriptionController.text,
            'categories': _categories,
          }).then((response) {
            showToast(
              type: response.data['status'] ? 'success' : 'error',
              message: (response.data['status'] ? 'Sukses' : 'Gagal') +
                  ' Menyimpan Transaksi',
            );

            if (response.data['status']) {
              eventBus.fire(TransactionListRefresh());
              Timer(Duration(seconds: 1), () {
                Navigator.pop(context);
              });
            }
          });
        } finally {
          setState(() => _isLoading = false);
        }
      }
    }
  }
}
