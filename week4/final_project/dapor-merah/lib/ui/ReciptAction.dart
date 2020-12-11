import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_tags/flutter_tags.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import 'package:sayangdompet/bus.dart';
import 'package:sayangdompet/helpers/toast.dart';
import 'package:sayangdompet/helpers/api.dart';

class ReciptAction extends StatefulWidget {
  @override
  _ReciptActionState createState() => _ReciptActionState();
}

class _ReciptActionState extends State<ReciptAction> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  TextEditingController _titleController = TextEditingController();
  // TextEditingController _amountController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Resep'),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Judul Resep *',
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
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        children: [
                          _image == null
                              ? Text('Tidak ada gambar di pilih *')
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.file(
                                      _image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          FlatButton.icon(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29),
                            ),
                            onPressed: getImage,
                            label: Text('Pilih gambar'),
                            icon: Icon(Icons.upload_sharp),
                          )
                        ],
                      ),
                    ),
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
                      if (newCategory != "" &&
                          !_categories.contains(newCategory)) {
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
                          onPressed: _submit,
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
        ],
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

  void _submit() async {
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
