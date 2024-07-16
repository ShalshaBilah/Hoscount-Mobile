class Plant {
  final int plantId;
  // final int price;
  // final String size;
  final double rating;
  // final int humidity;
  // final String temperature;
  final String category;
  final String plantName;
  final String imageURL;
  bool isFavorated;
  final String decription;
  // bool isSelected;

  Plant({
    required this.plantId,
    // required this.price,
    required this.category,
    required this.plantName,
    // required this.size,
    required this.rating,
    // required this.humidity,
    // required this.temperature,
    required this.imageURL,
    required this.isFavorated,
    required this.decription,
    // required this.isSelected
  });

  //List of Plants data
  static List<Plant> plantList = [
    Plant(
      plantId: 0,
      // price: 22,
      category: 'dr. Prawina Lindriawaty',
      plantName: 'Spesialis Penyakit Dalam',
      // size: 'Small',
      rating: 4.5,
      // humidity: 34,
      // temperature: '23 - 34',
      imageURL: 'assets/images/dokter1.png',
      isFavorated: true,
      decription:
          'Dokter ini adalah dokter spesialis penyakit dalam. Jam Kerja beliau dari hari senin-jumat jam 10.00.12.00. '
          'Beliau dokter yang cantik dan baik kepada pasiennya',
      // isSelected: false
    ),
    Plant(
      plantId: 1,
      // price: 11,
      category: 'dr. Muhammad Ali Asdar',
      plantName: 'Spesialis Paru',
      // size: 'Medium',
      rating: 4.8,
      // humidity: 56,
      // temperature: '19 - 22',
      imageURL: 'assets/images/dokter2.png',
      isFavorated: false,
      decription:
          'Dokter ini biasa dipanggil dokter Ali. Dia dokter spesialis paru yang sangat berpengelaman. Jam kerja dia hanya di hari Senin pukul 09.00-12.00.'
          'Beliau orang yang ganteng dan baik sama pasiennya',
      // isSelected: false
    ),
    Plant(
      plantId: 2,
      // price: 18,
      category: 'dr. Tiara Pramesya,Sp',
      plantName: 'Spesialis Neurologi',
      // size: 'Large',
      rating: 4.7,
      // humidity: 34,
      // temperature: '22 - 25',
      imageURL: 'assets/images/dokter3.png',
      isFavorated: false,
      decription:
          'Dokter ini biasa dipanggil dokter Tiara. Dia adalah dokter spesialis neurologi yang sudah banyak pengalaman.'
          'Jam kerja dia dari hari senin-jumat jam 13.00-14.00. Dia dokter yang manis',
      // isSelected: false
    ),
    Plant(
      plantId: 3,
      // price: 30,
      category: 'dr. Riyma Meilieza,Sp',
      plantName: 'Spesialis Anestesi',
      // size: 'Small',
      rating: 4.5,
      // humidity: 35,
      // temperature: '23 - 28',
      imageURL: 'assets/images/dokter4.png',
      isFavorated: false,
      decription:
          'Dokter ini biasa dipanggil dokter Riyma. Dia adalah dokter spesialis anestesi yang sudah banyak pengalaman.'
          'Jam kerja dia dari hari senin-jumat jam 15.00-16.00. Dia dokter yang ramah',
      // isSelected: false
    ),
    Plant(
      plantId: 4,
      // price: 24,
      category: 'dr. Muhammad Fajarulhuda',
      plantName: 'Dokter Umum',
      // size: 'Large',
      rating: 4.1,
      // humidity: 66,
      // temperature: '12 - 16',
      imageURL: 'assets/images/dokter5.png',
      isFavorated: true,
      decription:
          'Dokter ini biasa dipanggil dokter Fajar. Dia adalah dokter umum yang ramai dikunjungi oleh pasien.'
          'Jam kerja dia dari hari senin-jumat jam 13.00-14.00. Dia dokter yang perhatian pada pasiennya',
      // isSelected: false
    ),
    Plant(
      plantId: 5,
      // price: 24,
      category: 'dr. Johan',
      plantName: 'Spesialis Jantung',
      // size: 'Medium',
      rating: 4.4,
      // humidity: 36,
      // temperature: '15 - 18',
      imageURL: 'assets/images/dokter6.png',
      isFavorated: false,
      decription:
          'Dokter ini biasa dipanggil dokter Johan. Dia adalah dokter spesialis jantung yang sudah banyak pengalaman dalam menangani penyakit jantung.'
          'Jam kerja dia dari hari senin-jumat jam 11.00-13.00. Dia dokter yang ganteng dan perhatian.',
      // isSelected: false
    ),
    Plant(
      plantId: 6,
      // price: 19,
      category: 'dr. Ira Safitri',
      plantName: 'Spesialis Radiologi',
      // size: 'Small',
      rating: 4.2,
      // humidity: 46,
      // temperature: '23 - 26',
      imageURL: 'assets/images/dokter7.png',
      isFavorated: false,
      decription:
          'Dokter ini biasa dipanggil dokter Ira. Dia adalah dokter spesialis radiologi yang sudah banyak pengalaman.'
          'Jam kerja dia dari hari senin-kamis jam 13.00-14.00. Dia dokter yang manis',
      // isSelected: false
    ),
    Plant(
      plantId: 7,
      // price: 23,
      category: 'dr.Verina Logito',
      plantName: 'Spesialis Patologi Klinik',
      // size: 'Medium',
      rating: 4.5,
      // humidity: 34,
      // temperature: '21 - 24',
      imageURL: 'assets/images/dokter8.png',
      isFavorated: false,
      decription:
          'Dokter ini biasa dipanggil dokter Veri. Dia adalah dokter spesialis patologi klinik yang sudah banyak pengalaman.'
          'Jam kerja dia dari hari senin-jumat jam 09.00-11.00. Dia dokter yang manis dan cantik',
      // isSelected: false
    ),
    Plant(
      plantId: 8,
      // price: 46,
      category: 'dr. Rizal Irawan',
      plantName: 'Spesialis Bedah',
      // size: 'Medium',
      rating: 4.7,
      // humidity: 46,
      // temperature: '21 - 25',
      imageURL: 'assets/images/dokter9.png',
      isFavorated: false,
      decription:
          'Dokter ini biasa dipanggil dokter Rizal. Dia adalah dokter spesialis bedah yang sudah banyak pengalaman. Jadi tidak usah takut padanya'
          'Jam kerja dia dari hari senin-rabu jam 13.00-14.00. Dia dokter yang ganteng dan sangat berhati-hati',
      // isSelected: false
    ),
  ];

  //Get the favorated items
  static List<Plant> getFavoritedPlants() {
    List<Plant> travelList = Plant.plantList;
    return travelList.where((element) => element.isFavorated == true).toList();
  }

  // //Get the cart items
  // static List<Plant> addedToCartPlants() {
  //   List<Plant> selectedPlants = Plant.plantList;
  //   return selectedPlants
  //       .where((element) => element.isSelected == true)
  //       .toList();
  // }
}
