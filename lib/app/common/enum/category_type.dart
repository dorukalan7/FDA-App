enum Category {
  Foods,
  Drugs,
  MedicalDevices,
  RadiationEmittingProducts,
  VaccinesBloodBiologics,
  AnimalVeterinary,
  Cosmetics,
  TobaccoProducts,
}

extension CategoryExtension on Category {
  String get title {
    switch (this) {
      case Category.Foods:
        return 'Foods';
      case Category.Drugs:
        return 'Drugs';
      case Category.MedicalDevices:
        return 'Medical Devices';
      case Category.RadiationEmittingProducts:
        return 'Radiation-Emitting Products';
      case Category.VaccinesBloodBiologics:
        return 'Vaccines, Blood, and Biologics';
      case Category.AnimalVeterinary:
        return 'Animal and Veterinary';
      case Category.Cosmetics:
        return 'Cosmetics';
      case Category.TobaccoProducts:
        return 'Tobacco Products';
    }
  }

  String get imageUrl {
    switch (this) {
      case Category.Foods:
        return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNxc0pEndLAcfJdQRrjWSNSn1b9ZPF7n-XDQ&s";
      case Category.Drugs:
        return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJZguE9-YaseGxnB5QP32GkwGIjdeV_m6vPQ&s";
      case Category.MedicalDevices:
        return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb7moMyac33t-ONIJtx4gRWu_2zP-quCkm5g&s";
      case Category.RadiationEmittingProducts:
        return "https://www.registrarcorp.com/wp-content/uploads/2025/05/Medical-Device-Radiation-Emitting-Electronic-Products-1024x576.jpg";
      case Category.VaccinesBloodBiologics:
        return "https://www.fda.gov/files/styles/featured_content_background_image/public/Blood%20Cell%20Research%20Testing%20Lab.jpeg?itok=4foQ3Csq";
      case Category.AnimalVeterinary:
        return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnM3yRnNtLRzN-Skh51YAA8M0M211PniKMQpaCv1kcY2kH8cq6YqbJChK10mNlkc60L14&usqp=CAU";
      case Category.Cosmetics:
        return "https://www.fdli.org/wp-content/uploads/2020/05/The-Regulation-of-Cosmetics-scaled.jpeg";
      case Category.TobaccoProducts:
        return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuvBaCU2McbLpZVk7w_xKIEwZFVMHK6VckWg&s";
    }
  }
}
