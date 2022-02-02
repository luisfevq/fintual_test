import 'dart:math';

void main() {
  /*
      Construct a simple Portfolio class that has a collection of Stocks and a 
      "Profit" method that receives 2 dates and returns the profit of the Portfolio 
      between those dates. Assume each Stock has a "Price" method that receives a date 
      and returns its price.

      Bonus Track: make the Profit method return the "annualized return" of the 
      portfolio between the given dates.
    */
  Portfolio portfolio = Portfolio();

  print(portfolio.getStockPrice(DateTime(2022, 2, 2)));
  print(portfolio.profit(
    dateFrom: DateTime(2022, 2, 1),
    dateTo: DateTime(2022, 2, 3),
  ));
}

class Stock {
  Stock({this.date, this.revenue, this.expenses});

  DateTime? date;
  double? revenue;
  double? expenses;

  String getPrice(DateTime date) {
    Stock result = Portfolio().stocksList!.firstWhere(
          (stock) => stock.date == date,
          orElse: () => Stock(revenue: 0.0),
        );
    return "Stock: \$${result.revenue!}";
  }
}

class Portfolio {
  Portfolio();

  List<Stock>? stocksList = [
    Stock(date: DateTime(2022, 2, 1), revenue: 100.0, expenses: 50),
    Stock(date: DateTime(2022, 2, 2), revenue: 150.0, expenses: 80),
    Stock(date: DateTime(2022, 2, 3), revenue: 200.0, expenses: 20),
    Stock(date: DateTime(2022, 2, 4), revenue: 250.0, expenses: 10),
  ];

  getStockPrice(DateTime date) => Stock().getPrice(date);

  String profit({DateTime? dateFrom, DateTime? dateTo}) {
    //stocksList -> return profit (beneficio)

    List<Stock> match = stocksList!
        .where(
          (stck) =>
              stck.date!.compareTo(dateFrom!) >= 0 &&
              stck.date!.compareTo(dateTo!) <= 0,
        )
        .toList();

    //Total Revenue - Total Expenses = Profit
    double totalRevenue = 0.0;
    double totalExpenses = 0.0;
    String result = "";

    match.forEach((m) {
      totalRevenue += m.revenue!;
      totalExpenses += m.expenses!;
    });

    //(( Revenue - Cost of goods) / Revenue)*100.
    double resultPercent =
        (((totalRevenue - totalExpenses) / totalRevenue) * 100);
    result = (totalRevenue - totalExpenses).toString() +
        " (${resultPercent.toStringAsFixed(2)}%)";

    // Annualized
    var annual = _annualizedCalc(match);

    return "Profit: \$$result \nAnnualized: $annual";
  }

  _annualizedCalc(List<Stock> match) {
    /*
    The annualized return formula: 
    ((ending / beginning) ^ (1 / number month)) - 1
   */

    double firstOperation = match.last.revenue! / match.first.revenue!;
    double exponent = 1 / match.length;
    num powOperation = pow(firstOperation, exponent) - 1;

    return "${(powOperation * 100).toStringAsFixed(2)}%";
  }
}
