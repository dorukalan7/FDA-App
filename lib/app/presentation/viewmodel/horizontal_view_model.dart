import '../../common/model/news_model.dart';

class HomeViewModel {
  List<NewsModel> getNewsList() {
    return [
      NewsModel(
        title: 'FDA Approves New Drug',
        description: 'A new medication for heart disease has been approved.',
        imageUrl:
            'https://www.fda.gov/files/newdrugtherapiesreport_1600x900.png',
        url:
            'https://www.fda.gov/news-events/press-announcements/fda-takes-action-address-data-integrity-concerns-two-chinese-third-party-testing-firms',
      ),
      NewsModel(
        title: 'Vaccine Updates',
        description: 'Latest COVID-19 vaccine results released.',
        imageUrl:
            'https://www.fda.gov/files/FDA%20approves%20first%20COVID-19%20vaccine_FINAL.png',
        url: 'https://www.fda.gov/news-events',
      ),
      NewsModel(
        title: 'Drug Problems',
        description: 'Drug problem results released.',
        imageUrl:
            'https://cdn.britannica.com/05/213705-050-4331A79A/drug-concept-drug-abuse-addition-heroin-injection-doping-opium-epidemic.jpg',
        url: 'https://www.fda.gov/drugs',
      ),
    ];
  }
}
