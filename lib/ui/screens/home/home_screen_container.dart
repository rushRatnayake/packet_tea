import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packet_tea/bloc/core/dashboard/dashboard_bloc.dart';
import 'package:packet_tea/data/models/dashboard_model.dart';
import 'package:packet_tea/ui/screens/common_widgets/generic_error_message.dart';
import 'package:packet_tea/ui/themes/appColors.dart';

class HomeScreenContainer extends StatelessWidget {
  const HomeScreenContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _createBlocProviders(context),
      child: Builder(
        builder: (context) {
          return _buildChild(context);
        },
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      cubit: BlocProvider.of<DashboardBloc>(context),
      builder: (BuildContext context, DashboardState state) {
        if (state is DashboardInitial || state is DashboardInProgressState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DashboardSuccessState) {
          if (state.dashboard == null) {
            return GenericErrorMessageWidget();
          } else {
            return _buildSections(context, state.dashboard);
          }
        } else {
          assert(state is DashboardFailedState);
          return GenericErrorMessageWidget();
        }
      },
    );
  }

  List<BlocProvider> _createBlocProviders(final BuildContext context) {
    return [
      BlocProvider<DashboardBloc>(
        create: (context) {
          final bloc = DashboardBloc();
          bloc.add(DashboardFetchEvent());
          return bloc;
        },
      ),
    ];
  }

  Widget _buildSections(BuildContext context, DashboardModel dashboardData) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AccountBalance(
            accountBalance: dashboardData.totalBalance,
          ),
          SizedBox(
            height: 20,
          ),
          OptionItems(),
          SizedBox(
            height: 20,
          ),
          PieChartSample2(
            spent: (dashboardData.totalDebitedAmount /
                (dashboardData.totalDebitedAmount +
                        dashboardData.totalCreditedAmount))*100,
            income:( dashboardData.totalCreditedAmount /
                (dashboardData.totalDebitedAmount +
                        dashboardData.totalCreditedAmount)
          )*100,
          ),
          SizedBox(
            height: 20,
          ),
          ManureAmount(
            monthlyManure: dashboardData.monthlyManureTotal,
          ),
          SizedBox(
            height: 20,
          ),
          LoanAmount(
            monthlyLoan: dashboardData.monthlyLoanTotal,
          )
        ],
      ),
    );
  }
}

class AccountBalance extends StatelessWidget {
  final String accountBalance;

  const AccountBalance({
    Key key,
    this.accountBalance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0, color: AppColors.appGreen2.withOpacity(0.3))
          ],
          color: AppColors.appGreen1.withOpacity(0.9),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Balance",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  this.accountBalance + " LKR",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: AppColors.white, letterSpacing: 1.5),
                )
              ],
            ),
            Icon(
              Icons.account_balance,
              size: 40,
              color: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}

class ManureAmount extends StatelessWidget {
  final String monthlyManure;

  const ManureAmount({
    Key key,
    this.monthlyManure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0, color: AppColors.appGreen2.withOpacity(0.3))
          ],
          color: AppColors.whitishGreen.withOpacity(1),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Manure Requested",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  "$monthlyManure KG",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: AppColors.white, letterSpacing: 1.5),
                )
              ],
            ),
            Icon(
              Icons.line_style,
              size: 40,
              color: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}

class LoanAmount extends StatelessWidget {
  final String monthlyLoan;

  const LoanAmount({
    Key key,
    this.monthlyLoan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0, color: AppColors.appGreen2.withOpacity(0.3))
          ],
          color: AppColors.whitishGreen2.withOpacity(0.9),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Loan Amount",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  "$monthlyLoan LKR",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: AppColors.white, letterSpacing: 1.5),
                )
              ],
            ),
            Icon(
              Icons.monetization_on_outlined,
              size: 40,
              color: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}

class PieChartSample2 extends StatefulWidget {
  final double income;
  final double spent;

  const PieChartSample2({
    Key key,
    @required this.income,
    @required this.spent,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0, color: AppColors.grey.withOpacity(0.5))
            ],
            color: AppColors.naturalLightGreen),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.2,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          final desiredTouch = pieTouchResponse.touchInput
                                  is! PointerExitEvent &&
                              pieTouchResponse.touchInput is! PointerUpEvent;
                          if (desiredTouch &&
                              pieTouchResponse.touchedSection != null) {
                            touchedIndex = pieTouchResponse
                                .touchedSection.touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 25,
                      sections: showingSections()),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: AppColors.shadesGreen2,
                  text: 'Income',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: AppColors.red,
                  text: 'Spent',
                  isSquare: true,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.shadesGreen2,
            value: this.widget.income,
            title: this.widget.income.toStringAsFixed(1),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.red.withOpacity(0.9),
            value: this.widget.spent,
            title: this.widget.spent.toStringAsFixed(1),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}

class OptionItems extends StatefulWidget {
  @override
  _OptionItemsState createState() => _OptionItemsState();
}

class _OptionItemsState extends State<OptionItems> {
  final itemTitles = [
    "Manure\nRequest",
    "Loan\nRequest",
  ];
  final itemIcons = [
    Icons.library_add_rounded,
    Icons.library_add_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemTitles.length,
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: 3),
        itemBuilder: (BuildContext context, int index) => OptionItem(
          title: itemTitles[index],
          icon: itemIcons[index],
        ),
      ),
    );
  }
}

class OptionItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const OptionItem({Key key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(blurRadius: 5.0, color: AppColors.grey.withOpacity(0.5))
          ],
          color: Colors.white),
      width: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            this.icon,
            color: AppColors.appGreen1,
            size: 30,
          ),
          SizedBox(height: 5),
          Text(
            this.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appGreen1,
                ),
          )
        ],
      ),
    );
  }
}
