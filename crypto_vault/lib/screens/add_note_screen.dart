import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:encrypt/encrypt.dart' as enc;

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/models/note.dart';
import 'package:crypto_vault/providers/local_auth.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  FocusNode _contentFocusNode;

  @override
  void initState() {
    _contentFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _contentFocusNode.dispose();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _onNoteSave(BuildContext ctx) {
    if (_titleController.text == '' || _contentController.text == '') {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Title and Note are required')),
      );
      return;
    }

    String masterPw32 = Provider.of<LocalAuth>(context, listen: false).masterPw;
    if (masterPw32.length > 32) {
      masterPw32 = masterPw32.substring(0, 32);
    }

    int masterPw32Len = masterPw32.length;
    for (int i = 0; i < (32 - masterPw32Len); ++i) {
      masterPw32 += '=';
    }

    final key = enc.Key.fromUtf8(masterPw32);
    final iv = enc.IV.fromSecureRandom(16);

    final encrypter = enc.Encrypter(enc.AES(key));

    final _encryptedContent = encrypter.encrypt(_contentController.text, iv: iv);

    final noteBox = Hive.box<Note>('notes');

    noteBox.put(
      _titleController.text,
      Note(
        title: _titleController.text,
        encryptedContent: _encryptedContent.base64,
        iv: iv.base64,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorLight,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.headline6.color,
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () => _onNoteSave(context),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 72,
            color: backgroundColorLight,
            padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
            child: TextField(
              style: TextStyle(
                fontSize: 32,
                color: Theme.of(context).textTheme.headline6.color,
              ),
              maxLines: 1,
              decoration: InputDecoration(
                hintText: 'Title...',
                hintStyle: TextStyle(
                  fontSize: 32,
                  color: Theme.of(context).textTheme.bodyText2.color,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              cursorColor: Theme.of(context).textTheme.headline6.color,
              controller: _titleController,
              onSubmitted: (value) {
                _contentFocusNode.requestFocus();
              },
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline6.color,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Notes...',
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                  border: InputBorder.none,
                ),
                cursorColor: Theme.of(context).textTheme.headline6.color,
                focusNode: _contentFocusNode,
                controller: _contentController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
