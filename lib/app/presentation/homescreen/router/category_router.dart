import 'package:fda/view/drugspage/DrugsPage.dart';
import 'package:fda/view/medicaldevice/MedicalDevicespage.dart';
import 'package:fda/view/tobaccopage/TobaccoPage.dart';
import 'package:fda/view/animalveteriny/animalveteriny.dart';
import 'package:fda/view/cosmetics/cosmetics.dart';
import 'package:fda/view/foodspage/foodpage.dart';
import 'package:fda/view/radition/radiation.dart';
import 'package:fda/view/vaccines/vaccinespage.dart';
import 'package:flutter/material.dart';
import 'package:fda/enum/category_type.dart';

void navigateToCategoryPage(
  Category category,
  BuildContext context,
  String title,
  String imageUrl,
) {
  Widget page;

  switch (category) {
    case Category.Foods:
      page = FoodsPage(title: title, imageUrl: imageUrl);
      break;
    case Category.Drugs:
      page = DrugsPage(title: title, imageUrl: imageUrl);
      break;
    case Category.MedicalDevices:
      page = Medicaldevicespage(title: title, imageUrl: imageUrl);
      break;
    case Category.VaccinesBloodBiologics:
      page = Vaccinespage(title: title, imageUrl: imageUrl);
      break;
    case Category.TobaccoProducts:
      page = Tobaccopage(title: title, imageUrl: imageUrl);
      break;
    case Category.AnimalVeterinary:
      page = Animalveteriny(title: title, imageUrl: imageUrl);
      break;
    case Category.RadiationEmittingProducts:
      page = Radiationpage(title: title, imageUrl: imageUrl);
      break;
    case Category.Cosmetics:
      page = Cosmetics(title: title, imageUrl: imageUrl);
      break;
  }

  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}
