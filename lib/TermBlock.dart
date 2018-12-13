import 'package:flutter/material.dart';
import 'package:twfoodtranslations/dictionary.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermBlock extends StatelessWidget {
  TermBlock(this.term, this.query);
  final Term term;
  final String query;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(term.imagePath != null ? term.imagePath : "icons/ban.png",
              width: 300.0, height: 200.0),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _highlight(term.term, query),
              Text(term.pinYin),
              Container(
                width: 300,
                child: MarkdownBody(
                  data: term.translation,
                  onTapLink: (href) {
                    _onTapLink(context, href);
                  },
                ),
              )
            ],
          ))
        ]);
  }

  _highlight(String text, String query) {
    return RichText(
        text: TextSpan(
            children: text.split('').map((t) {
      if (query.contains(t)) {
        return TextSpan(
            text: t, style: TextStyle(fontSize: 25.0, color: Colors.black));
      } else {
        return TextSpan(
            text: t, style: TextStyle(color: Colors.black45, fontSize: 25.0));
      }
    }).toList()));
  }

  void _onTapLink(BuildContext context, String href) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final popupTerm = Dictionary.firstWhere((term) => term.term == href);
          return AlertDialog(
            content: TermBlock(popupTerm, popupTerm.term),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}