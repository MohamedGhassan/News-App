import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import '../../../modules/web_view/web_view.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${article['title']}",
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Text(
                      "${article['publishedAt']}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Divider(
      color: Colors.grey,
    );

Widget articleBuilder(list, {isSearch = false}) => ConditionalBuilderRec(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator())
    );

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget defaultFormField2({
  TextEditingController? controller,
  required TextInputType textKeyboard,
  IconData? suffix,
  String helper = '',
  GestureTapCallback? onTaped,
  bool isPassword = false,
  IconData? prefix,
  ValueChanged<String>? onchange,
  ValueChanged<String>? onFieldSubmitted,
  FormFieldValidator<String>? validate,
  required String textLabel,
  VoidCallback? suffixPressed,
  TextInputType? type,
  String? label,
}) =>
    TextFormField(
      style: TextStyle(
        fontFamily: "Playfair Display",
        fontWeight: FontWeight.bold,
      ),
      validator: validate,
      controller: controller,
      keyboardType: textKeyboard,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        helperText: '$helper',
        labelText: textLabel,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
      ),
      onChanged: onchange,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTaped,
    );
