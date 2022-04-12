class BillsHistory {
  String month, year, total;

  BillsHistory({this.month, this.year, this.total});

  static List<BillsHistory> getBillsHistory() {
    return [
      BillsHistory(
        month: 'February',
        year: '2022',
        total: '250.000'
      ),
      BillsHistory(
        month: 'January',
        year: '2022',
        total: '150.000'
      ),
      BillsHistory(
        month: 'December',
        year: '2021',
        total: '320.000'
      ),
      BillsHistory(
        month: 'November',
        year: '2021',
        total: '180.000'
      ),
      BillsHistory(
        month: 'October',
        year: '2021',
        total: '310.000'

      ),
    ];
  }
}
