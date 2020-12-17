import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tags/flutter_tags.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import 'package:DaporMerah/bus.dart';
import 'package:DaporMerah/helpers/toast.dart';
import 'package:DaporMerah/helpers/api.dart';

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
  List<TextEditingController> _ingredients = [];
  List<TextEditingController> _steps = [];

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
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informasi Resep',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Judul Resep',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            controller: _titleController,
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bahan - bahan',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: _ingredients.length,
                            itemBuilder: (BuildContext context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.book_outlined),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _ingredients.removeAt(index);
                                            });
                                          },
                                          color: Colors.red,
                                          icon: Icon(Icons.delete_outlined),
                                        ),
                                        hintText: 'Masukan bahan',
                                      ),
                                      controller: _ingredients[index],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          FlatButton.icon(
                            onPressed: () {
                              setState(() {
                                _ingredients.add(TextEditingController());
                              });
                            },
                            textColor: Colors.blue,
                            icon: Icon(Icons.add),
                            label: Text('Tambah bahan'),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Langakah - langkah',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: _steps.length,
                            itemBuilder: (BuildContext context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.book_outlined),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _steps.removeAt(index);
                                            });
                                          },
                                          color: Colors.red,
                                          icon: Icon(Icons.delete_outlined),
                                        ),
                                        hintText: 'Masukan Langkah',
                                      ),
                                      controller: _steps[index],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          FlatButton.icon(
                            onPressed: () {
                              setState(() {
                                _steps.add(TextEditingController());
                              });
                            },
                            textColor: Colors.blue,
                            icon: Icon(Icons.add),
                            label: Text('Tambah langkah pengerjaan'),
                          )
                        ],
                      ),
                    ),
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
          await callApi()
              .post('/recipe/action',
                  data: FormData.fromMap({
                    'title': _titleController.text,
                    'categories': _categories,
                    'description': _descriptionController.text,
                    'image': await MultipartFile.fromFile(
                      _image.path,
                      filename: _image.path.split('/').last,
                    ),
                    'steps': _steps.map((step) => step.text).toList(),
                    'ingredients': _ingredients
                        .map((ingredient) => ingredient.text)
                        .toList()
                  }))
              .then((response) {
            showToast(
              type: response.data['status'] ? 'success' : 'error',
              message: (response.data['status'] ? 'Sukses' : 'Gagal') +
                  ' Menyimpan Menyimpan resep',
            );

            if (response.data['status']) {
              eventBus.fire(RecipeListRefresh());
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
