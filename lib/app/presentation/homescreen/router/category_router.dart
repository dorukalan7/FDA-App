import 'package:fda/app/presentation/drugspage/view/DrugsPage.dart';
import 'package:fda/app/presentation/medicaldevice/view/MedicalDevicespage.dart';
import 'package:fda/app/presentation/tobaccopage/view/TobaccoPage.dart';
import 'package:fda/app/presentation/animalveteriny/view/animalveteriny.dart';
import 'package:fda/app/presentation/cosmetics/view/cosmetics.dart';
import 'package:fda/app/presentation/foodspage/view/foodpage.dart';
import 'package:fda/app/presentation/radition/view/radiation.dart';
import 'package:fda/app/presentation/vaccines/view/vaccinespage.dart';
import 'package:flutter/material.dart';
import 'package:fda/app/common/enum/category_type.dart';

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
