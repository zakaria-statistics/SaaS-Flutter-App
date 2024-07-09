import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/products_bloc.dart';
import '../../../../bloc/routing_bloc.dart';
import '../../../../utils/path_util.dart';
 // Replace with your actual import

class NavItem extends StatefulWidget {
  final IconData icon;
  final RoutingEvent routingEvent;
  final ProductEvent? productEvent;
  final int id;
  final String title;
  final String path;

  const NavItem({
    Key? key,
    required this.icon,
    this.productEvent,
    required this.routingEvent,
    required this.id,
    required this.title,
    required this.path,
  }) : super(key: key);

  @override
  _NavItemState createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<RoutingBloc, RoutingState>(
      builder: (context, state) {
        final bool isSelected = state.headerItem.id == widget.id;

        return InkWell(
          borderRadius: BorderRadius.circular(100),
          onHover: (hovering) {
            setState(() {
              isHovered = hovering;
            });
          },
          onTap: () {
            if(widget.productEvent is AllProductsEvent) {
              context.read<ProductBloc>().add(widget.productEvent!);
            }
            context.read<RoutingBloc>().add(widget.routingEvent);
            updateUrl(widget.path);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: screenHeight * 0.03,
                color: isSelected || isHovered
                    ? Colors.white.withOpacity(0.9)
                    : Colors.white.withOpacity(0.7),
              ),
              Text(
                widget.title,
                style: TextStyle(
                  color: isSelected || isHovered
                      ? Colors.white.withOpacity(0.9)
                      : Colors.white.withOpacity(0.7),
                  fontWeight: isSelected || isHovered ? FontWeight.bold : FontWeight.normal,
                  fontSize: screenHeight * 0.018,
                ),
              ),
              SizedBox(height: screenHeight * 0.001),
              Visibility(
                maintainAnimation: true,
                maintainState: true,
                maintainSize: true,
                visible: isSelected || isHovered,
                child: Container(
                  height: screenHeight * 0.003,
                  width: screenWidth * 0.023,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
