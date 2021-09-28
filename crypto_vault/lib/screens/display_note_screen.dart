import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:hive/hive.dart';
import 'package:encrypt/encrypt.dart' as enc;

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/models/note.dart';

class DisplayNoteScreen extends StatefulWidget {
  final Note note;
  final String masterPw;

  DisplayNoteScreen({@required this.note, @required this.masterPw});

  @override
  _DisplayNoteScreenState createState() => _DisplayNoteScreenState();
}

class _DisplayNoteScreenState extends State<DisplayNoteScreen> {
  bool _isInEditMode = false;
  bool _isFavourite;

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    _isFavourite = widget.note.isFavourite;
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.getDecryptedContent(widget.masterPw);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _onNoteUpdate(BuildContext ctx) {
    if (_titleController.text == '' || _contentController.text == '') {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Title and Note are required')),
      );
      return;
    }

    String masterPw32 = widget.masterPw;
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

    final _encryptedContent =
        encrypter.encrypt(_contentController.text, iv: iv);

    final noteBox = Hive.box<Note>('notes');
    final noteModel = Note(
      title: _titleController.text,
      encryptedContent: _encryptedContent.base64,
      iv: iv.base64,
    );
    noteModel.isFavourite = _isFavourite;

    noteBox.delete(widget.note.title);
    noteBox.put(
      _titleController.text,
      noteModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _titleWidget;
    Widget _contentWidget;

    if (_isInEditMode) {
      _titleWidget = TextField(
        style: TextStyle(
          fontSize: 32,
          color: Theme.of(context).textTheme.headline6.color,
        ),
        maxLines: 1,
        decoration: InputDecoration(
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
      );
      _contentWidget = TextField(
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
        controller: _contentController,
      );
    } else {
      _titleWidget = Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Text(
          widget.note.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 32,
            color: Theme.of(context).textTheme.headline6.color,
            fontFamily: 'Proxima Nova',
          ),
        ),
      );
      _contentWidget = Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Text(
          widget.note.getDecryptedContent(widget.masterPw),
          style: TextStyle(
            color: Theme.of(context).textTheme.headline6.color,
            fontFamily: 'Proxima Nova',
            fontSize: 16,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorLight,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).textTheme.headline6.color,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actionsIconTheme: IconThemeData(
          color: Theme.of(context).textTheme.headline6.color,
        ),
        elevation: 0,
        actions: <Widget>[
          if (!_isInEditMode)
            IconButton(
              icon: Icon(
                _isFavourite ? Icons.star : Icons.star_border,
              ),
              onPressed: () {
                setState(() {
                  _isFavourite = !_isFavourite;
                });
                _onNoteUpdate(context);
              },
            ),
          if (!_isInEditMode)
            IconButton(
              icon: Icon(Icons.edit_outlined),
              onPressed: () {
                setState(() {
                  _isInEditMode = true;
                });
              },
            ),
          if (!_isInEditMode)
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: Text('Delete?'),
                    content: Text('Do you wish to delete this note?'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text("NO"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text("YES"),
                        isDefaultAction: true,
                        onPressed: () {
                          Hive.box<Note>('notes').delete(widget.note.title);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          if (_isInEditMode)
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                _onNoteUpdate(context);
                setState(() {
                  _isInEditMode = false;
                });
              },
            ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 72,
            width: double.infinity,
            color: backgroundColorLight,
            padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
            child: _titleWidget,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _contentWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
