import 'package:fda/app/common/enum/category_type.dart';
import 'package:fda/app/common/model/MenuItem.dart';
import 'package:flutter/material.dart';

List<MenuItem> featuredItems = [
  MenuItem(
    icon: Icons.star,
    title: 'FDA Approves New Drug',
    url: 'https://www.fda.gov/news-events/fda-approves-new-drug', // örnek URL
  ),
  MenuItem(icon: Icons.favorite, title: 'Favorites'),
];

List<MenuItem> productItems = [
  MenuItem(icon: Icons.fastfood, title: 'Foods', category: Category.Foods),
  MenuItem(
    icon: Icons.local_pharmacy,
    title: 'Drugs',
    category: Category.Drugs,
  ),
  MenuItem(
    icon: Icons.medical_services,
    title: 'Medical Devices',
    category: Category.MedicalDevices,
  ),
  MenuItem(
    icon: Icons.wifi_protected_setup,
    title: 'Radition-Emiting',
    category: Category.RadiationEmittingProducts,
  ),
  MenuItem(
    icon: Icons.vaccines,
    title: 'Vacines,blooding and biologics',
    category: Category.VaccinesBloodBiologics,
  ),
  MenuItem(
    icon: Icons.pets,
    title: 'Animal and Veteriny',
    category: Category.AnimalVeterinary,
  ),
  MenuItem(icon: Icons.brush, title: 'Cosmetics', category: Category.Cosmetics),
  MenuItem(
    icon: Icons.smoking_rooms,
    title: 'TobaccoProducts',
    category: Category.TobaccoProducts,
  ),
];

List<MenuItem> topicItems = [
  MenuItem(
    icon: Icons.topic,
    title: 'About FDA',
    url: 'https://www.fda.gov/about-fda',
  ),
  MenuItem(
    icon: Icons.topic,
    title: 'Combination Products',
    url: 'https://www.fda.gov/combination-products',
  ),
  MenuItem(
    icon: Icons.topic,
    title: 'Regulatory Information',
    url: 'https://www.fda.gov/regulatory-information',
  ),
  MenuItem(
    icon: Icons.topic,
    title: 'Safety',
    url: 'https://www.fda.gov/safety',
  ),
  MenuItem(
    icon: Icons.topic,
    title: 'Emergency Preparedness',
    url: 'https://www.fda.gov/emergency-preparedness',
  ),
];

List<MenuItem> infoItems = [
  MenuItem(
    icon: Icons.person_outline,
    title: 'Consumers',
    url: 'https://www.fda.gov/consumers',
  ),
  MenuItem(
    icon: Icons.local_hospital,
    title: 'Patients',
    url: 'https://www.fda.gov/patients',
  ),
  MenuItem(
    icon: Icons.business_center,
    title: 'Industry',
    url: 'https://www.fda.gov/industry',
  ),
];
