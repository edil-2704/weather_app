import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/use_cases/weather_use_case.dart';
import 'package:weather_app/features/weather/presentation/logic/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/screens/weather_info_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    final WeatherBloc bloc = WeatherBloc(
      weatherUseCase: WeatherUseCase(
        weatherRepository: WeatherRepositoryImpl(),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Search screen'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 203, 158, 255),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                      ),
                      onPressed: () {
                      controller.clear();
                      },
                    ),
                    hintText: 'Type your city',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 5,
                      ),
                    ),
                  ),
                ),
                BlocListener<WeatherBloc, WeatherState>(
                  bloc: bloc,
                  listener: (context, state) {
                    showLoader(state is WeatherLoadingState);

                    if (state is WeatherLoadedState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherInfoScreen(
                            weatherModel: state.weatherModel,
                          ),
                        ),
                      );
                    }

                    if (state is WeatherErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.error.message.toString(),
                          ),
                        ),
                      );
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please type your city'),
                          ),
                        );
                      }
                      bloc.add(
                        GetWeatherEvent(location: controller.text),
                      );
                    },
                    child: Text('Search'),

                  ),
                ),
                SizedBox(height: 60),
                Text(
                  'Weather Search',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Lottie.asset(
                  'assets/images/sunny.json',
                  height: 300,
                  width: 400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showLoader(bool showLoader) {
  if (showLoader) {
    EasyLoading.show();
  } else {
    EasyLoading.dismiss();
  }
}
