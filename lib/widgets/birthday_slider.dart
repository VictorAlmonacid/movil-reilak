import 'package:flutter/material.dart';

class BirthdaySlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 165,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cumpleaños',
                  style: TextStyle(fontSize: 20, color: Color(0xFF9146FF), fontWeight: FontWeight.bold),
                ),
                Icon(Icons.cake, color: Color(0xFF9146FF)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (_, int index) => _BirthdayItem()),
          ),
        ],
      ),
    );
  }
}

class _BirthdayItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 100,
      // color: Colors.blue,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage(
                placeholder: AssetImage('assets/logo.png'),
                image: NetworkImage(
                    'https://facesymmetry.fun/images/person/sergio-ramos.jpg'),
                width: 85,
                height: 85,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            'Yonathan Esteban Soto Martinez',
            textAlign: TextAlign.center,style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
