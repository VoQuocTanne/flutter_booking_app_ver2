import 'package:flutter/material.dart';
import 'package:flutter_hotel_booking_ver2/constants/helper.dart';
import 'package:flutter_hotel_booking_ver2/constants/text_styles.dart';
import 'package:flutter_hotel_booking_ver2/constants/themes.dart';
import 'package:flutter_hotel_booking_ver2/language/app_localizations.dart';
import 'package:flutter_hotel_booking_ver2/widgets/common_card.dart';
import 'package:flutter_hotel_booking_ver2/widgets/list_cell_animation_view.dart';
import 'package:get/get.dart';
import 'package:hotel_repository/hotel_repository.dart';
import 'package:intl/intl.dart';

class HotelListViewPage extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final Hotel hotelData; // Thay đổi kiểu thành Hotel
  final AnimationController animationController;
  final Animation<double> animation;

  const HotelListViewPage({
    Key? key,
    required this.hotelData,
    required this.animationController,
    required this.animation,
    required this.callback,
    this.isShowDate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "vi_VN");
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: CommonCard(
          color: AppTheme.backgroundColor,
          child: ClipRRect(
            child: AspectRatio(
              aspectRatio: 2.7,
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 0.90,
                        child: hotelData.imagePath != null
                            ? Image.network(
                                hotelData.imagePath!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/placeholder.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width >= 360
                                  ? 12
                                  : 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                hotelData.hotelName,
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style:
                                    TextStyles(context).getBoldStyle().copyWith(
                                          fontSize: 16,
                                        ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                hotelData.hotelAddress,
                                style: TextStyles(context)
                                    .getDescriptionStyle()
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Helper.ratingStar(),
                                        ],
                                      ),
                                    ),
                                    FittedBox(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              "${(oCcy.format(num.parse(hotelData.perNight)))}₫",
                                              textAlign: TextAlign.left,
                                              style: TextStyles(context)
                                                  .getBoldStyle()
                                                  .copyWith(fontSize: 22),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: Get.find<Loc>().isRTL
                                                      ? 2.0
                                                      : 0.0),
                                              child: Text(
                                                Loc.alized.per_night,
                                                style: TextStyles(context)
                                                    .getDescriptionStyle()
                                                    .copyWith(
                                                      fontSize: 14,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      onTap: () {
                        try {
                          callback();
                        } catch (_) {}
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}