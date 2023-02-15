import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/service/location.dart';
import 'package:weatherapp/service/service.dart';

class CurrentPage extends StatefulWidget {
  const CurrentPage({Key? key}) : super(key: key);

  @override
  State<CurrentPage> createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  Current? currentData;
  LocationHelper? locationData;
  bool isLoading = true;
  bool day = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getLocation() async {
    locationData = LocationHelper();
    await locationData?.getCurrentLocation();
  }

  Future<void> getData() async {
    isLoading = !isLoading;
    await getLocation();
    isNight();
    setState(() {});
    currentData = await Service(locationHelper: locationData!).getCurrent();
    isLoading = !isLoading;
    setState(() {});
  }

  void isNight() {
    var now = DateTime.now();
    print('object');
    print(now);
    now.hour >= 1 ? day = false : day = true;
  }

  Weather? currentWeather;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(day ? 'assets/images/sky.jpg' : 'assets/images/night.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Weather APP'),
            actions: [IconButton(onPressed: () => getData(), icon: const Icon(Icons.refresh))]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: isLoading
                ? RefreshIndicator(
                    onRefresh: () => getData(),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          currentData?.name ?? 'Konum',
                          style: GoogleFonts.roboto(color: day ? Colors.black : Colors.white, fontSize: 42),
                        ),
                        const SizedBox(height: 10),
                        weatherConditions(currentData!.weather!.first.main!),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentData?.main?.temp.toString() ?? 'null',
                              style: GoogleFonts.openSans(color: day ? Colors.grey : Colors.white, fontSize: 24),
                            ),
                            const Icon(Icons.thermostat)
                          ],
                        ),
                        Text(
                          currentData?.weather?.first.description ?? 'null',
                          style: GoogleFonts.openSans(color: day ? Colors.black45 : Colors.white, fontSize: 18),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'nem :${currentData?.main?.humidity}',
                                  style: GoogleFonts.openSans(color: day ? Colors.grey : Colors.white, fontSize: 18),
                                ),
                                const Icon(Icons.water_drop_outlined)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'hissedilen : ${currentData?.main?.temp}',
                                  style: GoogleFonts.openSans(color: day ? Colors.grey : Colors.white, fontSize: 18),
                                ),
                                const Icon(Icons.person_add_alt_1)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  // Gelen hava durumuna göre image gösterimi
  Widget weatherConditions(String condition) {
    print(condition);
    String image = condition;
    String imagePath = 'assets/images/$image.png';
    // String imagePath = 'assets/images/a.png';

    return SizedBox(
        height: 250,
        child: Image.asset(
          imagePath,
          fit: BoxFit.fitWidth,
        ));
  }
}
