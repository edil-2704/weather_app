
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonRow extends StatelessWidget {
  final String text;
  final String imageSelect;
  final String speedText;

  const CommonRow({
    super.key,
    required this.text,
    required this.imageSelect,
    required this.speedText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                imageSelect,
              ),
            ),
          ),
        ),
        Text(
          speedText,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

String dateConverter(int? date) {
  if (date != null) {
    var dt = DateTime.fromMillisecondsSinceEpoch(date * 1000);

    // 12 Hour format: // 12/31/2000, 10:00 PM
    var d12 = DateFormat('MM.dd.yyyy, hh:mm a').format(dt);

    // 24 Hour format: // 31/12/2000, 22:00
    var d24 = DateFormat('EEEE, d | HH:mm').format(dt);

    print(d12);

    return d24;
  } else {
    return '-';
  }
}

Color backgroundColorConverter(String description) {
  switch (description) {
    case 'clear sky':
      return Colors.blue.shade600;

    case 'few clouds':
    case 'overcast clouds':
    case 'scattered clouds':
      return Colors.grey.shade500;

    case 'broken clouds':
      return Colors.blueGrey.shade500;

    case 'shower rain':
      return Colors.grey.shade300;

    case 'rain':
      return Colors.blue.shade400;

    case 'thunderstorm':
      return Colors.deepPurple;

    case 'snow':
      return Colors.blueGrey.shade200;

    case 'mist':
      return Colors.grey.shade200;

    default:
      return Colors.deepOrange.shade300;
  }
}

String backgroundImageConverter(String description) {
  switch (description) {
    case 'clear sky':
    case 'few clouds':
    case 'mist':
      return 'assets/images/clear.png';

    case 'scattered clouds':
    case 'broken clouds':
      return 'assets/images/lightcloud.png';

    case 'shower rain':
      return 'assets/images/showers.png';

    case 'rain':
      return 'assets/images/lightrain.png';
    case 'thunderstorm':
      return 'assets/images/heavyrain.png';

    case 'snow':
      return 'assets/images/hail.png';

    default:
      return 'assets/images/clear.png';
  }
}
