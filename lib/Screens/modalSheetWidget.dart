import 'package:flutter/material.dart';
import 'package:password_generator/Constants/rotateTextStyle.dart';
import 'package:password_generator/saving&deleting//save_note.dart';
import 'package:provider/provider.dart';

class ModalSheetWidget extends StatefulWidget {
  final String password;
  ModalSheetWidget(this.password);

  @override
  _ModalSheetWidgetState createState() => _ModalSheetWidgetState();
}

class _ModalSheetWidgetState extends State<ModalSheetWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final saveProvider = Provider.of<Save>(context);
    DateTime _dateTime = DateTime.now();
    String dateTime = _dateTime.toString().substring(0, 10);

    return Container(
      height: 250,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          RichText(
              text: TextSpan(
                  text: "Password: \n",
                  style: smallText,
                  children: <TextSpan>[
                TextSpan(
                  text: "${widget.password}\n",
                  style: TextStyle(color: Colors.pink, fontSize: 22),
                ),
              ])),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "  Website/Application Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(color: Colors.pink)),
                  fillColor: Colors.white,
                ),
                validator: (value) =>
                    value.isEmpty ? 'This cannot be left blank' : null,
              ),
            ),
          ),
          // ignore: deprecated_member_use
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.deepPurple),
            child: FlatButton(
              onPressed: () async {
                print(_controller.text);
                if (_formKey.currentState.validate()) {
                  print('Form is valid');
                  saveProvider.saveNote(_controller.text, widget.password, dateTime);
                  Navigator.pop(context);
                } else {
                  print('Form is invalid');
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SF'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
