import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/blocs/cart_bloc/api_cubit.dart';
import 'package:flutter_bloc_learning/blocs/cart_bloc/cart_cubit.dart';
import 'package:flutter_bloc_learning/models/movie_model.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => ApiCubitPriceList()),
      BlocProvider(create: (_) => CartBloc())
    ], child: const HomePageView());
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ApiCubitPriceList>().callFromApi();
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Каталог', style: TextStyle(fontSize: 20.sp)),
          actions: [
            BlocBuilder<CartBloc, List<Movie>>(
                builder: (context, state) => badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -10, end: -12),
                      showBadge: true,
                      ignorePointer: false,
                      onTap: () {},
                      badgeContent: state.isNotEmpty
                          ? const Icon(Icons.check, color: Colors.white, size: 10)
                          : Container(),
                      badgeAnimation: const badges.BadgeAnimation.rotation(
                        animationDuration: Duration(seconds: 1),
                        colorChangeAnimationDuration: Duration(seconds: 1),
                        loopAnimation: false,
                        curve: Curves.fastOutSlowIn,
                        colorChangeAnimationCurve: Curves.easeInCubic,
                      ),
                      child: const Icon(Icons.shopping_cart),
                    ))
          ],
        ),
        body: RefreshIndicator(
            onRefresh: () async =>
                context.read<ApiCubitPriceList>().callFromApi(),
            child: Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: 2.h),
                    BlocBuilder<ApiCubitPriceList, List<Movie>>(
                        builder: (context, state) {
                      if (state.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    mainAxisExtent: 40.h),
                            itemCount: state.length,
                            itemBuilder: (context, index) {
                              print(state[index].title);
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  horizontalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(0, 5),
                                                blurRadius: 7,
                                                color: Colors.grey[300]!),
                                            BoxShadow(
                                                offset: const Offset(-7, 0),
                                                blurRadius: 7,
                                                color: Colors.grey[300]!)
                                          ]),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15.h,
                                            child: ProgressiveImage(
                                              // size: 1.87KB
                                              thumbnail: NetworkImage(
                                                  'https://image.tmdb.org/t/p/w500${state[index].backdropPath}'),
                                              // size: 1.29MB
                                              image: NetworkImage(
                                                  'https://image.tmdb.org/t/p/w500${state[index].backdropPath}'),
                                              height: 300.h,
                                              width: 500.w,
                                              placeholder: const AssetImage(
                                                  'assets/Placeholder_view_vector.jpg'),
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                          Text('${state[index].title}'),
                                          Text(
                                              'Описание: ${state[index].overview}',
                                              overflow: TextOverflow.ellipsis),
                                          Expanded(child: Container()),
                                          ButtonsAdd(state: state, index: index)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                    })
                  ]),
            )));
  }
}

class ButtonsAdd extends StatelessWidget {
  final List<Movie> state;
  final int index;
  const ButtonsAdd({Key? key, required this.state, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, List<Movie>>(builder: (context, cart) {
      var bloc = context.watch<CartBloc>();
      if (cart.any((el) => el.id == state[index].id)) {
        return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.pink)),
              onPressed: () => bloc.deleteFromCart(state[index]),
              child: const Text('Удалить'))
        ]);
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () => bloc.addQtyFunc(state[index]),
                child: const Text('Добавить')),
          ],
        );
      }
    });
  }
}
