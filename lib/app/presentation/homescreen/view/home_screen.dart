import 'dart:ui';
import 'package:fda/cubit/search_cubit.dart';
import 'package:fda/model/FavoriteModel.dart';
import 'package:fda/model/Listler.dart';
import 'package:fda/model/drugsinfo.dart';
import 'package:fda/model/medicaldevicemodel.dart';
import 'package:fda/model/recall_model.dart';
import 'package:fda/model/tobaccomodel.dart';
import 'package:fda/model/vacmodel.dart';
import 'package:fda/view/homescreen/drawer/custom_drawer.dart';
import 'package:fda/enum/category_type.dart' as my_cat;
import 'package:fda/viewmodel/home_view_model.dart';
import 'package:fda/viewmodel/searchviewmodel.dart';

import 'package:fda/widgets/featuredcard.dart';
import 'package:fda/view/homescreen/widgets/newscard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fda/cubit/pageviewcubit.dart';
import '../../model/news_model.dart';
import 'package:fda/widgets/_categoryBox.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel = HomeViewModel();
  late final PageController _pageController;
  late final List<NewsModel> newsList;

  List<Vacmodel> vaccinesList = [];
  List<TobaccoReport> tobaccoList = [];
  List<MedicalDeviceModel> deviceList = [];
  List<RecallModel> recallList = [];
  List<DrugInfo> drugList = [];

  late List<FavoriteItem> allFavorites = [];
  SearchCubit? searchCubit;

  bool isLoading = true;

  late final HomeScrollCubit _homeScrollCubit;

  @override
  void initState() {
    super.initState();

    _homeScrollCubit = HomeScrollCubit();

    _pageController = PageController(viewportFraction: 0.7);
    _pageController.addListener(() {
      _homeScrollCubit.updateScrollPosition(_pageController.page ?? 0.0);
    });

    newsList = viewModel.getNewsList();

    loadAllData();
  }

  Future<void> loadAllData() async {
    final searchViewModel = Searchviewmodel();

    vaccinesList = await searchViewModel.fetchVaccines();
    print("Vaccines loaded: ${vaccinesList.length}");

    tobaccoList = await searchViewModel.fetchTobaccos();
    print("Tobacco reports loaded: ${tobaccoList.length}");

    deviceList = await searchViewModel.fetchDevices();
    print("Devices loaded: ${deviceList.length}");

    recallList = await searchViewModel.fetchRecalls();
    print("Recalls loaded: ${recallList.length}");

    drugList = await searchViewModel.fetchDrugs();
    print("Drugs loaded: ${drugList.length}");

    allFavorites = combineAllFavorites(
      vaccines: vaccinesList,
      tobaccos: tobaccoList,
      devices: deviceList,
      recalls: recallList,
      drugs: drugList,
    );
    print("All favorites combined: ${allFavorites.length}");

    searchCubit = SearchCubit(allFavorites);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _homeScrollCubit.close();
    searchCubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final featuredNews = newsList.isNotEmpty ? newsList[0] : null;
    if (isLoading || searchCubit == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _homeScrollCubit),
        BlocProvider.value(value: searchCubit!),
      ],
      child: Scaffold(
        drawer: const CustomDrawer(),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 25, 66, 100),
                const Color.fromARGB(255, 106, 34, 119),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Üst kısım: Padding’li alan
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    MediaQuery.of(context).padding.top,
                    16,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'FDA News',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.search, color: Colors.white),
                                  onPressed: () {
                                    showGeneralDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      barrierLabel: "Dismiss",
                                      barrierColor: Colors.black.withOpacity(
                                        0.4,
                                      ),
                                      transitionDuration: Duration(
                                        milliseconds: 200,
                                      ),
                                      pageBuilder: (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) {
                                        return BlocProvider.value(
                                          value: searchCubit!,
                                          child: Builder(
                                            builder: (context) {
                                              return SafeArea(
                                                child: Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      top:
                                                          MediaQuery.of(
                                                            context,
                                                          ).padding.top +
                                                          100,
                                                      left: 20,
                                                      right: 20,
                                                    ),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              16,
                                                            ),
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                                sigmaX: 18,
                                                                sigmaY: 18,
                                                              ),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                  16,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                    0.85,
                                                                  ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    16,
                                                                  ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                TextField(
                                                                  autofocus:
                                                                      true,
                                                                  onChanged: (
                                                                    query,
                                                                  ) {
                                                                    final cubit =
                                                                        BlocProvider.of<
                                                                          SearchCubit
                                                                        >(
                                                                          context,
                                                                        );
                                                                    cubit
                                                                        .search(
                                                                          query,
                                                                        );
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    hintText:
                                                                        "Search...",
                                                                    prefixIcon:
                                                                        Icon(
                                                                          Icons
                                                                              .search,
                                                                        ),
                                                                    border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            12,
                                                                          ),
                                                                    ),
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 12,
                                                                ),
                                                                BlocBuilder<
                                                                  SearchCubit,
                                                                  SearchState
                                                                >(
                                                                  builder: (
                                                                    context,
                                                                    state,
                                                                  ) {
                                                                    if (state
                                                                        .results
                                                                        .isEmpty) {
                                                                      return Text(
                                                                        "No results found",
                                                                      );
                                                                    }
                                                                    return SizedBox(
                                                                      height:
                                                                          300, // Maksimum yükseklik ver
                                                                      child: ListView.builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount:
                                                                            state.results.length,
                                                                        itemBuilder: (
                                                                          context,
                                                                          index,
                                                                        ) {
                                                                          final item =
                                                                              state.results[index];
                                                                          return ListTile(
                                                                            title: Text(
                                                                              item.title ??
                                                                                  "No Title",
                                                                            ),
                                                                            subtitle: Text(
                                                                              item.category ??
                                                                                  "",
                                                                            ),
                                                                            onTap: () {
                                                                              // Seçim veya detay
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                Builder(
                                  builder: (context) {
                                    return IconButton(
                                      icon: Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (featuredNews != null)
                        FeaturedCard(news: featuredNews),
                      SizedBox(height: 15),
                      Text(
                        "News",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),

                // 🔸 PageView kısmı (padding yok!)
                SizedBox(
                  height: 240,
                  child: BlocBuilder<HomeScrollCubit, double>(
                    builder: (context, currentPage) {
                      return PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: newsList.length,
                        itemBuilder: (context, index) {
                          final distance = (index - currentPage).abs();
                          final scale = (1 - distance * 0.1).clamp(0.8, 1.0);
                          final opacity = (1 - distance * 0.5).clamp(0.5, 1.0);
                          final translateY = distance * 20;

                          return Transform.translate(
                            offset: Offset(0, translateY),
                            child: Transform.scale(
                              scale: scale,
                              child: Opacity(
                                opacity: opacity,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: SizedBox(
                                    width: 80,
                                    child: NewsCard(news: newsList[index]),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // 🔹 Alt kısım: tekrar padding ile devam
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 35, 16, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                            255,
                            126,
                            88,
                            158,
                          ).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Products We Regulate",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: Wrap(
                          alignment: WrapAlignment.center, // <-- ÖNEMLİ
                          spacing: 12,
                          runSpacing: 20,
                          children:
                              my_cat.Category.values
                                  .map(
                                    (category) =>
                                        categoryBox(category, context),
                                  )
                                  .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
