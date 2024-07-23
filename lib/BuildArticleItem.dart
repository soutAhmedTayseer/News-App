import 'package:flutter/material.dart';

Widget buildArticleItem(articles,context)=> InkWell(
  onTap: () {
    // navigateTo(context, Webviewscreen(articles['url']));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(
              image: NetworkImage('${articles['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: SizedBox(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                Expanded(
                  child: Text(
                    '${articles['title']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${articles['publishedAt']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
      ],
    ),
  ),
);

Widget myDivider() => const SizedBox(height: 5);
