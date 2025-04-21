import 'chat_controller.dart';

final List<String> pakistaniCities = [
  'Islamabad',
  'Karachi',
  'Lahore',
  'Peshawar',
  'Quetta',
  'Faisalabad',
  'Rawalpindi',
  'Multan',
  'Gujranwala',
  'Hyderabad',
];

final List<String> foodCategories = [
  'Biryani',
  'BBQ',
  'Karahi',
  'Pulao',
  'Haleem',
  'Nihari',
  'Fast Food',
  'Chinese',
];

final Map<String, Map<String, List<Restaurant>>> recommendations = {
  'Islamabad': {
    'Biryani': [
      Restaurant(
        name: 'Mirchi 360',
        specialty: 'Hyderabadi and Matka biryani',
        location: 'F-10 Markaz',
        highlight: 'Served in clay pots with aromatic spices',
        rating: 4.5,
      ),
      Restaurant(
        name: 'Chaman Biryani',
        specialty: 'Authentic Karachi-style biryani',
        location: 'Blue Area',
        highlight: 'Run by Karachi native, consistent quality',
        rating: 4.3,
      ),
    ],
    'BBQ': [
      Restaurant(
        name: 'Savour Foods',
        specialty: 'Chicken Tikka and Seekh Kabab',
        location: 'Blue Area',
        highlight: 'Famous for their spicy marinade',
        rating: 4.4,
      ),
    ],
  },
  'Karachi': {
    'Biryani': [
      Restaurant(
        name: 'Student Biryani',
        specialty: 'Hyderabadi Biryani',
        location: 'Multiple Locations',
        highlight: 'Consistent quality across branches',
        rating: 4.6,
      ),
      Restaurant(
        name: 'Al Rehman Biryani',
        specialty: 'Sindhi Biryani',
        location: 'Burns Road',
        highlight: 'Authentic local flavor',
        rating: 4.7,
      ),
    ],
  },
  'Lahore': {
    'Biryani': [
      Restaurant(
        name: 'Waqas Biryani',
        specialty: 'Mutton Biryani',
        location: 'Panorama Center',
        highlight: 'Famous for intense aroma',
        rating: 4.6,
      ),
    ],
    'BBQ': [
      Restaurant(
        name: 'Butt Karahi',
        specialty: 'Chicken Karahi',
        location: 'MM Alam Road',
        highlight: 'Open late night',
        rating: 4.8,
      ),
    ],
  },
};
