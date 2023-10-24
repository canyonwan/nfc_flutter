import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';

import '/app/models/advertisement_model.dart';

class AdPageView extends StatefulWidget {
  AdPageView({Key? key, required this.adList}) : super(key: key);

  late List<Advertisement> adList;
  @override
  _AdPageViewState createState() => _AdPageViewState();
}

class _AdPageViewState extends State<AdPageView> {
  // List<Advertisement> _adList = ;

  @override
  Widget build(BuildContext context) {
    return widget.adList.isNotEmpty
        ? SizedBox(
            height: 150,
            child: Swiper(
              key: UniqueKey(),
              itemCount: widget.adList.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.adList[index].img!),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
              pagination: const SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  activeColor: Colors.black,
                ),
              ),
              autoplay: true,
              onTap: (index) {
                print(index);
              },
            ))
        : Container();
  }
}
