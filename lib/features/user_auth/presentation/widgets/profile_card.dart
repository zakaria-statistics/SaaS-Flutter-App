import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final int sales;
  final String avatarImageUrl;
  final VoidCallback? onPressed;

  const ProfileCard({
    Key? key,
    required this.name,
    required this.sales,
    required this.avatarImageUrl,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return screenWidth > 2000 ?
        // M > 2000
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            width: 1,
            color:
            Colors.grey.withOpacity(0.5)),
      ),
      width: screenWidth * 0.19,
      height: screenHeight * 0.08,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context)
                .size
                .width *
                0.01,
          ),
          CircleAvatar(
            radius: MediaQuery.of(context)
                .size
                .height *
                0.018 +
                MediaQuery.of(context)
                    .size
                    .height *
                    0.018,
            backgroundImage: NetworkImage(
                avatarImageUrl),
          ),
          SizedBox(
            width: MediaQuery.of(context)
                .size
                .width *
                0.01,
          ),
          Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: themeData
                    .textTheme.bodySmall
                    ?.copyWith(
                    fontSize: MediaQuery.of(
                        context)
                        .size
                        .width *
                        0.009),
              ),
              Text(
                'Sales: $sales',
                style: themeData
                    .textTheme.bodySmall
                    ?.copyWith(
                    fontSize: MediaQuery.of(
                        context)
                        .size
                        .width *
                        0.009),
              ),
            ],
          ),
          SizedBox(
            width: screenWidth * 0.028,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(10),
                border: Border.all(
                    width:
                    screenHeight * 0.0012,
                    color: Colors.grey
                        .withOpacity(0.5))),
            child: TextButton(
              child: Text(
                'View',
                style: themeData
                    .textTheme.bodySmall
                    ?.copyWith(
                    fontSize: screenWidth *
                        0.009),
              ),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    ):

    (screenWidth <2000 && screenWidth > 1200) ?
        //---------------------1200 < M < 2000
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(0.5)),
      ),
      width: screenWidth * 0.24,
      height: screenHeight * 0.12,
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context)
                .size
                .height *
                0.018 +
                MediaQuery.of(context)
                    .size
                    .height *
                    0.018,
            backgroundImage: NetworkImage(
                avatarImageUrl),
          ),
          Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: themeData
                    .textTheme.bodySmall
                    ?.copyWith(
                    fontSize:
                    MediaQuery.of(context)
                        .size
                        .width *
                        0.012),
              ),
              Text(
                'Sales: $sales',
                style: themeData
                    .textTheme.bodySmall
                    ?.copyWith(
                    fontSize:
                    MediaQuery.of(context)
                        .size
                        .width *
                        0.012),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(10),
                border: Border.all(
                    width: screenHeight * 0.0012,
                    color: Colors.grey
                        .withOpacity(0.5))),
            child: TextButton(
              child: Text(
                'View',
                style: themeData
                    .textTheme.bodySmall
                    ?.copyWith(
                    fontSize:
                    screenWidth * 0.009),

              ),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    ):
//------------------------------M < 1200
      Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      width: screenWidth * 0.42,
      height: screenHeight * 0.11,
      child: Row(
        children: [
          SizedBox(width: screenWidth * 0.01),
          CircleAvatar(
            radius: screenHeight * 0.02 + screenHeight * 0.02,
            backgroundImage: NetworkImage(avatarImageUrl),
          ),
          SizedBox(width: screenWidth * 0.02),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: themeData.textTheme.bodySmall?.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.015,
                ),
              ),
              Text(
                'Sales: $sales',
                style: themeData.textTheme.bodySmall?.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.015,
                ),
              ),
            ],
          ),
          SizedBox(width: screenWidth * 0.06),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: screenHeight * 0.0012,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            child: TextButton(
              child: Text(
                'View',
                style: themeData.textTheme.bodySmall?.copyWith(
                  fontSize: screenWidth * 0.015,
                ),
              ),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
