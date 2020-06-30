import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final double elevation; //阴影
  final Widget leading;
  final String hintText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final IconData prefixIcon;
  final List<TextInputFormatter> inputFormatters;
  final VoidCallback onEditingComplete;
  final Color backgroundColor;
  final Color color;

  const SearchAppBarWidget({
    Key key,
    this.height: 46.0,
    this.elevation: 0.5,
    this.leading,
    this.hintText: '请输入关键词',
    this.focusNode,
    this.controller,
    this.inputFormatters,
    this.onEditingComplete,
    this.prefixIcon: Icons.search,
    this.backgroundColor,
    this.color,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new SearchAppBarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(height); //这里设置控件（appBar）的高度
}

class SearchAppBarState extends State<SearchAppBarWidget> {
  bool _hasdeleteIcon = false;

  Widget buildAppBar(
    BuildContext context,
    String text, {
    double fontSize: 18.0,
    double height: 46.0,
    double elevation: 0.5,
    Widget leading,
    bool centerTitle: false,
    Color backgroundColor,
  }) {
    return new PreferredSize(
      child: new AppBar(
        elevation: elevation, //阴影
        centerTitle: centerTitle,
        title: Text(text, style: TextStyle(fontSize: fontSize)),
        leading: leading,
        backgroundColor: backgroundColor,
      ),
      preferredSize: Size.fromHeight(height),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new PreferredSize(
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: false,
            child: buildAppBar(
              context,
              '',
              leading: widget.leading,
              backgroundColor: widget.backgroundColor,
            ),
          ),
          new Offstage(
            offstage: false,
            child: SafeArea(
              child: Container(
                // padding: const EdgeInsets.only(left: 30.0, top: 26.0),
                child: new TextField(
                  focusNode: widget.focusNode,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: widget.controller,
                  maxLines: 1,
                  inputFormatters: widget.inputFormatters,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: widget.color,
                      fontSize: 16.5,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 24.0),
                      child: Icon(
                        widget.prefixIcon,
                        color: widget.color,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 2.0,
                        end: _hasdeleteIcon ? 20.0 : 0,
                      ),
                      child: _hasdeleteIcon
                          ? new InkWell(
                              onTap: (() {
                                setState(() {
                                  widget.controller.text = '';
                                  _hasdeleteIcon = false;
                                });
                              }),
                              child: Icon(
                                Icons.clear,
                                size: 18.0,
                                color: widget.color,
                              ),
                            )
                          : new Text(''),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                  ),
                  onChanged: (str) {
                    setState(() {
                      if (str.isEmpty) {
                        _hasdeleteIcon = false;
                      } else {
                        _hasdeleteIcon = true;
                      }
                    });
                  },
                  onEditingComplete: widget.onEditingComplete,
                ),
              ),
            ),
          )
        ],
      ),
      preferredSize: Size.fromHeight(widget.height),
    );
  }
}
